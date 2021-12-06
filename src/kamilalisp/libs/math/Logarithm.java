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
                            return BigDecimalMath.log10(arguments.get(0).getNumber().get(), Constant.getFr(env.env));
                        } else {
                            BigComplex log10 = BigComplexMath.log(BigComplex.valueOf(new BigDecimal(10), new BigDecimal(0)), Constant.getFr(env.env));
                            return BigComplexMath.log(arguments.get(0).getComplex().get(), Constant.getFr(env.env)).divide(log10, Constant.getFr(env.env));
                        }
                    }));
                else if(arguments.size() == 2)
                    return new Atom(new LbcSupplier<>(() -> {
                        arguments.get(0).guardType("First argument to 'log'.", Type.NUMBER, Type.COMPLEX);
                        arguments.get(1).guardType("Second argument to 'log'.", Type.NUMBER, Type.COMPLEX);
                        if(arguments.get(0).getType() == Type.NUMBER && arguments.get(1).getType() == Type.NUMBER) {
                            return BigDecimalMath.log(arguments.get(1).getNumber().get(), Constant.getFr(env.env))
                                    .divide(BigDecimalMath.log(arguments.get(0).getNumber().get(), Constant.getFr(env.env)), Constant.getFr(env.env));
                        } else {
                            BigComplex arg1;
                            if(arguments.get(0).getType() == Type.NUMBER)
                                arg1 = BigComplex.valueOf(BigDecimalMath.log(arguments.get(0).getNumber().get(), Constant.getFr(env.env)), new BigDecimal(0));
                            else
                                arg1 = BigComplexMath.log(arguments.get(0).getComplex().get(), Constant.getFr(env.env));

                            BigComplex arg2;
                            if(arguments.get(1).getType() == Type.NUMBER)
                                arg2 = BigComplex.valueOf(BigDecimalMath.log(arguments.get(1).getNumber().get(), Constant.getFr(env.env)), new BigDecimal(0));
                            else
                                arg2 = BigComplexMath.log(arguments.get(1).getComplex().get(), Constant.getFr(env.env));

                            return arg1.divide(arg2, Constant.getFr(env.env));
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
                        return BigDecimalMath.log2(arguments.get(0).getNumber().get(), Constant.getFr(env.env));
                    } else {
                        return BigComplexMath.log(arguments.get(0).getComplex().get(), Constant.getFr(env.env))
                                .divide(BigComplexMath.log(BigComplex.valueOf(new BigDecimal(2), new BigDecimal(0)),
                                        Constant.getFr(env.env)), Constant.getFr(env.env));
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
                        if(arguments.get(0).getNumber().get().compareTo(BigDecimal.ZERO) > 0)
                            return BigDecimalMath.log(arguments.get(0).getNumber().get(), Constant.getFr(env.env));
                        else
                            return BigComplexMath.log(BigComplex.valueOf(arguments.get(0).getNumber().get(), new BigDecimal(0)), Constant.getFr(env.env));
                    } else {
                        return BigComplexMath.log(arguments.get(0).getComplex().get(), Constant.getFr(env.env));
                    }
                }));
            }
        }));
    }
}
