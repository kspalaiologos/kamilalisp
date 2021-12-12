package kamilalisp.libs;

import com.google.common.collect.Iterators;
import com.google.common.collect.Lists;
import com.google.common.collect.Streams;
import com.google.common.io.Resources;
import com.google.common.primitives.Chars;
import kamilalisp.api.Evaluation;
import kamilalisp.data.*;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.*;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicReference;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import java.util.stream.Stream;

public class CoreLib {
    public static void install(Environment env) {
        env.push("lambda", new Atom(new Macro() {
            @Override
            public Atom apply(Executor outerEnv, List<Atom> arguments) {
                List<Atom> params; Atom code;
                if(arguments.size() != 2 || arguments.get(0).getType() != Type.LIST)
                    throw new Error("Invalid invocation to `lambda`.");
                params = arguments.get(0).getList().get(); code = arguments.get(1);
                if(params.stream().anyMatch(x -> x.getType() != Type.STRING))
                    throw new Error("Invalid lambda argument name.");
                Atom result = new Atom(new Closure() {
                    @Override
                    public String representation() {
                        return "(λ " + params.stream().map(x -> x.getString().get()).collect(Collectors.joining(" ")) + " . " + code.toString() + ")";
                    }

                    @Override
                    public List<Atom> requote() {
                        return List.of(new Atom(params), code);
                    }

                    @Override
                    public Atom apply(Executor env, List<Atom> innerArgs) {
                        Environment newEnv = outerEnv.env.descendant("Lambda expression");
                        newEnv.owner = new Atom(this);
                        // process optional arguments.
                        long optional = Lists.reverse(params).stream().takeWhile(x -> x.getString().get().startsWith("?")).count();
                        if(optional != Lists.reverse(params).stream().filter(x -> x.getString().get().startsWith("?")).count())
                            throw new Error("Misplaced optional lambda argument in parameter list.");
                        // evaluate parameters.
                        if(innerArgs.size() > params.size() || innerArgs.size() < params.size() - optional)
                            throw new Error("Invalid invocation to a lambda expression.");
                        for(int i = 0; i < params.size() - optional; i++) {
                            newEnv.push(params.get(i).getString().get(), innerArgs.get(i));
                        }
                        // process optional arguments.
                        for(int i = 0; i < optional; i++) {
                            String name = params.get((int) (params.size() - optional + i)).getString().get().substring(1);
                            if(i + params.size() - optional < innerArgs.size())
                                newEnv.push(name, innerArgs.get((int) (i + params.size() - optional)));
                            else
                                newEnv.push(name, Atom.NULL);
                        }
                        Executor lambdaExecutor = new Executor(newEnv);
                        return lambdaExecutor.evaluate(code);
                    }
                });
                return result;
            }
        }));

        env.push("import", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to `import`.");
                arguments.get(0).guardType("Argument to 'import'", Type.STRING_CONSTANT);
                String name = arguments.get(0).getStringConstant().get().get();
                String code;
                if(name.startsWith("!")) {
                    name = name.substring(1);
                    try {
                        code = Resources.toString(Resources.getResource("kamilalisp/" + name), StandardCharsets.UTF_8);
                    } catch (Exception e) {
                        throw new Error("Could not read standard library file '" + name + "'.");
                    }
                } else {
                    try {
                        code = Files.readString(Path.of(arguments.get(0).getStringConstant().get().get()));
                    } catch(Exception e) {
                        throw new Error("Could not read file '" + arguments.get(0).getStringConstant().get().get() + "'.");
                    }
                }
                Evaluation.evalString(env.env, code);
                return Atom.NULL;
            }
        }));

        env.push("fork", new Atom(new Macro() {
            @Override
            public Atom apply(Executor env, List<Atom> tmp) {
                // #(f g h) <=> (f (g ...) (h ...))
                // #(f g) <=> (f (g ...))
                return new Atom(new Closure() {
                    @Override
                    public Atom apply(Executor innerEnv, List<Atom> arguments) {
                        return new Atom(new LbcSupplier<>(() -> {
                            Atom first = env.evaluate(tmp.get(0));
                            first.guardType("fork head", Type.CLOSURE, Type.MACRO);
                            List<Atom> forkData = tmp.subList(1, tmp.size()).stream().map(x -> {
                                Atom a = env.evaluate(x);
                                a.guardType("fork child", Type.CLOSURE, Type.MACRO);
                                return a.getCallable().get().apply(innerEnv, arguments);
                            }).collect(Collectors.toList());
                            return first.getCallable().get().apply(innerEnv, forkData).get().get();
                        }));
                    }
                });
            }
        }));

        env.push("atop", new Atom(new Macro() {
            @Override
            public Atom apply(Executor env, List<Atom> components) {
                return new Atom(new Closure() {
                    @Override
                    public Atom apply(Executor innerEnv, List<Atom> arguments) {
                        return new Atom(new LbcSupplier<>(() -> {
                            Atom x = env.evaluate(components.get(0)).getCallable().get().apply(innerEnv, arguments);
                            for(int i = 1; i < components.size(); i++)
                                x = env.evaluate(components.get(i)).getCallable().get().apply(innerEnv, List.of(x));
                            return x.get().get();
                        }));
                    }
                });
            }
        }));

        env.push("macro", new Atom(new Macro() {
            @Override
            public Atom apply(Executor outerEnv, List<Atom> arguments) {
                List<Atom> params; Atom code;
                if(arguments.size() != 2 || arguments.get(0).getType() != Type.LIST)
                    throw new Error("Invalid invocation to `macro`.");
                params = arguments.get(0).getList().get(); code = arguments.get(1);
                if(params.stream().anyMatch(x -> x.getType() != Type.STRING))
                    throw new Error("Invalid macro argument name.");
                Atom result = new Atom(new Closure() {
                    @Override
                    public String representation() {
                        return "(macro " + params.stream().map(x -> x.getString().get()).collect(Collectors.joining(" ")) + " . " + code.toString() + ")";
                    }

                    @Override
                    public List<Atom> requote() {
                        return List.of(new Atom(params), code);
                    }

                    @Override
                    public Atom apply(Executor env, List<Atom> innerArgs) {
                        Environment newEnv = outerEnv.env.getTopmostAncestor().descendant("Macro");
                        // process optional arguments.
                        long optional = Lists.reverse(params).stream().takeWhile(x -> x.getString().get().startsWith("?")).count();
                        if(optional != Lists.reverse(params).stream().filter(x -> x.getString().get().startsWith("?")).count())
                            throw new Error("Misplaced optional macro argument in parameter list.");
                        // evaluate parameters.
                        if(innerArgs.size() > params.size() || innerArgs.size() < params.size() - optional)
                            throw new Error("Invalid invocation to a macro expression.");
                        for(int i = 0; i < params.size() - optional; i++) {
                            newEnv.push(params.get(i).getString().get(), innerArgs.get(i));
                        }
                        // process optional arguments.
                        for(int i = 0; i < optional; i++) {
                            String name = params.get((int) (params.size() - optional + i)).getString().get().substring(1);
                            if(i + params.size() - optional < innerArgs.size())
                                newEnv.push(name, innerArgs.get((int) (i + params.size() - optional)));
                            else
                                newEnv.push(name, Atom.NULL);
                        }
                        Executor lambdaExecutor = new Executor(newEnv);
                        return lambdaExecutor.evaluate(code);
                    }
                });
                return result;
            }
        }));

        env.push("def", new Atom(new Macro() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2)
                    throw new Error("Invalid invocation to 'def'.");
                String key = arguments.get(0).getString().get();
                Atom value = env.evaluate(arguments.get(1));
                if(env.env.ancestor != null)
                    throw new Error("Unable to define a global variable outside of global scope.");
                env.env.push(key, value);
                return value;
            }
        }));

        env.push("with-repr", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2)
                    throw new Error("Invalid invocation to 'with-repr'.");
                Atom closure = arguments.get(0);
                Atom repr = arguments.get(1);
                closure.guardType("First argument to 'with-repr'", Type.CLOSURE, Type.MACRO);
                repr.guardType("Second argument to 'with-repr'", Type.STRING_CONSTANT);
                return new Atom(new Closure() {
                    @Override
                    public String representation() {
                        return repr.getStringConstant().get().get();
                    }

                    @Override
                    public Atom apply(Executor env, List<Atom> arguments) {
                        return closure.getCallable().get().apply(env, arguments);
                    }
                });
            }
        }));

        env.push("defun", new Atom(new Macro() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 3)
                    throw new Error("Invalid invocation to 'defun'.");
                Atom key = arguments.get(0);
                Atom params = arguments.get(1);
                Atom code = arguments.get(2);
                return env.evaluate(new Atom(List.of(new Atom("def"), key, new Atom(List.of(new Atom("lambda"), params, code)))));
            }
        }));

        env.push("defmacro", new Atom(new Macro() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 3)
                    throw new Error("Invalid invocation to 'defmacro'.");
                Atom key = arguments.get(0);
                Atom params = arguments.get(1);
                Atom code = arguments.get(2);
                return env.evaluate(new Atom(List.of(new Atom("def"), key, new Atom(List.of(new Atom("macro"), params, code)))));
            }
        }));

        env.push("quote", new Atom(new Macro() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'quote'.");
                return arguments.get(0);
            }
        }));

        env.push("monad", new Atom(new Macro() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'monad'.");
                return env.evaluate(new Atom(List.of(new Atom("lambda"), new Atom(List.of(new Atom("x"))), arguments.get(0))));
            }
        }));

        env.push("dyad", new Atom(new Macro() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'dyad'.");
                return env.evaluate(new Atom(List.of(new Atom("lambda"), new Atom(List.of(new Atom("x"), new Atom("y"))), arguments.get(0))));
            }
        }));

        env.push("bruijn", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'bruijn'.");
                int depth = arguments.get(0).getNumber().get().intValue();
                Environment currentEnv = env.env;
                for(int i = 0; i < depth; i++)
                    currentEnv = currentEnv.ancestor;
                return currentEnv.owner;
            }
        }));

        env.push("if", new Atom(new Macro() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 3)
                    throw new Error("invalid invocation to 'if'.");
                Atom cond = arguments.get(0);
                Atom iftrue = arguments.get(1);
                Atom iffalse = arguments.get(2);
                return new Atom(new LbcSupplier<>(() -> {
                    if(env.evaluate(cond).coerceBool())
                        return env.evaluate(iftrue).get().get();
                    else
                        return env.evaluate(iffalse).get().get();
                }));
            }
        }));

        env.push("map", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() < 2)
                    throw new Error("Invalid invocation to 'map'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("First argument to 'map'", Type.CLOSURE, Type.MACRO);
                    if(arguments.size() == 2) {
                        if (arguments.get(1).getType() == Type.LIST) {
                            return arguments.get(1).getList().get().stream().map(x ->
                                    new Atom(new LbcSupplier<>(() ->
                                            arguments.get(0).getCallable().get().apply(env, Collections.singletonList(x)).get().get()
                                    ))
                            ).collect(Collectors.toList());
                        } else if (arguments.get(1).getType() == Type.STRING_CONSTANT) {
                            return Chars.asList(arguments.get(1).getStringConstant().get().get().toCharArray()).stream().map(x ->
                                    new Atom(new LbcSupplier<>(() ->
                                            arguments.get(0).getCallable().get().apply(env, Collections.singletonList(new Atom(new StringConstant(String.valueOf(x))))).get().get()
                                    ))
                            ).collect(Collectors.toList());
                        } else {
                            return arguments.get(0).getCallable().get().apply(env, List.of(arguments.get(1))).get().get();
                        }
                    } else {
                        Callable f = arguments.get(0).getCallable().get();
                        AtomicInteger minLen = new AtomicInteger(-1);
                        List<List<Atom>> sl = arguments.subList(1, arguments.size()).stream().map(x -> {
                            x.guardType("Arguments to 'map'", Type.LIST);
                            if(minLen.get() > x.getList().get().size() || minLen.get() == -1)
                                minLen.set(x.getList().get().size());
                            return x.getList().get();
                        }).map(x -> x.subList(0, minLen.get())).collect(Collectors.toList());
                        return IntStream.range(0, minLen.get())
                                .mapToObj(i -> f.apply(env, sl.stream().map(x -> x.get(i)).collect(Collectors.toList())))
                                .collect(Collectors.toList());
                    }
                }));
            }
        }));

        env.push("filter", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2)
                    throw new Error("Invalid invocation to 'filter'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("First argument to 'filter'", Type.CLOSURE, Type.MACRO);
                    arguments.get(1).guardType("Second argument to 'filter'", Type.LIST);
                    return arguments.get(1).getList().get().stream().filter(x ->
                            arguments.get(0).getCallable().get().apply(env, Collections.singletonList(x)).coerceBool()
                    ).collect(Collectors.toList());
                }));
            }
        }));

        env.push("count", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2)
                    throw new Error("Invalid invocation to 'count'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("First argument to 'count'", Type.CLOSURE, Type.MACRO);
                    arguments.get(1).guardType("Second argument to 'count'", Type.LIST);
                    return new BigDecimal(arguments.get(1).getList().get().stream().filter(x ->
                            arguments.get(0).getCallable().get().apply(env, Collections.singletonList(x)).coerceBool()
                    ).count());
                }));
            }
        }));

        env.push("cond", new Atom(new Macro() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() < 2)
                    throw new Error("Invalid invocation to 'cond'.");
                return new Atom(new LbcSupplier<>(() -> {
                    List<Atom> args = arguments.stream().map(x -> x.getType() == Type.LIST ? x : env.evaluate(x)).collect(Collectors.toList());
                    for(Atom a : args) {
                        List<Atom> clause = a.getList().get();
                        if(clause.size() != 1 && clause.size() != 2)
                            throw new Error("Invalid invocation to 'cond'.");
                        if(clause.size() == 1)
                            return env.evaluate(clause.get(0)).get().get();
                        if(env.evaluate(clause.get(0)).coerceBool())
                            return env.evaluate(clause.get(1)).get().get();
                    }

                    throw new Error("Non-exhaustive 'cond'.");
                }));
            }
        }));

        env.push("type", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'type'.");
                return new Atom(new LbcSupplier<>(() -> new StringConstant(arguments.get(0).getType().toString())));
            }
        }));

        env.push("let", new Atom(new Macro() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() < 2)
                    throw new Error("Invalid invocation to 'let'.");
                List<Atom> args = arguments.get(0).getList().get();
                return new Atom(new LbcSupplier<>(() -> {
                    Environment newEnv = env.env.descendant("Let expression");
                    for(int i = 0; i < args.size(); i++) {
                        if(args.get(i).getType() != Type.LIST)
                            throw new Error("Invalid invocation to 'let'.");
                        List<Atom> binding = args.get(i).getList().get();
                        if(binding.size() % 2 != 0)
                            throw new Error("Invalid invocation to 'let'.");
                        if(binding.get(0).getType() != Type.STRING)
                            throw new Error("Invalid invocation to 'let'.");
                        newEnv.push(binding.get(0).getString().get(), env.evaluate(binding.get(1)));
                    }
                    newEnv.owner = new Atom(this);
                    return new Executor(newEnv).evaluate(arguments.get(1)).get().get();
                }));
            }
        }));

        env.push("eval", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'eval'.");
                return new Atom(new LbcSupplier<>(() -> env.evaluate(arguments.get(0)).get().get()));
            }
        }));

        env.push("parse", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'parse'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("Argument to 'parse'.", Type.STRING_CONSTANT);
                    String s = arguments.get(0).getString().get();
                    return Evaluation.evalString(env.env, s);
                }));
            }
        }));

        env.push("every", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2)
                    throw new Error("Invalid invocation to 'every'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(1).guardType("Argument to 'every'.", Type.LIST);
                    List<Atom> l = arguments.get(1).getList().get();
                    arguments.get(0).guardType("Argument to 'every'.", Type.CLOSURE, Type.MACRO);
                    Callable c = arguments.get(0).getCallable().get();
                    for (int i = 0; i < l.size(); i++) {
                        if(!c.apply(env, Arrays.asList(l.get(i))).coerceBool())
                            return BigDecimal.ZERO;
                    }
                    return BigDecimal.ONE;
                }));
            }
        }));

        env.push("id", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'id'.");
                return arguments.get(0);
            }
        }));

        env.push("flat-map", new Atom(new Closure() {
            public <T> List<T> flat(List<List<T>> list) {
                return list.stream()
                        .flatMap(Collection::stream)
                        .collect(Collectors.toList());
            }

            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2)
                    throw new Error("Invalid invocation to 'flat-map'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(1).guardType("Argument to 'flat-map'.", Type.LIST);
                    List<Atom> l = arguments.get(1).getList().get();
                    arguments.get(0).guardType("Argument to 'flat-map'.", Type.CLOSURE, Type.MACRO);
                    Callable c = arguments.get(0).getCallable().get();
                    return flat(l.stream().map(x -> c.apply(env, List.of(x))).map(x -> x.getType() == Type.LIST ? x.getList().get() : List.of(x)).collect(Collectors.toList()));
                }));
            }
        }));

        env.push("seq", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'seq'.");
                return new Atom(new LbcSupplier<>(() -> arguments.get(0).get().get()));
            }
        }));

        env.push("discard", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                return Atom.NULL;
            }
        }));

        env.push("gc", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                System.gc();
                if(arguments.size() >= 1)
                    return arguments.get(0);
                else
                    return Atom.NULL;
            }
        }));

        env.push("commute", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() < 2)
                    throw new Error("Invalid invocation to 'commute'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("Argument to 'commute'.", Type.CLOSURE, Type.MACRO);
                    Callable c = arguments.get(0).getCallable().get();
                    return c.apply(env, Lists.reverse(arguments.subList(1, arguments.size()))).get().get();
                }));
            }
        }));

        env.push("lift", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() < 2)
                    throw new Error("Invalid invocation to 'lift'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("Argument to 'lift'.", Type.CLOSURE, Type.MACRO);
                    arguments.get(1).guardType("Argument to 'lift'.", Type.LIST);
                    Callable c = arguments.get(0).getCallable().get();
                    List<Atom> l = arguments.get(1).getList().get();
                    return c.apply(env, l).get().get();
                }));
            }
        }));

        env.push("iterate", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() < 3)
                    throw new Error("Invalid invocation to 'iterate'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(1).guardType("Argument to 'iterate'.", Type.CLOSURE, Type.MACRO);
                    Callable c = arguments.get(1).getCallable().get();
                    LinkedList<Atom> rest = new LinkedList<>(arguments.subList(3, arguments.size()));
                    rest.addFirst(arguments.get(2));

                    if(arguments.get(0).getType() == Type.NUMBER) {
                        int n = arguments.get(0).getNumber().get().intValue();
                        for (int i = 0; i < n; i++)
                            rest.set(0, c.apply(env, rest).eager());
                    } else if(arguments.get(0).isCallable()) {
                        Callable f = arguments.get(0).getCallable().get();
                        Atom prev = Atom.NULL;
                        while(f.apply(env, List.of(prev, rest.get(0))).coerceBool()) {
                            prev = rest.get(0);
                            rest.set(0, c.apply(env, rest).eager());
                        }
                    }

                    return rest.get(0).get().get();
                }));
            }
        }));

        env.push("scanterate", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() < 3)
                    throw new Error("Invalid invocation to 'scanterate'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("Argument to 'scanterate'.", Type.CLOSURE, Type.MACRO);
                    Callable c = arguments.get(0).getCallable().get();
                    LinkedList<Atom> rest = new LinkedList<>(arguments.subList(3, arguments.size()));
                    rest.addFirst(arguments.get(2));
                    List<Atom> result = new LinkedList<>();

                    if(arguments.get(1).getType() == Type.NUMBER) {
                        int n = arguments.get(1).getNumber().get().intValue();
                        for (int i = 0; i < n; i++)
                            result.add(rest.set(0, c.apply(env, rest).eager()));
                    } else if(arguments.get(1).isCallable()) {
                        Callable f = arguments.get(1).getCallable().get();
                        while(f.apply(env, List.of(result.size() > 0 ? result.get(result.size() - 1) : Atom.NULL, rest.get(0))).coerceBool())
                            result.add(rest.set(0, c.apply(env, rest).eager()));
                    } else
                        throw new Error("Invalid invocation to 'scanterate'. Expected a callable or a number as the 2nd argument.");

                    result.add(rest.get(0));

                    return result;
                }));
            }
        }));

        // (f:g a b c) = (f (g a) (g b) (g c))
        env.push("over", new Atom(new Macro() {
            @Override
            public Atom apply(Executor env, List<Atom> tmp) {
                // #(f g h) <=> (f (g ...) (h ...))
                // #(f g) <=> (f (g ...))
                return new Atom(new Closure() {
                    @Override
                    public Atom apply(Executor innerEnv, List<Atom> arguments) {
                        Atom first = env.evaluate(tmp.get(0));
                        Atom second = env.evaluate(tmp.get(1));
                        first.guardType("'over' head", Type.CLOSURE, Type.MACRO);
                        second.guardType("'over' child", Type.CLOSURE, Type.MACRO);

                        return first.getCallable().get().apply(innerEnv, arguments.stream()
                                .map(x -> second.getCallable().get().apply(innerEnv, List.of(x)))
                                .collect(Collectors.toList()));
                    }
                });
            }
        }));

        env.push("bind", new Atom(new Macro() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() < 1)
                    throw new Error("Invalid invocation to 'bind'.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom arg0 = env.evaluate(arguments.get(0));
                    arg0.guardType("First argument to 'bind'.", Type.CLOSURE, Type.MACRO);
                    Callable c = arg0.getCallable().get();
                    List<Atom> rest = arguments.subList(1, arguments.size());
                    return new Closure() {
                        @Override
                        public Atom apply(Executor innerEnv, List<Atom> args) {
                            return new Atom(new LbcSupplier<>(() -> {
                                AtomicReference<Integer> consumed = new AtomicReference<>(0);
                                List<Atom> data = rest.stream().map(x -> {
                                    if(x.getType() == Type.STRING && x.getString().get().equals("_")) {
                                        // handle placeholder.
                                        if(consumed.get() >= args.size())
                                            throw new Error("Too few arguments to partially applied function. Stopped on " + consumed.get() + " placeholder.");
                                        return args.get(consumed.getAndSet(consumed.get() + 1));
                                    } else {
                                        return env.evaluate(x);
                                    }
                                }).collect(Collectors.toList());
                                data.addAll(args.subList(consumed.get(), args.size()));
                                return c.apply(env, data).get().get();
                            }));
                        }
                    };
                }));
            }
        }));

        env.push("to-string", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'to-string'.");
                return new Atom(new LbcSupplier<>(() -> new StringConstant(arguments.get(0).toString())));
            }
        }));

        env.push("parse-num", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'parse-num'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("First argument to 'parse-num'.", Type.STRING_CONSTANT);
                    String s = arguments.get(0).getStringConstant().get().get();

                    try {
                        return new BigDecimal(s);
                    } catch(NumberFormatException e) {
                        throw new Error("Invalid number format: " + s);
                    }
                }));
            }
        }));

        env.push("rng-roll", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() == 0)
                    return new Atom(new LbcSupplier<>(() -> new BigDecimal(Math.random())));
                else
                    return new Atom(new LbcSupplier<>(() -> {
                        Random r = new Random();
                        return arguments.stream().map(x -> {
                            x.guardType("Argument to 'rng-roll'.", Type.NUMBER);
                            BigInteger size = x.getNumber().get().toBigInteger();
                            BigInteger randomNumber;
                            do {
                                randomNumber = new BigInteger(size.bitLength(), r);
                            } while (randomNumber.compareTo(size) >= 0);
                            return new Atom(new BigDecimal(randomNumber));
                        }).collect(Collectors.toList());
                    }));
            }
        }));

        env.push("rng-deal", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                return new Atom(new LbcSupplier<>(() -> {
                    Random r = new Random();
                    arguments.get(0).guardType("First argument to 'rng-deal'.", Type.NUMBER);
                    arguments.get(1).guardType("Second argument to 'rng-deal'.", Type.NUMBER);
                    BigInteger cap = arguments.get(1).getNumber().get().toBigInteger();
                    return IntStream.range(0, arguments.get(0).getNumber().get().toBigInteger().intValue()).mapToObj(i -> {
                        BigInteger randomNumber;
                        do {
                            randomNumber = new BigInteger(cap.bitLength(), r);
                        } while (randomNumber.compareTo(cap) >= 0);
                        return new Atom(new BigDecimal(randomNumber));
                    }).collect(Collectors.toList());
                }));
            }
        }));

        env.push("memo", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> parentArgs) {
                if(parentArgs.size() != 1)
                    throw new Error("Invalid invocation to 'memo'.");
                return new Atom(new LbcSupplier<>(() -> {
                    parentArgs.get(0).guardType("First argument to 'memo'.", Type.CLOSURE);
                    HashMap<List<Atom>, Atom> memo = new HashMap<>();
                    return new Closure() {
                        @Override
                        public Atom apply(Executor env, List<Atom> arguments) {
                            if(memo.containsKey(arguments))
                                return memo.get(arguments);
                            else {
                                Atom result = parentArgs.get(0).getClosure().get().apply(env, arguments);
                                memo.put(arguments, result);
                                return result;
                            }
                        }
                    };
                }));
            }
        }));

        env.push("list-env", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                Environment scope = env.env;
                List<Atom> frames = new ArrayList<>();
                do
                    frames.add(new Atom(scope.entries().stream().map(x -> new Atom(new StringConstant(x))).collect(Collectors.toList())));
                while(scope.ancestor != null);
                return new Atom(frames);
            }
        }));

        env.push("str-trim", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'str-trim'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("First argument to 'str-trim'.", Type.STRING_CONSTANT);
                    return new StringConstant(arguments.get(0).getStringConstant().get().get().trim());
                }));
            }
        }));

        // Sequenced, scoped operations.
        // (let-seq
        //   (def x 3)
        //   (defun add3 (y) (+ x y))
        //   (add3 2))
        env.push("let-seq", new Atom(new Macro() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                return new Atom(new LbcSupplier<>(() -> {
                    Environment e = env.env.descendant("let-seq environment.");
                    Executor exec = new Executor(e);
                    loop: for(Atom a : arguments) {
                        if(a.getType() == Type.LIST) {
                            List<Atom> list = a.getList().get();
                            if(list.size() > 0 && list.get(0).getType() == Type.STRING) {
                                String name = list.get(0).getString().get();
                                switch(name) {
                                    case "def":
                                        if(list.size() != 3)
                                            throw new Error("Invalid invocation to 'def' in 'let-seq'.");
                                        list.get(1).guardType("First argument to 'def' in 'let-seq'.", Type.STRING);
                                        String varName = list.get(1).getString().get();
                                        Atom value = exec.evaluate(list.get(2));
                                        e.push(varName, value);
                                        continue loop;
                                    case "defun":
                                        if(list.size() != 4)
                                            throw new Error("Invalid invocation to 'defun' in 'let-seq'.");
                                        list.get(1).guardType("First argument to 'defun' in 'let-seq'.", Type.STRING);
                                        String funcName = list.get(1).getString().get();
                                        Atom params = list.get(2);
                                        Atom code = list.get(3);
                                        e.push(funcName, exec.evaluate(new Atom(List.of(new Atom("lambda"), params, code))));
                                        continue loop;
                                    case "defmacro":
                                        if(list.size() != 4)
                                            throw new Error("Invalid invocation to 'defmacro' in 'let-seq'.");
                                        list.get(1).guardType("First argument to 'defmacro' in 'let-seq'.", Type.STRING);
                                        String macroName = list.get(1).getString().get();
                                        Atom mparams = list.get(2);
                                        Atom mcode = list.get(3);
                                        e.push(macroName, exec.evaluate(new Atom(List.of(new Atom("macro"), mparams, mcode))));
                                        continue loop;
                                }
                            }
                        }

                        return exec.evaluate(a).get().get();
                    }
                    return Atom.NULL.get().get();
                }));
            }
        }));

        env.push("requote", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'requote'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("First argument to 'requote'.", Type.CLOSURE);
                    return arguments.get(0).getClosure().get().requote();
                }));
            }
        }));
    }
}
