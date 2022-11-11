package palaiologos.kamilalisp.runtime.math;

import ch.obermuhlner.math.big.BigComplexMath;
import ch.obermuhlner.math.big.BigDecimalMath;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.List;

public class Exp extends PrimitiveFunction implements Lambda {
    @Override
    protected String name() {
        return "exp";
    }

    private static Atom exp(Environment e, Atom a) {
        switch (a.getType()) {
            case LIST:
                return new Atom(a.getList().stream().map(x -> exp(e, x)).toList());
            case REAL:
            case INTEGER:
                return new Atom(BigDecimalMath.exp(a.getReal(), e.getMathContext()));
            case COMPLEX:
                return new Atom(BigComplexMath.exp(a.getComplex(), e.getMathContext()));
            default:
                throw new UnsupportedOperationException("exp not defined for: " + a.getType());
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.isEmpty()) {
            throw new RuntimeException("exp called with no arguments.");
        }

        if (args.size() == 1) {
            return exp(env, args.get(0));
        }

        return new Atom(args.stream().map(x -> exp(env, x)).toList());
    }
}
