package palaiologos.kamilalisp.runtime.math;

import ch.obermuhlner.math.big.BigComplex;
import com.google.common.collect.Streams;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.ArrayError;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class Gcd extends PrimitiveFunction implements Lambda {
    private static BigComplex gaussianRem(Environment env, BigComplex a, BigComplex b) {
        BigComplex prod = a.multiply(b.conjugate());
        BigDecimal p = prod.re.divide(b.absSquare(env.getMathContext()), env.getMathContext());
        BigDecimal q = prod.im.divide(b.absSquare(env.getMathContext()), env.getMathContext());
        BigComplex gamma = BigComplex.valueOf(p.setScale(0, RoundingMode.HALF_EVEN), q.setScale(0, RoundingMode.HALF_EVEN));
        return a.subtract(gamma.multiply(b));
    }

    private static void assertGaussian(BigComplex x) {
        assert x.re.stripTrailingZeros().scale() <= 0 && x.im.stripTrailingZeros().scale() <= 0;
    }

    private static int decimalPlaces(BigDecimal x) {
        int scale = x.stripTrailingZeros().scale();
        return Math.max(scale, 0);
    }

    private static BigComplex gaussianGcd(Environment env, BigComplex alpha, BigComplex beta) {
        if (gaussianRem(env, alpha, beta).equals(BigComplex.ZERO))
            return beta;
        return gaussianGcd(env, beta, gaussianRem(env, alpha, beta));
    }

    public static Atom gcd2(Environment e, Atom a, Atom b) {
        a.assertTypes(Type.INTEGER, Type.REAL, Type.COMPLEX, Type.LIST);
        b.assertTypes(Type.INTEGER, Type.REAL, Type.COMPLEX, Type.LIST);
        if (a.getType() == Type.LIST && b.getType() == Type.LIST) {
            int min = Math.min(a.getList().size(), b.getList().size());
            ArrayList<Atom> result = new ArrayList<>(min);
            for (int i = 0; i < min; i++) {
                result.add(gcd2(e, a.getList().get(i), b.getList().get(i)));
            }
            return new Atom(result);
        } else if (a.getType() == Type.INTEGER && b.getType() == Type.INTEGER) {
            return new Atom(a.getInteger().gcd(b.getInteger()));
        } else if ((a.getType() == Type.REAL || a.getType() == Type.INTEGER) && (b.getType() == Type.REAL || b.getType() == Type.INTEGER)) {
            BigDecimal aD = a.getReal();
            BigDecimal bD = b.getReal();
            BigDecimal base = BigDecimal.ONE;
            int dpA = decimalPlaces(aD);
            if (dpA > 0) {
                BigDecimal scale = BigDecimal.TEN.pow(dpA);
                aD = aD.multiply(scale);
                bD = bD.multiply(scale);
                base = base.multiply(scale);
            }
            int dpB = decimalPlaces(bD);
            if (dpB > 0) {
                BigDecimal scale = BigDecimal.TEN.pow(dpB);
                aD = aD.multiply(scale);
                bD = bD.multiply(scale);
                base = base.multiply(scale);
            }
            return new Atom(new BigDecimal(aD.toBigInteger().gcd(bD.toBigInteger())).divide(base, e.getMathContext()));
        } else if (a.getType() == Type.LIST && b.isNumeric()) {
            ArrayList<Atom> list = new ArrayList<>(a.getList().size());
            for (Atom x : a.getList()) {
                Atom atom = gcd2(e, x, b);
                list.add(atom);
            }
            return new Atom(list);
        } else if (a.isNumeric() && b.getType() == Type.LIST) {
            ArrayList<Atom> list = new ArrayList<>(b.getList().size());
            for (Atom x : b.getList()) {
                Atom atom = gcd2(e, a, x);
                list.add(atom);
            }
            return new Atom(list);
        } else {
            BigComplex aD = a.getComplex(), bD = b.getComplex();
            // Scale aD and bD to integers
            BigDecimal base = BigDecimal.ONE;
            int dp = Math.max(Math.max(decimalPlaces(aD.re), decimalPlaces(aD.im)), Math.max(decimalPlaces(bD.re), decimalPlaces(bD.im)));
            if (dp > 0) {
                BigDecimal scale = BigDecimal.TEN.pow(dp);
                aD = BigComplex.valueOf(aD.re.multiply(scale), aD.im.multiply(scale));
                bD = BigComplex.valueOf(bD.re.multiply(scale), bD.im.multiply(scale));
                base = base.multiply(scale);
            }
            BigComplex result = gaussianGcd(e, aD, bD);
            if (dp > 0) {
                result = BigComplex.valueOf(result.re.divide(base, e.getMathContext()), result.im.divide(base, e.getMathContext()));
            }
            if (result.isReal())
                return new Atom(result.re);
            else
                return new Atom(result);
        }
    }

    @Override
    protected String name() {
        return "gcd";
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() == 1 && args.get(0).getType() == Type.LIST) {
            boolean seen = false;
            Atom acc = null;
            for (Atom atom : args.get(0).getList()) {
                if (!seen) {
                    seen = true;
                    acc = atom;
                } else {
                    acc = gcd2(env, acc, atom);
                }
            }
            return (seen ? Optional.of(acc) : Optional.<Atom>empty()).orElseThrow(() -> new ArrayError("can't fold a list with gcd."));
        }
        else if (args.size() <= 1)
            throw new RuntimeException("gcd called with too few arguments.");

        boolean seen = false;
        Atom acc = null;
        for (Atom arg : args) {
            if (!seen) {
                seen = true;
                acc = arg;
            } else {
                acc = gcd2(env, acc, arg);
            }
        }
        return acc;
    }
}
