package palaiologos.kamilalisp.runtime.meta;

import palaiologos.kamilalisp.atom.*;

import java.util.HashMap;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.locks.ReentrantLock;

public class Memo extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() != 1 && args.size() != 2) {
            throw new RuntimeException("memo takes exactly one or two arguments");
        }
        Atom arg = args.get(0);
        if (arg.getType() != Type.CALLABLE) {
            throw new RuntimeException("memo takes a lambda as an argument");
        }
        int max = -1;
        if (args.size() == 2) {
            Atom maxArg = args.get(1);
            if (maxArg.getType() == Type.INTEGER)
                max = maxArg.getInteger().intValueExact();
            else
                throw new RuntimeException("memo takes an integer as the second argument");
        }
        final Lambda mfn = (Lambda) arg.getCallable();
        if (max != -1) {
            int finalMax = max;
            return new Atom(new Lambda() {
                private final ConcurrentLRUCache<List<Atom>, Atom> cache = new ConcurrentLRUCache<>(finalMax);

                @Override
                public Atom apply(Environment env, List<Atom> args) {
                    Atom result = cache.get(args);
                    if (result == null) {
                        result = Evaluation.evaluate(env, mfn, args);
                        cache.put(args, result);
                    }

                    return result;
                }

                @Override
                public String stringify() {
                    return "memo$" + mfn.stringify();
                }

                @Override
                public String frameString() {
                    return "memo$" + mfn.frameString();
                }

                @Override
                public int line() {
                    return mfn.line();
                }

                @Override
                public int column() {
                    return mfn.column();
                }
            });
        } else {
            return new Atom(new Lambda() {
                private final ConcurrentHashMap<List<Atom>, Atom> cache = new ConcurrentHashMap<>();

                @Override
                public Atom apply(Environment env, List<Atom> args) {
                    Atom result = cache.get(args);
                    if (result == null) {
                        result = Evaluation.evaluate(env, mfn, args);
                        cache.put(args, result);
                    }
                    return result;
                }

                @Override
                public String stringify() {
                    return "memo$" + mfn.stringify();
                }

                @Override
                public String frameString() {
                    return "memo$" + mfn.frameString();
                }

                @Override
                public int line() {
                    return mfn.line();
                }

                @Override
                public int column() {
                    return mfn.column();
                }
            });
        }
    }

    @Override
    protected String name() {
        return "memo";
    }
}
