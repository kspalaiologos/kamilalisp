package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.util.List;

public class InnerProduct extends PrimitiveFunction implements Lambda {
    private Atom prod2(Environment env, Callable c1, Callable c2, List<Atom> a, List<Atom> b) {
        int len = Math.min(a.size(), b.size());
        if (len < 2) {
            throw new TypeError("Inner product requires at least two common elements.");
        }

        Atom result = c2.apply(env, List.of(a.get(0), b.get(0)));
        for (int i = 1; i < len; i++)
            result = c1.apply(env, List.of(result, c2.apply(env, List.of(a.get(i), b.get(i)))));
        return result;
    }

    private Atom prodN(Environment env, Callable c1, Callable c2, List<List<Atom>> a) {
        int len = a.stream().map(List::size).min(Integer::compareTo).orElseThrow();
        if (len < 2) {
            throw new TypeError("Inner product requires at least two common elements.");
        }

        Atom result = a.stream().map(l -> l.get(0)).reduce((x, y) -> c2.apply(env, List.of(x, y))).orElseThrow();
        for (int i = 1; i < len; i++) {
            final int j = i;
            result = c1.apply(env, List.of(result, a.stream().map(l -> l.get(j)).reduce((x, y) -> c2.apply(env, List.of(x, y))).orElseThrow()));
        }
        return result;
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() < 2 || args.size() == 3) {
            throw new TypeError("inner-product called with too few arguments.");
        }

        Callable f1, f2;
        f1 = args.get(0).getCallable();
        f2 = args.get(1).getCallable();
        if (args.size() == 2) {
            // Return inner product function.
            return new Atom(new InnerProductWrapper(f1, f2));
        } else if (args.size() == 4) {
            // Return inner product of two lists.
            List<Atom> a = args.get(2).getList();
            List<Atom> b = args.get(3).getList();
            return prod2(env, f1, f2, a, b);
        } else {
            // Return inner product of three or more lists.
            List<List<Atom>> a = args.subList(2, args.size()).stream().map(Atom::getList).toList();
            return prodN(env, f1, f2, a);
        }
    }

    @Override
    protected String name() {
        return "inner-product";
    }

    class InnerProductWrapper extends PrimitiveFunction implements Lambda {
        private final Callable c1;
        private final Callable c2;

        public InnerProductWrapper(Callable c1, Callable c2) {
            this.c1 = c1;
            this.c2 = c2;
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() < 2) {
                throw new TypeError("Expected at least 2 arguments to the inner product, got " + args.size());
            }

            if (args.size() == 2) {
                // Return inner product of two lists.
                List<Atom> a = args.get(0).getList();
                List<Atom> b = args.get(1).getList();
                return prod2(env, c1, c2, a, b);
            } else {
                // Return inner product of three or more lists.
                List<List<Atom>> a = args.stream().map(Atom::getList).toList();
                return prodN(env, c1, c2, a);
            }
        }

        @Override
        protected String name() {
            return "inner-product (" + c1.stringify() + ":" + c2.stringify() + ")";
        }
    }
}
