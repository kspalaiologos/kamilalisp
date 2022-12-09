package palaiologos.kamilalisp.runtime.math;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.math.BigDecimal;
import java.util.List;

public class ComplexParts extends PrimitiveFunction implements Lambda {
    @Override
    protected String name() {
        return "complex-parts";
    }

    private static Atom makeTuple(BigDecimal a, BigDecimal b) {
        return new Atom(List.of(new Atom(a), new Atom(b)));
    }

    private static Atom ln(Environment e, Atom a) {
        switch (a.getType()) {
            case LIST:
                return new Atom(a.getList().stream().map(x -> ln(e, x)).toList());
            case REAL:
            case INTEGER:
                return makeTuple(a.getReal(), BigDecimal.ZERO);
            case COMPLEX:
                return makeTuple(a.getComplex().re, a.getComplex().im);
            default:
                throw new UnsupportedOperationException("complex-parts not defined for: " + a.getType());
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.isEmpty()) {
            throw new RuntimeException("complex-parts called with no arguments.");
        }

        if (args.size() == 1) {
            return ln(env, args.get(0));
        }

        return new Atom(args.stream().map(x -> ln(env, x)).toList());
    }
}
