package palaiologos.kamilalisp.runtime.flt64;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.math.BigDecimal;

public class Flt64Base {
    public static final double EPSILON = Math.ulp(1.0d);

    static double toFlt64(Atom a) {
        if(a instanceof Flt64AtomThunk)
            return ((Flt64AtomThunk) a).val;
        return switch (a.getType()) {
            case INTEGER -> a.getInteger().doubleValue();
            case REAL -> a.getReal().doubleValue();
            case COMPLEX -> a.getComplex().re.doubleValue();
            default -> throw new IllegalArgumentException("Cannot convert " + a.getType() + " to flt64");
        };
    }

    public static Atom toAtom(double d) {
        if(Double.isNaN(d))
            throw new ArithmeticException("NaN");
        return new Flt64AtomThunk(d);
    }

    abstract static class Flt64Function extends PrimitiveFunction implements Lambda {
    }
}
