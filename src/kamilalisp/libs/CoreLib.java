package kamilalisp.libs;

import com.google.common.collect.Lists;
import com.google.common.collect.Streams;
import kamilalisp.api.Evaluation;
import kamilalisp.data.*;
import kamilalisp.reader.Parser;

import java.math.BigDecimal;
import java.util.*;
import java.util.stream.Collectors;
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
                Environment newEnv = outerEnv.env.descendant("Lambda expression");
                Atom result = new Atom(new Closure() {
                    @Override
                    public String representation() {
                        return "(λ " + params.stream().map(x -> x.getString().get()).collect(Collectors.joining(" ")) + "." + code.toString() + ")";
                    }

                    @Override
                    public List requote() {
                        return arguments;
                    }

                    @Override
                    public Atom apply(Executor env, List<Atom> innerArgs) {
                        if(innerArgs.size() != params.size())
                            throw new Error("Invalid invocation to a lambda expression.");
                        for(int i = 0; i < params.size(); i++)
                            newEnv.push(params.get(i).getString().get(), innerArgs.get(i));
                        Executor lambdaExecutor = new Executor(newEnv);
                        return lambdaExecutor.evaluate(code);
                    }
                });
                newEnv.owner = result;
                return result;
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
                Environment newEnv = outerEnv.env.getTopmostAncestor().descendant("Macro");
                Atom result = new Atom(new Closure() {
                    @Override
                    public String representation() {
                        return "(macro " + params.stream().map(x -> x.getString().get()).collect(Collectors.joining(" ")) + "." + code.toString() + ")";
                    }

                    @Override
                    public List requote() {
                        return arguments;
                    }

                    @Override
                    public Atom apply(Executor env, List<Atom> innerArgs) {
                        if(innerArgs.size() != params.size())
                            throw new Error("Invalid invocation to a lambda expression.");
                        for(int i = 0; i < params.size(); i++)
                            newEnv.push(params.get(i).getString().get(), env.evaluate(innerArgs.get(i)));
                        Executor lambdaExecutor = new Executor(newEnv);
                        return lambdaExecutor.evaluate(code);
                    }
                });
                newEnv.owner = result;
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
                if(env.evaluate(cond).coerceBool())
                    return new Atom(new LbcSupplier(() -> env.evaluate(iftrue).get().get()));
                else
                    return new Atom(new LbcSupplier(() -> env.evaluate(iffalse).get().get()));
            }
        }));

        env.push("=", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2)
                    throw new Error("invalid invocation to '='.");
                return new Atom(new LbcSupplier(() -> arguments.get(0).equals(arguments.get(1)) ? BigDecimal.ONE : BigDecimal.ZERO));
            }
        }));

        env.push("/=", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2)
                    throw new Error("invalid invocation to '='.");
                return new Atom(new LbcSupplier(() -> arguments.get(0).equals(arguments.get(1)) ? BigDecimal.ZERO : BigDecimal.ONE));
            }
        }));

        env.push("cons", new Atom(new Closure() {
            private List<Atom> cons2(Atom element, Atom list) {
                if(list.getType() != Type.LIST)
                    throw new Error("invalid invocation to 'cons'.");
                LinkedList<Atom> l = new LinkedList<>(list.getList().get());
                l.addFirst(element);
                return l;
            }

            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2)
                    throw new Error("invalid invocation to 'cons'.");
                else
                    return new Atom(new LbcSupplier(() -> cons2(arguments.get(0), arguments.get(1))));
            }
        }));

        env.push("append", new Atom(new Closure() {
            private List<Atom> append2(Atom list, Atom tail) {
                list.guardType("Argument to 'append'", Type.LIST);
                LinkedList<Atom> l = new LinkedList<Atom>(list.getList().get());
                l.addLast(tail);
                return l;
            }

            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() < 2)
                    throw new Error("invalid invocation to 'append'.");
                if(arguments.size() == 2)
                    return new Atom(new LbcSupplier(() -> append2(arguments.get(0), arguments.get(1))));
                else
                    return new Atom(new LbcSupplier(() -> {
                        arguments.get(0).guardType("Argument to 'append'", Type.LIST);
                        List<Atom> l = new LinkedList<>(arguments.get(0).getList().get());
                        l.addAll(arguments.stream().skip(1).collect(Collectors.toList()));
                        return l;
                    }));
            }
        }));

        env.push("car", new Atom(new Closure() {
            private Atom car(Atom l) {
                l.guardType("Argument to 'car'", Type.LIST);
                List<Atom> data = l.getList().get();
                if(data.isEmpty())
                    return Atom.NULL;
                else
                    return data.get(0);
            }

            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() == 1) {
                    return new Atom(new LbcSupplier(() -> car(arguments.get(0)).get().get()));
                } else if(arguments.size() >= 2) {
                    return new Atom(new LbcSupplier(() -> arguments.stream().map(x -> car(x)).collect(Collectors.toList())));
                } else
                    throw new Error("Invalid invocation to 'car'.");
            }
        }));

        env.push("size", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'size'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("Argument to 'size'", Type.LIST, Type.STRING_CONSTANT);

                    if(arguments.get(0).getType() == Type.LIST)
                        return BigDecimal.valueOf(arguments.get(0).getList().get().size());
                    else if(arguments.get(0).getType() == Type.STRING_CONSTANT)
                        return BigDecimal.valueOf(arguments.get(0).getStringConstant().get().get().length());

                    throw new Error("Invalid invocation to 'size'.");
                }));
            }
        }));

        env.push("map", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2)
                    throw new Error("Invalid invocation to 'map'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("First argument to 'map'", Type.CLOSURE);
                    arguments.get(1).guardType("Second argument to 'map'", Type.LIST);
                    return arguments.get(1).getList().get().stream().map(x ->
                            new Atom(new LbcSupplier<>(() ->
                                    arguments.get(0).getClosure().get().apply(env, Collections.singletonList(x))
                            ))
                    ).collect(Collectors.toList());
                }));
            }
        }));

        env.push("filter", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2)
                    throw new Error("Invalid invocation to 'filter'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("First argument to 'filter'", Type.CLOSURE);
                    arguments.get(1).guardType("Second argument to 'filter'", Type.LIST);
                    return arguments.get(1).getList().get().stream().filter(x ->
                            arguments.get(0).getClosure().get().apply(env, Collections.singletonList(x)).coerceBool()
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
                    arguments.get(0).guardType("First argument to 'count'", Type.CLOSURE);
                    arguments.get(1).guardType("Second argument to 'count'", Type.LIST);
                    return new BigDecimal(arguments.get(1).getList().get().stream().filter(x ->
                            arguments.get(0).getClosure().get().apply(env, Collections.singletonList(x)).coerceBool()
                    ).count());
                }));
            }
        }));

        env.push("cdr", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'cdr'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("Argument to 'cdr'", Type.LIST);
                    List<Atom> data = arguments.get(0).getList().get();
                    if(data.isEmpty())
                        return Atom.NULL.get().get();
                    else
                        return data.subList(1, data.size());
                }));
            }
        }));

        env.push("foldl", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 3)
                    throw new Error("Invalid invocation to 'foldl'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("First argument to 'foldl'", Type.CLOSURE);
                    arguments.get(2).guardType("Third argument to 'foldl'", Type.LIST);
                    List<Atom> data = arguments.get(2).getList().get();
                    Atom acc = arguments.get(1);
                    if(data.isEmpty())
                        return acc.get().get();
                    else {
                        return Stream.concat(Stream.of(acc), data.stream()).reduce((x, y) ->
                            arguments.get(0).getClosure().get().apply(env, Arrays.asList(x, y))
                        ).get().get().get();
                    }
                }));
            }
        }));

        env.push("foldr", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 3)
                    throw new Error("Invalid invocation to 'foldr'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("First argument to 'foldr'", Type.CLOSURE);
                    arguments.get(2).guardType("Third argument to 'foldr'", Type.LIST);
                    List<Atom> data = arguments.get(2).getList().get();
                    Atom acc = arguments.get(1);
                    if(data.isEmpty())
                        return acc.get().get();
                    else {
                        return Stream.concat(Stream.of(acc), Lists.reverse(data).stream()).reduce((x, y) ->
                            arguments.get(0).getClosure().get().apply(env, Arrays.asList(y, x))
                        ).get().get().get();
                    }
                }));
            }
        }));

        env.push("foldl'", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 3)
                    throw new Error("Invalid invocation to 'foldl''.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("First argument to 'foldl''", Type.CLOSURE);
                    arguments.get(2).guardType("Third argument to 'foldl''", Type.LIST);
                    List<Atom> data = arguments.get(2).getList().get();
                    Atom acc = arguments.get(1);
                    if(data.isEmpty())
                        return acc.get().get();
                    else {
                        return Stream.concat(Stream.of(acc), data.stream()).reduce((x, y) ->
                                arguments.get(0).getClosure().get().apply(env, Arrays.asList(x.eager(), y.eager())).eager()
                        ).get().get().get();
                    }
                }));
            }
        }));

        env.push("foldr'", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 3)
                    throw new Error("Invalid invocation to 'foldr''.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("First argument to 'foldr''", Type.CLOSURE);
                    arguments.get(2).guardType("Third argument to 'foldr''", Type.LIST);
                    List<Atom> data = arguments.get(2).getList().get();
                    Atom acc = arguments.get(1);
                    if(data.isEmpty())
                        return acc.get().get();
                    else {
                        return Stream.concat(Stream.of(acc), Lists.reverse(data).stream()).reduce((x, y) ->
                                arguments.get(0).getClosure().get().apply(env, Arrays.asList(y.eager(), x.eager())).eager()
                        ).get().get().get();
                    }
                }));
            }
        }));

        env.push("any", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2)
                    throw new Error("Invalid invocation to 'any'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("First argument to 'any'", Type.CLOSURE);
                    arguments.get(1).guardType("Second argument to 'any'", Type.LIST);
                    return arguments.get(1).getList().get().stream().anyMatch(x ->
                            arguments.get(0).getClosure().get().apply(env, Collections.singletonList(x)).coerceBool()
                    ) ? BigDecimal.ONE : BigDecimal.ZERO;
                }));
            }
        }));

        env.push("zip", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2)
                    throw new Error("Invalid invocation to 'zip'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("First argument to 'zip'", Type.LIST);
                    arguments.get(1).guardType("Second argument to 'zip'", Type.LIST);
                    List<Atom> a = arguments.get(0).getList().get();
                    List<Atom> b = arguments.get(1).getList().get();
                    return Streams.zip(a.stream(), b.stream(), (x, y) -> new Atom(new LbcSupplier<>(() -> List.of(x, y)))).collect(Collectors.toList());
                }));
            }
        }));

        env.push("zip-with", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 3)
                    throw new Error("Invalid invocation to 'zip-with'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("First argument to 'zip-with'", Type.CLOSURE);
                    arguments.get(1).guardType("Second argument to 'zip-with'", Type.LIST);
                    arguments.get(2).guardType("Second argument to 'zip-with'", Type.LIST);
                    List<Atom> a = arguments.get(1).getList().get();
                    List<Atom> b = arguments.get(2).getList().get();
                    return Streams.zip(a.stream(), b.stream(), (x, y) -> arguments.get(0).getClosure().get().apply(env, Arrays.asList(x, y))).collect(Collectors.toList());
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
                    arguments.get(0).guardType("Argument to parse", Type.STRING_CONSTANT);
                    String s = arguments.get(0).getString().get();
                    return Evaluation.evalString(env.env, s);
                }));
            }
        }));

        env.push("reverse", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'reverse'.");
                return new Atom(new LbcSupplier<>(() -> {
                    if(arguments.get(0).getType() == Type.LIST) {
                        List<Atom> l = arguments.get(0).getList().get();
                        List<Atom> r = new ArrayList<>();
                        for (int i = l.size() - 1; i >= 0; i--)
                            r.add(l.get(i));
                        return r;
                    } else if(arguments.get(0).getType() == Type.STRING_CONSTANT) {
                        String s = arguments.get(0).getStringConstant().get().get();
                        String r = "";
                        for (int i = s.length() - 1; i >= 0; i--)
                            r += s.charAt(i);
                        return new StringConstant(r);
                    }

                    throw new Error("Invalid invocation to 'reverse': expected a string or list.");
                }));
            }
        }));

        env.push("rotate", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2)
                    throw new Error("Invalid invocation to 'rotate'.");
                return new Atom(new LbcSupplier<>(() -> {
                    if(arguments.get(0).getType() == Type.LIST) {
                        List<Atom> l = arguments.get(0).getList().get();
                        int n = arguments.get(1).getNumber().get().intValue();
                        if(n < 0)
                            n += l.size();
                        if(n >= l.size())
                            n %= l.size();
                        List<Atom> r = new ArrayList<>();
                        for (int i = n; i < l.size(); i++)
                            r.add(l.get(i));
                        for (int i = 0; i < n; i++)
                            r.add(l.get(i));
                        return r;
                    } else if(arguments.get(0).getType() == Type.STRING_CONSTANT) {
                        String s = arguments.get(0).getStringConstant().get().get();
                        int n = arguments.get(1).getNumber().get().intValue();
                        if(n < 0)
                            n += s.length();
                        if(n >= s.length())
                            n %= s.length();
                        String r = "";
                        for (int i = n; i < s.length(); i++)
                            r += s.charAt(i);
                        for (int i = 0; i < n; i++)
                            r += s.charAt(i);
                        return new StringConstant(r);
                    }

                    throw new Error("Invalid invocation to 'rotate': expected a string or list.");
                }));
            }
        }));

        env.push("every", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2)
                    throw new Error("Invalid invocation to 'every'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(1).guardType("Argument to every", Type.LIST);
                    List<Atom> l = arguments.get(1).getList().get();
                    arguments.get(0).guardType("Argument to every", Type.CLOSURE);
                    Closure c = arguments.get(0).getClosure().get();
                    for (int i = 0; i < l.size(); i++) {
                        if(!c.apply(env, Arrays.asList(l.get(i))).coerceBool())
                            return BigDecimal.ZERO;
                    }
                    return BigDecimal.ONE;
                }));
            }
        }));
    }
}
