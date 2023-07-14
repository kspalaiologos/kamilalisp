package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class InnerProduct extends PrimitiveFunction implements Lambda {
    private static Atom prod2(Environment env, Callable c1, Callable c2, List<Atom> a, List<Atom> b) {
        int len = Math.min(a.size(), b.size());
        if (len < 2) {
            return c2.apply(env, List.of(a.get(0), b.get(0)));
        }

        Atom result = c2.apply(env, List.of(a.get(0), b.get(0)));
        for (int i = 1; i < len; i++)
            result = c1.apply(env, List.of(result, c2.apply(env, List.of(a.get(i), b.get(i)))));
        return result;
    }

    private static Atom prodN(Environment env, Callable c1, Callable c2, List<List<Atom>> a) {
        if(a.isEmpty()) {
            throw new TypeError("Inner product requires at least two common elements.");
        }

        int len = Integer.MAX_VALUE;
        for (List<Atom> l : a) {
            if (l.size() < len) {
                len = l.size();
            }
        }

        if (len < 2) {
            return c2.apply(env, a.stream().map(l -> l.get(0)).toList());
        }

        boolean seen = false;
        Atom acc = null;
        for (List<Atom> atoms : a) {
            Atom atom = atoms.get(0);
            if (!seen) {
                seen = true;
                acc = atom;
            } else {
                acc = c2.apply(env, List.of(acc, atom));
            }
        }
        Atom result = Optional.of(acc).orElseThrow();
        for (int i = 1; i < len; i++) {
            boolean seen1 = false;
            Atom acc1 = null;
            for (List<Atom> l : a) {
                Atom atom = l.get(i);
                if (!seen1) {
                    seen1 = true;
                    acc1 = atom;
                } else {
                    acc1 = c2.apply(env, List.of(acc1, atom));
                }
            }
            result = c1.apply(env, List.of(result, (seen1 ? Optional.of(acc1) : Optional.<Atom>empty()).orElseThrow()));
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
            ArrayList<List<Atom>> a = new ArrayList<>();
            for (Atom atom : args.subList(2, args.size())) {
                List<Atom> list = atom.getList();
                a.add(list);
            }
            return prodN(env, f1, f2, a);
        }
    }

    @Override
    protected String name() {
        return "inner-product";
    }

    static class InnerProductWrapper extends PrimitiveFunction implements Lambda {
        private final Callable c1;
        private final Callable c2;

        InnerProductWrapper(Callable c1, Callable c2) {
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
                ArrayList<List<Atom>> a = new ArrayList<>();
                for (Atom arg : args) {
                    List<Atom> list = arg.getList();
                    a.add(list);
                }
                return prodN(env, c1, c2, a);
            }
        }

        @Override
        protected String name() {
            return "inner-product (" + c1.stringify() + ":" + c2.stringify() + ")";
        }
    }
}