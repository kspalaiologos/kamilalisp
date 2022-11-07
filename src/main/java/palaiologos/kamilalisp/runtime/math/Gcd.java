package palaiologos.kamilalisp.runtime.math;

import ch.obermuhlner.math.big.BigComplex;
import com.google.common.collect.Streams;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.ArrayError;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;

public class Gcd extends PrimitiveFunction implements Lambda {
    @Override
    protected String name() {
        return "gcd";
    }

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
        a.assertTypes(Type.REAL, Type.COMPLEX, Type.LIST);
        b.assertTypes(Type.REAL, Type.COMPLEX, Type.LIST);
        if(a.getType() == Type.LIST && b.getType() == Type.LIST) {
            return new Atom(Streams.zip(a.getList().stream(), b.getList().stream(), (x, y) -> gcd2(e, x, y)).toList());
        } else if(a.getType() == Type.REAL && b.getType() == Type.REAL) {
            BigDecimal aD = a.getReal();
            BigDecimal bD = b.getReal();
            BigDecimal base = BigDecimal.ONE;
            int dpA = decimalPlaces(aD);
            if(dpA > 0) {
                BigDecimal scale = BigDecimal.TEN.pow(dpA);
                aD = aD.multiply(scale);
                bD = bD.multiply(scale);
                base = base.multiply(scale);
            }
            int dpB = decimalPlaces(bD);
            if(dpB > 0) {
                BigDecimal scale = BigDecimal.TEN.pow(dpB);
                aD = aD.multiply(scale);
                bD = bD.multiply(scale);
                base = base.multiply(scale);
            }
            return new Atom(new BigDecimal(aD.toBigInteger().gcd(bD.toBigInteger())).divide(base, e.getMathContext()));
        } else if(a.getType() == Type.LIST && b.isNumeric()) {
            return new Atom(a.getList().stream().map(x -> gcd2(e, x, b)).toList());
        } else if(a.isNumeric() && b.getType() == Type.LIST) {
            return new Atom(b.getList().stream().map(x -> gcd2(e, a, x)).toList());
        } else {
            BigComplex aD = a.getComplex(), bD = b.getComplex();
            // Scale aD and bD to integers
            BigDecimal base = BigDecimal.ONE;
            int dp = Math.max(Math.max(decimalPlaces(aD.re), decimalPlaces(aD.im)), Math.max(decimalPlaces(bD.re), decimalPlaces(bD.im)));
            if(dp > 0) {
                BigDecimal scale = BigDecimal.TEN.pow(dp);
                aD = BigComplex.valueOf(aD.re.multiply(scale), aD.im.multiply(scale));
                bD = BigComplex.valueOf(bD.re.multiply(scale), bD.im.multiply(scale));
                base = base.multiply(scale);
            }
            BigComplex result = gaussianGcd(e, aD, bD);
            if(dp > 0) {
                result = BigComplex.valueOf(result.re.divide(base, e.getMathContext()), result.im.divide(base, e.getMathContext()));
            }
            if(result.isReal())
                return new Atom(result.re);
            else
                return new Atom(result);
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.size() == 1 && args.get(0).getType() == Type.LIST)
            return args.get(0).getList().stream().reduce((a, b) -> gcd2(env, a, b)).orElseThrow(() -> new ArrayError("can't fold a list with gcd."));
        else if(args.size() <= 1)
            throw new RuntimeException("gcd called with too few arguments.");

        return args.stream().reduce((a, b) -> gcd2(env, a, b)).orElseThrow(() -> new ArrayError("can't fold a list with gcd."));
    }
}
