package palaiologos.kamilalisp.runtime.flt64;

import palaiologos.kamilalisp.atom.*;

import java.math.BigDecimal;
import java.util.List;

public class Flt64AtomThunk extends AtomicThunk {
    public double val;
    private boolean forced = false;

    public Flt64AtomThunk(double val) {
        super();
        this.val = val;
    }

    public void force() {
        if(forced)
            return;
        setType(Type.REAL);
        setData(BigDecimal.valueOf(val));
        forced = true;
    }

    public static double toFloat(Atom a) {
        if(a instanceof Flt64AtomThunk)
            return ((Flt64AtomThunk) a).val;
        else if(a instanceof Cmplx64AtomThunk)
            return ((Cmplx64AtomThunk) a).val.re();
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
}
