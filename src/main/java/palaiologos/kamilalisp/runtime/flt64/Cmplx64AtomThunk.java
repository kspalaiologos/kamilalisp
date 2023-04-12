package palaiologos.kamilalisp.runtime.flt64;

import ch.obermuhlner.math.big.BigComplex;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.AtomicThunk;
import palaiologos.kamilalisp.atom.Type;
import rocks.palaiologos.maja.Complex;

import java.math.BigDecimal;

public class Cmplx64AtomThunk extends AtomicThunk {
    public Complex val;
    private boolean forced = false;

    public Cmplx64AtomThunk(Complex val) {
        super();
        this.val = val;
    }

    public void force() {
        if(forced)
            return;
        setType(Type.COMPLEX);
        setData(BigComplex.valueOf(val.re(), val.im()));
        forced = true;
    }

    public static Complex toComplex(Atom a) {
        if(a instanceof Cmplx64AtomThunk)
            return ((Cmplx64AtomThunk) a).val;
        else if(a instanceof Flt64AtomThunk)
            return new Complex(((Flt64AtomThunk) a).val);
        return switch (a.getType()) {
            case INTEGER -> new Complex(a.getInteger().doubleValue());
            case REAL -> new Complex(a.getReal().doubleValue());
            case COMPLEX -> new Complex(a.getComplex().re.doubleValue(), a.getComplex().im.doubleValue());
            default -> throw new IllegalArgumentException("Cannot convert " + a.getType() + " to cmplx64");
        };
    }

    public static Atom toAtom(Complex d) {
        return new Cmplx64AtomThunk(d);
    }
}
