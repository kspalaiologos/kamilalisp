package kamilalisp.libs.primitives.math;

import ch.obermuhlner.math.big.BigComplexMath;
import ch.obermuhlner.math.big.BigDecimalMath;
import kamilalisp.data.*;
import kamilalisp.libs.math.Constant;

import java.util.List;

public class Sqrt implements Closure {
    public static Atom sqrt(Atom a, Executor env) {
        a.guardType("First argument to 'sqrt'", Type.NUMBER, Type.COMPLEX);
        if(a.getType() == Type.NUMBER) {
            return new Atom(BigDecimalMath.sqrt(a.getNumber().get(), Constant.getFr(env.env)));
        } else {
            return new Atom(BigComplexMath.sqrt(a.getComplex().get(), Constant.getFr(env.env)));
        }
    }

    @Override
    public Atom apply(Executor env, List<Atom> arguments) {
        if(arguments.size() != 1)
            throw new Error("Invalid invocation to 'sqrt'.");
        return new Atom(new LbcSupplier<>(() -> {
            Atom a = arguments.get(0);
            return sqrt(a, env).get().get();
        }));
    }
}
