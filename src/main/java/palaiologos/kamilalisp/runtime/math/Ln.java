package palaiologos.kamilalisp.runtime.math;

import ch.obermuhlner.math.big.BigComplexMath;
import ch.obermuhlner.math.big.BigDecimalMath;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.math.BigDecimal;
import java.util.List;

public class Ln extends PrimitiveFunction implements Lambda {
    private static Atom ln(Environment e, Atom a) {
        switch (a.getType()) {
            case LIST:
                return new Atom(a.getList().stream().map(x -> ln(e, x)).toList());
            case REAL:
            case INTEGER:
                if (a.getReal().compareTo(BigDecimal.ZERO) > 0)
                    return new Atom(BigDecimalMath.log(a.getReal(), e.getMathContext()));
                else
                    return new Atom(BigComplexMath.log(a.getComplex(), e.getMathContext()));
            case COMPLEX:
                return new Atom(BigComplexMath.log(a.getComplex(), e.getMathContext()));
            default:
                throw new UnsupportedOperationException("ln not defined for: " + a.getType());
        }
    }

    @Override
    protected String name() {
        return "ln";
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.isEmpty()) {
            throw new RuntimeException("ln called with no arguments.");
        }

        if (args.size() == 1) {
            return ln(env, args.get(0));
        }

        return new Atom(args.stream().map(x -> ln(env, x)).toList());
    }
}
