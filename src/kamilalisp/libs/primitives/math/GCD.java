package kamilalisp.libs.primitives.math;

import ch.obermuhlner.math.big.BigComplex;
import kamilalisp.data.*;
import kamilalisp.libs.math.Constant;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;

public class GCD implements Closure {
    public static Atom gcd(Environment env, Atom a1, Atom a2) {
        a1.guardType("First argument to 'gcd'", Type.NUMBER, Type.COMPLEX);
        a2.guardType("Second argument to 'gcd'", Type.NUMBER, Type.COMPLEX);
        if(a1.getType() == Type.NUMBER && a2.getType() == Type.NUMBER) {
            BigDecimal a = a1.getNumber().get();
            BigDecimal b = a2.getNumber().get();
            BigDecimal base = BigDecimal.ONE;
            int dpA = decimalPlaces(a);
            if(dpA > 0) {
                BigDecimal scale = BigDecimal.TEN.pow(dpA);
                a = a.multiply(scale);
                b = b.multiply(scale);
                base = base.multiply(scale);
            }
            int dpB = decimalPlaces(b);
            if(dpB > 0) {
                BigDecimal scale = BigDecimal.TEN.pow(dpB);
                a = a.multiply(scale);
                b = b.multiply(scale);
                base = base.multiply(scale);
            }
            return new Atom(new BigDecimal(a.toBigInteger().gcd(b.toBigInteger())).divide(base, Constant.getFr(env)));
        } else {
            BigComplex a = asComplex(a1), b = asComplex(a2);
            assertGaussian(a);
            assertGaussian(b);
            // compute gcd(a, b).
            return new Atom(gaussianGcd(env, a, b));
        }
    }

    public static BigComplex asComplex(Atom a) {
        a.guardType("Argument to 'asComplex'", Type.NUMBER, Type.COMPLEX);
        if(a.getType() == Type.NUMBER)
            return BigComplex.valueOf(a.getNumber().get(), BigDecimal.ZERO);
        else
            return a.getComplex().get();
    }

    private static BigComplex gaussianRem(Environment env, BigComplex a, BigComplex b) {
        BigComplex prod = a.multiply(b.conjugate());
        BigDecimal p = prod.re.divide(b.absSquare(Constant.getFr(env)), Constant.getFr(env));
        BigDecimal q = prod.im.divide(b.absSquare(Constant.getFr(env)), Constant.getFr(env));
        BigComplex gamma = BigComplex.valueOf(p.setScale(0, RoundingMode.HALF_EVEN), q.setScale(0, RoundingMode.HALF_EVEN));
        BigComplex rho = a.subtract(gamma.multiply(b));
        return rho;
    }

    private static void assertGaussian(BigComplex x) {
        assert x.re.stripTrailingZeros().scale() <= 0 && x.im.stripTrailingZeros().scale() <= 0;
    }

    private static int decimalPlaces(BigDecimal number) {
        int scale = number.stripTrailingZeros().scale();
        return scale > 0 ? scale : 0;
    }

    public static BigComplex gaussianGcd(Environment env, BigComplex alpha, BigComplex beta) {
        if (gaussianRem(env, alpha, beta).equals(BigComplex.ZERO))
            return beta;
        return gaussianGcd(env, beta, gaussianRem(env, alpha, beta));
    }

    @Override
    public Atom apply(Executor env, List<Atom> arguments) {
        if(arguments.size() == 0 || arguments.size() > 2)
            throw new Error("Invalid 'gcd' invocation.");
        if(arguments.size() == 1)
            return arguments.get(0);
        return new Atom(new LbcSupplier<>(() -> gcd(env.env, arguments.get(0), arguments.get(1)).get().get()));
    }
}
