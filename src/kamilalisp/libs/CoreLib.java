package kamilalisp.libs;

import kamilalisp.data.*;

import java.math.BigDecimal;
import java.util.List;
import java.util.stream.Collectors;

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
    }
}
