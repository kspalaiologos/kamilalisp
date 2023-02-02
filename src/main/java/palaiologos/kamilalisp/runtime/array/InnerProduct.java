package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.util.List;
import java.util.concurrent.atomic.AtomicBoolean;

public class InnerProduct extends PrimitiveFunction implements Lambda {
    Atom fdepth(Callable f2, Environment env, Atom outer) {
        // outer is a vector of scalars -> fold with f2.
        if(outer.getType() == Type.LIST && outer.getList().stream().allMatch(x -> x.getType() != Type.LIST)) {
            return outer.getList().stream().reduce((x, y) -> f2.apply(env, List.of(x, y))).get();
        } else if (outer.getType() == Type.LIST) {
            // outer is a vector of vectors -> recurse.
            return new Atom(outer.getList().stream().map(x -> fdepth(f2, env, x)).toList());
        } else {
            // outer is a scalar -> return it.
            return outer;
        }
    }

    Atom innerProduct(Environment env, List<Atom> args, Callable f1, Callable f2) {
        List<Integer> ranks = args.stream().map(Rank::computeRank).toList();
        AtomicBoolean wasBoxed = new AtomicBoolean(false);
        args = args.stream().map(x -> {
            if (Rank.computeRank(x) == 1) {
                wasBoxed.set(true);
                return new Atom(List.of(x));
            } else {
                return x;
            }
        }).toList();
        // Compute the outer product with f2.
        Atom outer = args.stream().reduce((x, y) -> OuterProduct.op2(f2, env, x, y)).get();
        // Sum every vector value inside outer with f2.
        Atom d = fdepth(f1, env, outer);
        if(wasBoxed.get())
            return d.getList().get(0);
        return d;
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
        } else {
            // Return inner product of three or more lists.
            List<Atom> a = args.subList(2, args.size());
            return innerProduct(env, a, f1, f2);
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

            return innerProduct(env, args, c1, c2);
        }

        @Override
        protected String name() {
            return "inner-product (" + c1.stringify() + ":" + c2.stringify() + ")";
        }
    }
}
