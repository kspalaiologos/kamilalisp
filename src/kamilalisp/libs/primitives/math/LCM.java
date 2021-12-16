package kamilalisp.libs.primitives.math;

import ch.obermuhlner.math.big.BigComplex;
import kamilalisp.data.*;
import kamilalisp.libs.math.Constant;

import java.math.BigDecimal;
import java.util.List;

public class LCM implements Closure {
    private Atom lcm(Environment env, Atom a1, Atom a2) {
        a1.guardType("First argument to 'lcm'", Type.NUMBER, Type.COMPLEX);
        a2.guardType("Second argument to 'lcm'", Type.NUMBER, Type.COMPLEX);
        if(a1.getType() == Type.NUMBER && a2.getType() == Type.NUMBER) {
            return new Atom(a1.getNumber().get().multiply(a2.getNumber().get()).divide(GCD.gcd(env, a1, a2).getNumber().get()));
        } else {
            BigComplex a = asComplex(a1), b = asComplex(a2);
            assertGaussian(a);
            assertGaussian(b);
            return new Atom(a.multiply(b).divide(GCD.gaussianGcd(env, a, b), Constant.getFr(env)));
        }
    }

    private static void assertGaussian(BigComplex x) {
        assert x.re.stripTrailingZeros().scale() <= 0 && x.im.stripTrailingZeros().scale() <= 0;
    }

    public static BigComplex asComplex(Atom a) {
        a.guardType("Argument to 'asComplex'", Type.NUMBER, Type.COMPLEX);
        if(a.getType() == Type.NUMBER)
            return BigComplex.valueOf(a.getNumber().get(), BigDecimal.ZERO);
        else
            return a.getComplex().get();
    }

    @Override
    public Atom apply(Executor env, List<Atom> arguments) {
        if(arguments.size() == 0 || arguments.size() > 2)
            throw new Error("Invalid 'lcm' invocation.");
        if(arguments.size() == 1)
            return arguments.get(0);
        return new Atom(new LbcSupplier<>(() -> lcm(env.env, arguments.get(0), arguments.get(1)).get().get()));
    }
}
