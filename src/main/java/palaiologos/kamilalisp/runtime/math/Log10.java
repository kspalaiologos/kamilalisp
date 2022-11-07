package palaiologos.kamilalisp.runtime.math;

import ch.obermuhlner.math.big.BigComplex;
import ch.obermuhlner.math.big.BigComplexMath;
import ch.obermuhlner.math.big.BigDecimalMath;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.List;

public class Log10 extends PrimitiveFunction implements Lambda {
    @Override
    protected String name() {
        return "log10";
    }

    private static Atom ln(Environment e, Atom a) {
        switch(a.getType()) {
            case LIST:
                return new Atom(a.getList().stream().map(x -> ln(e, x)).toList());
            case REAL: case INTEGER:
                return new Atom(BigDecimalMath.log10(a.getReal(), e.getMathContext()));
            case COMPLEX:
                return new Atom(BigComplexMath.log(a.getComplex(), e.getMathContext()).divide(BigComplexMath.log(BigComplex.valueOf(10), e.getMathContext()), e.getMathContext()));
            default:
                throw new UnsupportedOperationException("log10 not defined for: " + a.getType());
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.isEmpty()) {
            throw new RuntimeException("log10 called with no arguments.");
        }

        if(args.size() == 1) {
            return ln(env, args.get(0));
        }

        return new Atom(args.stream().map(x -> ln(env, x)).toList());
    }
}
