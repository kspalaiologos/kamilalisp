package kamilalisp.libs.math;

import ch.obermuhlner.math.big.BigComplex;
import ch.obermuhlner.math.big.BigComplexMath;
import ch.obermuhlner.math.big.BigDecimalMath;
import kamilalisp.data.*;

import java.math.BigDecimal;
import java.math.MathContext;
import java.util.List;

public class Logarithm {
    public static void install(Environment env) {
        env.push("log", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() == 1)
                    return new Atom(new LbcSupplier<>(() -> {
                        arguments.get(0).guardType("First argument to 'log'.", Type.NUMBER, Type.COMPLEX);
                        if(arguments.get(0).getType() == Type.NUMBER) {
                            return BigDecimalMath.log10(arguments.get(0).getNumber().get(), MathContext.DECIMAL128);
                        } else {
                            BigComplex log10 = BigComplexMath.log(BigComplex.valueOf(new BigDecimal(10), new BigDecimal(0)), MathContext.DECIMAL128);
                            return BigComplexMath.log(arguments.get(0).getComplex().get(), MathContext.DECIMAL128).divide(log10, MathContext.DECIMAL128);
                        }
                    }));
                else if(arguments.size() == 2)
                    return new Atom(new LbcSupplier<>(() -> {
                        arguments.get(0).guardType("First argument to 'log'.", Type.NUMBER, Type.COMPLEX);
                        arguments.get(1).guardType("Second argument to 'log'.", Type.NUMBER, Type.COMPLEX);
                        if(arguments.get(0).getType() == Type.NUMBER && arguments.get(1).getType() == Type.NUMBER) {
                            return BigDecimalMath.log(arguments.get(1).getNumber().get(), MathContext.DECIMAL128)
                                    .divide(BigDecimalMath.log(arguments.get(0).getNumber().get(), MathContext.DECIMAL128), MathContext.DECIMAL128);
                        } else {
                            BigComplex arg1;
                            if(arguments.get(0).getType() == Type.NUMBER)
                                arg1 = BigComplex.valueOf(BigDecimalMath.log(arguments.get(0).getNumber().get(), MathContext.DECIMAL128), new BigDecimal(0));
                            else
                                arg1 = BigComplexMath.log(arguments.get(0).getComplex().get(), MathContext.DECIMAL128);

                            BigComplex arg2;
                            if(arguments.get(1).getType() == Type.NUMBER)
                                arg2 = BigComplex.valueOf(BigDecimalMath.log(arguments.get(1).getNumber().get(), MathContext.DECIMAL128), new BigDecimal(0));
                            else
                                arg2 = BigComplexMath.log(arguments.get(1).getComplex().get(), MathContext.DECIMAL128);

                            return arg1.divide(arg2, MathContext.DECIMAL128);
                        }
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
                    arguments.get(0).guardType("First argument to 'log'.", Type.NUMBER, Type.COMPLEX);
                    if(arguments.get(0).getType() == Type.NUMBER) {
                        return BigDecimalMath.log2(arguments.get(0).getNumber().get(), MathContext.DECIMAL128);
                    } else {
                        return BigComplexMath.log(arguments.get(0).getComplex().get(), MathContext.DECIMAL128)
                                .divide(BigComplexMath.log(BigComplex.valueOf(new BigDecimal(2), new BigDecimal(0)),
                                        MathContext.DECIMAL128), MathContext.DECIMAL128);
                    }
                }));
            }
        }));

        env.push("ln", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'ln'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("First argument to 'ln'.", Type.NUMBER, Type.COMPLEX);
                    if(arguments.get(0).getType() == Type.NUMBER) {
                        return BigDecimalMath.log(arguments.get(0).getNumber().get(), MathContext.DECIMAL128);
                    } else {
                        return BigComplexMath.log(arguments.get(0).getComplex().get(), MathContext.DECIMAL128);
                    }
                }));
            }
        }));
    }
}
