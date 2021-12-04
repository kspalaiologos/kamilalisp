package kamilalisp.libs.primitives.math;

import ch.obermuhlner.math.big.BigComplex;
import ch.obermuhlner.math.big.BigComplexMath;
import ch.obermuhlner.math.big.BigDecimalMath;
import kamilalisp.data.*;
import kamilalisp.libs.math.Constant;
import kamilalisp.data.Matrix;

import java.math.BigDecimal;
import java.util.List;

public class Power implements Closure {
    private static void assertGaussian(BigComplex x) {
        assert x.re.stripTrailingZeros().scale() <= 0 && x.im.stripTrailingZeros().scale() <= 0;
    }

    public static Atom power(Atom a1, Atom a2, Executor env) {
        a1.guardType("First argument to '**'", Type.NUMBER, Type.COMPLEX, Type.MATRIX);
        a2.guardType("Second argument to '**'", Type.NUMBER, Type.COMPLEX);
        if(a1.getType() == Type.NUMBER && a2.getType() == Type.NUMBER) {
            if (a2.getNumber().get().stripTrailingZeros().scale() > 0)
                return new Atom(BigDecimalMath.pow(a1.getNumber().get(), a2.getNumber().get(), Constant.getFr(env.env)));
            else
                return new Atom(a1.getNumber().get().pow(a2.getNumber().get().intValue()));
        } else if(a1.getType() == Type.MATRIX) {
            int power = a2.getNumber().get().intValue();
            Matrix mat = a1.getMatrix().get();
            Matrix base = mat;
            if(power == 0)
                return new Atom(Matrix.of((x, y) -> new Atom(BigDecimal.ZERO), mat.getRows(), mat.getCols()));
            for(int i = 1; i < power; i++)
                mat = Product.mul2(new Atom(mat), new Atom(base)).getMatrix().get();
            return new Atom(mat);
        } else {
            BigComplex a, b;
            if(a1.getType() == Type.NUMBER) { a = BigComplex.valueOf(a1.getNumber().get(), BigDecimal.ZERO); }
            else { a = a1.getComplex().get(); }
            if(a2.getType() == Type.NUMBER) { b = BigComplex.valueOf(a2.getNumber().get(), BigDecimal.ZERO); }
            else { b = a2.getComplex().get(); }
            assertGaussian(a);
            assertGaussian(b);
            return new Atom(BigComplexMath.pow(a, b, Constant.getFr(env.env)));
        }
    }

    @Override
    public Atom apply(Executor env, List<Atom> arguments) {
        if(arguments.size() != 2)
            throw new Error("Invalid invocation to '**'.");
        return new Atom(new LbcSupplier<>(() -> {
            Atom a1 = arguments.get(0);
            Atom a2 = arguments.get(1);
            return power(a1, a2, env).get().get();
        }));
    }
}
