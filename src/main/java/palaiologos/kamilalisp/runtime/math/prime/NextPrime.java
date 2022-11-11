package palaiologos.kamilalisp.runtime.math.prime;

import palaiologos.kamilalisp.atom.*;

import java.util.List;

public class NextPrime extends PrimitiveFunction implements Lambda {
    private static Atom factor(Atom a) {
        if (a.getType() == Type.INTEGER) {
            return new Atom(a.getInteger().nextProbablePrime());
        } else if (a.getType() == Type.LIST) {
            return new Atom(a.getList().stream().map(NextPrime::factor).toList());
        } else {
            throw new UnsupportedOperationException("next-prime not defined for: " + a.getType());
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.isEmpty()) {
            throw new RuntimeException("next-prime called with no arguments.");
        }

        if (args.size() == 1) {
            return factor(args.get(0));
        }

        return new Atom(args.stream().map(NextPrime::factor).toList());
    }

    @Override
    protected String name() {
        return "next-prime";
    }
}
