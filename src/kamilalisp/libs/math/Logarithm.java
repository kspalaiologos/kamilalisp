package kamilalisp.libs.math;

import ch.obermuhlner.math.big.BigDecimalMath;
import kamilalisp.data.*;

import java.math.MathContext;
import java.util.List;

public class Logarithm {
    public static void install(Environment env) {
        env.push("log", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() == 1)
                    return new Atom(new LbcSupplier<>(() -> {
                        arguments.get(0).guardType("First argument to 'log'.", Type.NUMBER);
                        return BigDecimalMath.log10(arguments.get(0).getNumber().get(), MathContext.DECIMAL128);
                    }));
                else if(arguments.size() == 2)
                    return new Atom(new LbcSupplier<>(() -> {
                        arguments.get(0).guardType("First argument to 'log'.", Type.NUMBER);
                        arguments.get(1).guardType("Second argument to 'log'.", Type.NUMBER);
                        return BigDecimalMath.log(arguments.get(1).getNumber().get(), MathContext.DECIMAL128)
                                .divide(BigDecimalMath.log(arguments.get(0).getNumber().get(), MathContext.DECIMAL128), MathContext.DECIMAL128);
                    }));
                else
                    throw new Error("Invalid invocation to 'log'.");
            }
        }));

        env.push("log2", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'log2'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("First argument to 'log'.", Type.NUMBER);
                    return BigDecimalMath.log2(arguments.get(0).getNumber().get(), MathContext.DECIMAL128);
                }));
            }
        }));

        env.push("ln", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'ln'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("First argument to 'ln'.", Type.NUMBER);
                    return BigDecimalMath.log(arguments.get(0).getNumber().get(), MathContext.DECIMAL128);
                }));
            }
        }));
    }
}
