package kamilalisp.libs.math;

import ch.obermuhlner.math.big.BigComplex;
import ch.obermuhlner.math.big.BigComplexMath;
import ch.obermuhlner.math.big.BigDecimalMath;
import kamilalisp.data.*;

import java.math.BigDecimal;
import java.math.MathContext;
import java.util.List;

public class Trigonometry {
    public static void install(Environment env) {
        env.push("sin", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'sin'.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom a = arguments.get(0);
                    a.guardType("First argument to 'sin'", Type.NUMBER, Type.COMPLEX);
                    if(a.getType() == Type.NUMBER) {
                        return BigDecimalMath.sin(a.getNumber().get(), MathContext.DECIMAL128);
                    } else {
                        return BigComplexMath.sin(a.getComplex().get(), MathContext.DECIMAL128);
                    }
                }));
            }
        }));

        env.push("csec", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'csc'.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom a = arguments.get(0);
                    a.guardType("First argument to 'csc'", Type.NUMBER, Type.COMPLEX);
                    if(a.getType() == Type.NUMBER) {
                        return BigDecimal.valueOf(1).divide(BigDecimalMath.sin(a.getNumber().get(), MathContext.DECIMAL128), MathContext.DECIMAL128);
                    } else {
                        return BigComplex.valueOf(BigDecimal.ONE, BigDecimal.ONE)
                                .divide(BigComplexMath.sin(a.getComplex().get(), MathContext.DECIMAL128), MathContext.DECIMAL128);
                    }
                }));
            }
        }));

        env.push("cos", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'cos'.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom a = arguments.get(0);
                    a.guardType("First argument to 'cos'", Type.NUMBER, Type.COMPLEX);
                    if(a.getType() == Type.NUMBER) {
                        return BigDecimalMath.cos(a.getNumber().get(), MathContext.DECIMAL128);
                    } else {
                        return BigComplexMath.cos(a.getComplex().get(), MathContext.DECIMAL128);
                    }
                }));
            }
        }));

        env.push("sec", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'sec'.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom a = arguments.get(0);
                    a.guardType("First argument to 'sec'", Type.NUMBER, Type.COMPLEX);
                    if(a.getType() == Type.NUMBER) {
                        return BigDecimal.valueOf(1).divide(BigDecimalMath.cos(a.getNumber().get(), MathContext.DECIMAL128), MathContext.DECIMAL128);
                    } else {
                        return BigComplex.valueOf(BigDecimal.ONE, BigDecimal.ONE)
                                .divide(BigComplexMath.cos(a.getComplex().get(), MathContext.DECIMAL128), MathContext.DECIMAL128);
                    }
                }));
            }
        }));

        env.push("tan", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'tan'.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom a = arguments.get(0);
                    a.guardType("First argument to 'tan'", Type.NUMBER, Type.COMPLEX);
                    if(a.getType() == Type.NUMBER) {
                        return BigDecimalMath.tan(a.getNumber().get(), MathContext.DECIMAL128);
                    } else {
                        return BigComplexMath.tan(a.getComplex().get(), MathContext.DECIMAL128);
                    }
                }));
            }
        }));

        env.push("ctan", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'ctan'.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom a = arguments.get(0);
                    a.guardType("First argument to 'ctan'", Type.NUMBER, Type.COMPLEX);
                    if(a.getType() == Type.NUMBER) {
                        return BigDecimal.valueOf(1).divide(BigDecimalMath.tan(a.getNumber().get(), MathContext.DECIMAL128), MathContext.DECIMAL128);
                    } else {
                        return BigComplex.valueOf(BigDecimal.ONE, BigDecimal.ONE)
                                .divide(BigComplexMath.tan(a.getComplex().get(), MathContext.DECIMAL128), MathContext.DECIMAL128);
                    }
                }));
            }
        }));

        env.push("rad", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'rad'.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom a = arguments.get(0);
                    a.guardType("First argument to 'rad'", Type.NUMBER);
                    return a.getNumber().get().multiply(BigDecimalMath.pi(MathContext.DECIMAL128).divide(BigDecimal.valueOf(180), MathContext.DECIMAL128));
                }));
            }
        }));

        env.push("deg", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'deg'.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom a = arguments.get(0);
                    a.guardType("First argument to 'deg'", Type.NUMBER);
                    return a.getNumber().get().multiply(BigDecimal.valueOf(180).divide(BigDecimalMath.pi(MathContext.DECIMAL128), MathContext.DECIMAL128));
                }));
            }
        }));

        env.push("arcsin", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'arcsin'.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom a = arguments.get(0);
                    a.guardType("First argument to 'arcsin'", Type.NUMBER, Type.COMPLEX);
                    if(a.getType() == Type.NUMBER) {
                        return BigDecimalMath.asin(a.getNumber().get(), MathContext.DECIMAL128);
                    } else {
                        return BigComplexMath.asin(a.getComplex().get(), MathContext.DECIMAL128);
                    }
                }));
            }
        }));

        env.push("arccos", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'arccos'.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom a = arguments.get(0);
                    a.guardType("First argument to 'arccos'", Type.NUMBER, Type.COMPLEX);
                    if(a.getType() == Type.NUMBER) {
                        return BigDecimalMath.acos(a.getNumber().get(), MathContext.DECIMAL128);
                    } else {
                        return BigComplexMath.acos(a.getComplex().get(), MathContext.DECIMAL128);
                    }
                }));
            }
        }));

        env.push("arctan", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'arctan'.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom a = arguments.get(0);
                    a.guardType("First argument to 'arctan'", Type.NUMBER, Type.COMPLEX);
                    if(a.getType() == Type.NUMBER) {
                        return BigDecimalMath.atan(a.getNumber().get(), MathContext.DECIMAL128);
                    } else {
                        return BigComplexMath.atan(a.getComplex().get(), MathContext.DECIMAL128);
                    }
                }));
            }
        }));

        env.push("arctan2", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2)
                    throw new Error("Invalid invocation to 'arctan2'.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom a = arguments.get(0);
                    Atom b = arguments.get(1);
                    a.guardType("First argument to 'arctan2'", Type.NUMBER);
                    b.guardType("Second argument to 'arctan2'", Type.NUMBER);
                    return BigDecimalMath.atan2(a.getNumber().get(), b.getNumber().get(), MathContext.DECIMAL128);
                }));
            }
        }));

        env.push("arcctan", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'arcctan'.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom a = arguments.get(0);
                    a.guardType("First argument to 'arcctan'", Type.NUMBER, Type.COMPLEX);
                    if(a.getType() == Type.NUMBER) {
                        return BigDecimalMath.acot(a.getNumber().get(), MathContext.DECIMAL128);
                    } else {
                        return BigComplexMath.acot(a.getComplex().get(), MathContext.DECIMAL128);
                    }
                }));
            }
        }));

        env.push("arcsec", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'arcsec'.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom a = arguments.get(0);
                    a.guardType("First argument to 'arcsec'", Type.NUMBER, Type.COMPLEX);
                    if(a.getType() == Type.NUMBER) {
                        return BigDecimalMath.acos(BigDecimal.ONE.divide(a.getNumber().get(), MathContext.DECIMAL128), MathContext.DECIMAL128);
                    } else {
                        return BigComplexMath.acos(BigComplex.ONE.divide(a.getComplex().get(), MathContext.DECIMAL128), MathContext.DECIMAL128);
                    }
                }));
            }
        }));

        env.push("arccsec", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'arccsec'.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom a = arguments.get(0);
                    a.guardType("First argument to 'arccsec'", Type.NUMBER, Type.COMPLEX);
                    if(a.getType() == Type.NUMBER) {
                        return BigDecimalMath.asin(BigDecimal.ONE.divide(a.getNumber().get(), MathContext.DECIMAL128), MathContext.DECIMAL128);
                    } else {
                        return BigComplexMath.asin(BigComplex.ONE.divide(a.getComplex().get(), MathContext.DECIMAL128), MathContext.DECIMAL128);
                    }
                }));
            }
        }));

        env.push("sinh", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'sinh'.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom a = arguments.get(0);
                    a.guardType("First argument to 'sinh'", Type.NUMBER, Type.COMPLEX);
                    if(a.getType() == Type.NUMBER) {
                        return BigDecimalMath.sinh(a.getNumber().get(), MathContext.DECIMAL128);
                    } else {
                        return BigComplex.valueOf(
                                BigDecimalMath.sinh(a.getComplex().get().re, MathContext.DECIMAL128).multiply(BigDecimalMath.cos(a.getComplex().get().im, MathContext.DECIMAL128)),
                                BigDecimalMath.cosh(a.getComplex().get().re, MathContext.DECIMAL128).multiply(BigDecimalMath.sin(a.getComplex().get().im, MathContext.DECIMAL128))
                        );
                    }
                }));
            }
        }));

        env.push("cosh", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'cosh'.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom a = arguments.get(0);
                    a.guardType("First argument to 'cosh'", Type.NUMBER, Type.COMPLEX);
                    if(a.getType() == Type.NUMBER) {
                        return BigDecimalMath.cosh(a.getNumber().get(), MathContext.DECIMAL128);
                    } else {
                        return BigComplex.valueOf(
                                BigDecimalMath.cosh(a.getComplex().get().re, MathContext.DECIMAL128).multiply(BigDecimalMath.cos(a.getComplex().get().im, MathContext.DECIMAL128)),
                                BigDecimalMath.sinh(a.getComplex().get().re, MathContext.DECIMAL128).multiply(BigDecimalMath.sin(a.getComplex().get().im, MathContext.DECIMAL128))
                        );
                    }
                }));
            }
        }));

        env.push("tanh", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'tanh'.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom a = arguments.get(0);
                    a.guardType("First argument to 'tanh'", Type.NUMBER, Type.COMPLEX);
                    if(a.getType() == Type.NUMBER) {
                        return BigDecimalMath.cosh(a.getNumber().get(), MathContext.DECIMAL128);
                    } else {
                        BigComplex sine = BigComplex.valueOf(
                                BigDecimalMath.sinh(a.getComplex().get().re, MathContext.DECIMAL128).multiply(BigDecimalMath.cos(a.getComplex().get().im, MathContext.DECIMAL128)),
                                BigDecimalMath.cosh(a.getComplex().get().re, MathContext.DECIMAL128).multiply(BigDecimalMath.sin(a.getComplex().get().im, MathContext.DECIMAL128))
                        );

                        BigComplex cosine = BigComplex.valueOf(
                                BigDecimalMath.cosh(a.getComplex().get().re, MathContext.DECIMAL128).multiply(BigDecimalMath.cos(a.getComplex().get().im, MathContext.DECIMAL128)),
                                BigDecimalMath.sinh(a.getComplex().get().re, MathContext.DECIMAL128).multiply(BigDecimalMath.sin(a.getComplex().get().im, MathContext.DECIMAL128))
                        );

                        return sine.divide(cosine, MathContext.DECIMAL128);
                    }
                }));
            }
        }));

        env.push("ctanh", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'ctanh'.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom a = arguments.get(0);
                    a.guardType("First argument to 'ctanh'", Type.NUMBER, Type.COMPLEX);
                    if(a.getType() == Type.NUMBER) {
                        return BigDecimalMath.coth(a.getNumber().get(), MathContext.DECIMAL128);
                    } else {
                        BigComplex sine = BigComplex.valueOf(
                                BigDecimalMath.sinh(a.getComplex().get().re, MathContext.DECIMAL128).multiply(BigDecimalMath.cos(a.getComplex().get().im, MathContext.DECIMAL128)),
                                BigDecimalMath.cosh(a.getComplex().get().re, MathContext.DECIMAL128).multiply(BigDecimalMath.sin(a.getComplex().get().im, MathContext.DECIMAL128))
                        );

                        BigComplex cosine = BigComplex.valueOf(
                                BigDecimalMath.cosh(a.getComplex().get().re, MathContext.DECIMAL128).multiply(BigDecimalMath.cos(a.getComplex().get().im, MathContext.DECIMAL128)),
                                BigDecimalMath.sinh(a.getComplex().get().re, MathContext.DECIMAL128).multiply(BigDecimalMath.sin(a.getComplex().get().im, MathContext.DECIMAL128))
                        );

                        return cosine.divide(sine, MathContext.DECIMAL128);
                    }
                }));
            }
        }));

        env.push("arcsinh", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'arcsinh'.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom a = arguments.get(0);
                    a.guardType("First argument to 'arcsinh'", Type.NUMBER, Type.COMPLEX);
                    if(a.getType() == Type.NUMBER) {
                        return BigDecimalMath.asinh(a.getNumber().get(), MathContext.DECIMAL128);
                    } else {
                        // log(sqrt(1 + a) + a)
                        BigComplex rt = BigComplexMath.sqrt(BigComplex.ONE.add(a.getComplex().get(), MathContext.DECIMAL128), MathContext.DECIMAL128);
                        BigComplex log = BigComplexMath.log(rt.add(a.getComplex().get(), MathContext.DECIMAL128), MathContext.DECIMAL128);
                        return log;
                    }
                }));
            }
        }));

        env.push("arccosh", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'arccosh'.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom a = arguments.get(0);
                    a.guardType("First argument to 'arccosh'", Type.NUMBER, Type.COMPLEX);
                    if(a.getType() == Type.NUMBER) {
                        return BigDecimalMath.acosh(a.getNumber().get(), MathContext.DECIMAL128);
                    } else {
                        // log(sqrt(a - 1) * sqrt(a + 1) + a)
                        BigComplex rt = BigComplexMath.sqrt(a.getComplex().get().subtract(BigComplex.ONE, MathContext.DECIMAL128), MathContext.DECIMAL128);
                        BigComplex rt2 = BigComplexMath.sqrt(a.getComplex().get().add(BigComplex.ONE, MathContext.DECIMAL128), MathContext.DECIMAL128);
                        BigComplex log = BigComplexMath.log(rt.multiply(rt2, MathContext.DECIMAL128).add(a.getComplex().get(), MathContext.DECIMAL128), MathContext.DECIMAL128);
                        return log;
                    }
                }));
            }
        }));

        env.push("arctanh", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'arctanh'.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom a = arguments.get(0);
                    a.guardType("First argument to 'arctanh'", Type.NUMBER, Type.COMPLEX);
                    if(a.getType() == Type.NUMBER) {
                        return BigDecimalMath.atanh(a.getNumber().get(), MathContext.DECIMAL128);
                    } else {
                        // (log(1 + a) - log(1 - a)) / 2
                        BigComplex l1 = BigComplexMath.log(BigComplex.ONE.add(a.getComplex().get(), MathContext.DECIMAL128), MathContext.DECIMAL128);
                        BigComplex l2 = BigComplexMath.log(BigComplex.ONE.subtract(a.getComplex().get(), MathContext.DECIMAL128), MathContext.DECIMAL128);
                        BigComplex log = l1.subtract(l2, MathContext.DECIMAL128).divide(BigDecimal.valueOf(2), MathContext.DECIMAL128);
                        return log;
                    }
                }));
            }
        }));

        env.push("arcctanh", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'arcctanh'.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom a = arguments.get(0);
                    a.guardType("First argument to 'arcctanh'", Type.NUMBER, Type.COMPLEX);
                    if(a.getType() == Type.NUMBER) {
                        return BigDecimalMath.acoth(a.getNumber().get(), MathContext.DECIMAL128);
                    } else {
                        // (log(1 + 1/a) - log(1 - 1/a)) / 2
                        BigComplex arg = a.getComplex().get().reciprocal(MathContext.DECIMAL128);
                        BigComplex l1 = BigComplexMath.log(BigComplex.ONE.add(arg, MathContext.DECIMAL128), MathContext.DECIMAL128);
                        BigComplex l2 = BigComplexMath.log(BigComplex.ONE.subtract(arg, MathContext.DECIMAL128), MathContext.DECIMAL128);
                        BigComplex log = l1.subtract(l2, MathContext.DECIMAL128).divide(BigDecimal.valueOf(2), MathContext.DECIMAL128);
                        return log;
                    }
                }));
            }
        }));
    }
}
