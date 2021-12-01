package kamilalisp.libs.primitives.math;

import ch.obermuhlner.math.big.BigComplex;
import kamilalisp.data.*;
import kamilalisp.libs.math.Constant;

import java.math.BigDecimal;
import java.util.List;

public class Remainder implements Closure {
    public static BigDecimal norm(Environment env, BigComplex x) {
        return x.re.pow(2).add(x.im.pow(2)).sqrt(Constant.getFr(env));
    }

    @Override
    public Atom apply(Executor env, List<Atom> arguments) {
        if(arguments.size() == 0 || arguments.size() > 2)
            throw new Error("Invalid % invocation.");
        if(arguments.size() == 1) {
            return new Atom(new LbcSupplier<>(() -> {
                arguments.get(0).guardType("Argument to monadic %", Type.NUMBER, Type.COMPLEX);

                if(arguments.get(0).getType() == Type.NUMBER) {
                    return arguments.get(0).getNumber().get().abs();
                } else if(arguments.get(0).getType() == Type.COMPLEX) {
                    return norm(env.env, arguments.get(0).getComplex().get());
                }

                throw new Error("unreachable.");
            }));
        } else
            return new Atom(new LbcSupplier<>(() -> {
                arguments.get(0).guardType("Argument to dyadic %", Type.NUMBER);
                arguments.get(1).guardType("Argument to dyadic %", Type.NUMBER);
                return arguments.get(0).getNumber().get().remainder(arguments.get(1).getNumber().get());
            }));
    }
}
