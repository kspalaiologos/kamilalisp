package palaiologos.kamilalisp.runtime.math;

import ch.obermuhlner.math.big.BigComplex;
import ch.obermuhlner.math.big.BigComplexMath;
import ch.obermuhlner.math.big.BigDecimalMath;
import ch.obermuhlner.math.big.BigRational;
import org.apfloat.Apcomplex;
import org.apfloat.ApcomplexMath;
import org.apfloat.Apfloat;
import org.apfloat.ApfloatMath;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.math.BigDecimal;
import java.math.MathContext;
import java.util.ArrayList;
import java.util.List;

public class Digamma extends PrimitiveFunction implements Lambda {
    // Horrible, but that's the easiest solution.

    private static BigDecimal digamma(BigDecimal x, MathContext mc) {
        return new BigDecimal(ApfloatMath.digamma(new Apfloat(x.toString(), mc.getPrecision())).toString());
    }

    private static BigComplex digamma(BigComplex x, MathContext mc) {
        Apcomplex c = new Apcomplex(new Apfloat(x.re.toString(), mc.getPrecision()), new Apfloat(x.im.toString(), mc.getPrecision()));
        Apcomplex dig = ApcomplexMath.digamma(c);
        return BigComplex.valueOf(new BigDecimal(dig.real().toString()), new BigDecimal(dig.imag().toString()));
    }

    private static Atom gamma1(Environment e, Atom a) {
        a.assertTypes(Type.INTEGER, Type.REAL, Type.COMPLEX, Type.LIST);
        if (a.getType() == Type.COMPLEX) {
            return new Atom(digamma(a.getComplex(), e.getMathContext()));
        } else if (a.getType() == Type.REAL || a.getType() == Type.INTEGER) {
            return new Atom(digamma(a.getReal(), e.getMathContext()));
        } else if (a.getType() == Type.LIST) {
            ArrayList<Atom> list = new ArrayList<>(a.getList().size());
            for (Atom x : a.getList()) {
                Atom atom = gamma1(e, x);
                list.add(atom);
            }
            return new Atom(list);
        } else {
            throw new TypeError("`digamma' not defined for: " + a.getType());
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() == 1) {
            return gamma1(env, args.get(0));
        } else if (args.isEmpty()) {
            throw new TypeError("Expected 1 or more arguments to `digamma'.");
        } else {
            ArrayList<Atom> list = new ArrayList<>(args.size());
            for (Atom x : args) {
                Atom atom = gamma1(env, x);
                list.add(atom);
            }
            return new Atom(list);
        }
    }

    @Override
    protected String name() {
        return "digamma";
    }
}