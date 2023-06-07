package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.function.BiFunction;
import java.util.stream.Collectors;

public class OuterProduct extends PrimitiveFunction implements Lambda {
    private static <T, R> List<List<R>> op(BiFunction<T, T, R> f, List<T> a, List<T> b) {
        List<List<R>> results = new ArrayList<>();
        for (T x : a) {
            List<R> result = new ArrayList<>();
            for (T y : b) {
                result.add(f.apply(x, y));
            }
            results.add(result);
        }
        return results;
    }

    private static Atom op2(Callable fn, Environment env, Atom a, Atom b) {
        if (a.getType() == Type.LIST && b.getType() == Type.LIST) {
            List<Atom> list = new ArrayList<>();
            for (List<Atom> atoms : op((x, y) -> fn.apply(env, List.of(x, y)), a.getList(), b.getList())) {
                Atom atom = atoms.size() == 1 ? atoms.get(0) : new Atom(atoms);
                list.add(atom);
            }
            return new Atom(list);
        } else if (a.getType() == Type.STRING && b.getType() == Type.STRING) {
            List<Atom> list = new ArrayList<>();
            for (List<Atom> atoms : op(
                    (x, y) -> fn.apply(env, List.of(new Atom(String.valueOf(x)), new Atom(String.valueOf(y)))),
                    a.getString().chars().mapToObj(x -> (char) x).toList(),
                    b.getString().chars().mapToObj(x -> (char) x).toList()
            )) {
                StringBuilder sb = new StringBuilder();
                for (Atom atom1 : atoms) {
                    String toString = atom1.toString();
                    sb.append(toString);
                }
                Atom atom = new Atom(sb.toString());
                list.add(atom);
            }
            return new Atom(list);
        } else if (a.getType() == Type.LIST && b.getType() != Type.LIST) {
            return new Atom(op((x, y) -> fn.apply(env, List.of(x, y)), a.getList(), List.of(b)).stream().map(x -> x.size() == 1 ? x.get(0) : new Atom(x)).toList());
        } else if (a.getType() != Type.LIST && b.getType() == Type.LIST) {
            return new Atom(op((x, y) -> fn.apply(env, List.of(x, y)), List.of(a), b.getList()).stream().map(x -> x.size() == 1 ? x.get(0) : new Atom(x)).toList());
        } else {
            return new Atom(List.of(a, b));
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() == 1) {
            return new Atom(new OuterProductThunk(args.get(0), env));
        }

        if (args.size() == 0) {
            throw new TypeError("outer-product called with too few arguments.");
        }

        return doOuter(env, args.get(0), args.subList(1, args.size()));
    }

    private static Atom doOuter(Environment env, Atom fn, List<Atom> args) {
        if (fn.getType() == Type.CALLABLE) {
            if (args.size() < 2) {
                throw new TypeError("outer-product called with too few arguments.");
            }

            boolean seen = false;
            Atom acc = null;
            for (Atom atom : args) {
                if (!seen) {
                    seen = true;
                    acc = atom;
                } else {
                    acc = op2(args.get(0).getCallable(), env, acc, atom);
                }
            }
            return acc;
        } else {
            boolean seen = false;
            Atom acc = null;
            for (Atom arg : args) {
                if (!seen) {
                    seen = true;
                    acc = arg;
                } else {
                    acc = op2(Tie.INSTANCE, env, acc, arg);
                }
            }
            return (seen ? Optional.of(acc) : Optional.<Atom>empty()).get();
        }
    }

    private static class OuterProductThunk extends PrimitiveFunction implements Lambda {
        private final Atom fn;
        private final Environment env;

        public OuterProductThunk(Atom fn, Environment env) {
            this.fn = fn;
            this.env = env;
        }

        @Override
        public Atom apply(Environment _env, List<Atom> args) {
            return doOuter(env, fn, args);
        }

        @Override
        protected String name() {
            return "outer-product (" + fn.toString() + ")";
        }
    }

    @Override
    protected String name() {
        return "outer-product";
    }
}
