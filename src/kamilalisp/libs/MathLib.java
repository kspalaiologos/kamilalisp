package kamilalisp.libs;

import ch.obermuhlner.math.big.BigComplex;
import ch.obermuhlner.math.big.BigComplexMath;
import ch.obermuhlner.math.big.BigDecimalMath;
import com.google.common.base.Splitter;
import com.google.common.collect.Lists;
import com.google.common.collect.Streams;
import kamilalisp.api.Evaluation;
import kamilalisp.data.*;
import kamilalisp.libs.math.*;
import kamilalisp.libs.primitives.Add;
import kamilalisp.libs.primitives.Subtract;
import kamilalisp.matrix.Matrix;

import java.io.StringWriter;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.math.MathContext;
import java.math.RoundingMode;
import java.util.LinkedHashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

public class MathLib {
    // apparently, english people call it "norm".
    // well, except the square root.
    private static BigDecimal modulus(BigComplex x) {
        return x.re.pow(2).add(x.im.pow(2)).sqrt(MathContext.DECIMAL128);
    }

    private static BigComplex gaussianRem(BigComplex a, BigComplex b) {
        BigComplex prod = a.multiply(b.conjugate());
        BigDecimal p = prod.re.divide(b.absSquare(MathContext.DECIMAL128), MathContext.DECIMAL128);
        BigDecimal q = prod.im.divide(b.absSquare(MathContext.DECIMAL128), MathContext.DECIMAL128);
        BigComplex gamma = BigComplex.valueOf(p.setScale(0, RoundingMode.HALF_EVEN), q.setScale(0, RoundingMode.HALF_EVEN));
        BigComplex rho = a.subtract(gamma.multiply(b));
        return rho;
    }

    private static BigComplex gcd(BigComplex alpha, BigComplex beta) {
        if(gaussianRem(alpha, beta).equals(BigComplex.ZERO))
            return beta;
        return gcd(beta, gaussianRem(alpha, beta));
    }

    private static void assertGaussian(BigComplex x) {
        assert x.re.stripTrailingZeros().scale() <= 0 && x.im.stripTrailingZeros().scale() <= 0;
    }

    private static boolean isPrime(BigComplex n) {
        if(n.absSquare(MathContext.DECIMAL128).toBigInteger().isProbablePrime(50))
            return true;
        if(n.re.compareTo(BigDecimal.ZERO) != 0 && n.im.compareTo(BigDecimal.ZERO) == 0) {
            if(n.re.abs().remainder(BigDecimal.valueOf(4)).compareTo(BigDecimal.valueOf(3)) == 0 && n.re.toBigInteger().isProbablePrime(50))
                return true;
        }
        if(n.im.compareTo(BigDecimal.ZERO) != 0 && n.re.compareTo(BigDecimal.ZERO) == 0) {
            if(n.im.abs().remainder(BigDecimal.valueOf(4)).compareTo(BigDecimal.valueOf(3)) == 0 && n.im.toBigInteger().isProbablePrime(50))
                return true;
        }
        return false;
    }

    public static void install(Environment env) {
        Logarithm.install(env);
        Constant.install(env);
        Trigonometry.install(env);
        PollardRho.install(env);
        LambertW.install(env);
        MobiusMu.install(env);

        env.push("+", new Atom(new Add()));

        env.push("-", new Atom(new Subtract()));

        env.push("*", new Atom(new Closure() {
            private Atom IDENTITY = new Atom(BigDecimal.ZERO);

            private Atom mul2(Atom a1, Atom a2) {
                if(a1.getType() == Type.NUMBER && a2.getType() == Type.NUMBER) {
                    return new Atom(a1.getNumber().get().multiply(a2.getNumber().get()));
                } else if(a1.getType() == Type.COMPLEX && a2.getType() == Type.COMPLEX) {
                    return new Atom(a1.getComplex().get().multiply(a2.getComplex().get()));
                } else if(a1.getType() == Type.MATRIX && a2.getType() == Type.MATRIX) {
                    // (def a (mat-mix '((1 2) (3 4) (5 6))))
                    // (def b (transpose a))
                    Matrix a = a1.getMatrix().get();
                    Matrix b = a2.getMatrix().get();
                    if(a.getRows() != b.getCols())
                        throw new Error("Invalid matrix multiplication: " + a.getRows() + "x" + a.getCols() + " and " + b.getRows() + "x" + b.getCols() + ".");
                    List<List<Atom>> lRows = a.rows().collect(Collectors.toList());
                    List<List<Atom>> lCols = b.cols().collect(Collectors.toList());
                    return new Atom(Matrix.of((row, col) -> {
                        return Streams.zip(lRows.get(row).stream(), lCols.get(col).stream(), (x, y) -> mul2(x, y)).reduce(Add::add2).get();
                    }, a.getRows(), b.getCols()));
                } else if(a1.getType() == Type.NUMBER && a2.getType() == Type.STRING_CONSTANT) {
                    return new Atom(new StringConstant(a2.getStringConstant().get().get().repeat(a1.getNumber().get().intValue())));
                } else if(a1.getType() == Type.STRING_CONSTANT && a2.getType() == Type.NUMBER) {
                    return new Atom(new StringConstant(a1.getStringConstant().get().get().repeat(a2.getNumber().get().intValue())));
                } else {
                    throw new Error("* unsupported on operands of type " + a1.getType().name() + " and " + a2.getType().name());
                }
            }

            public Object mul1(Atom a) {
                a.guardType("Argument to monadic *", Type.NUMBER, Type.COMPLEX, Type.MATRIX);
                if(a.getType() == Type.NUMBER) {
                    return new BigDecimal(a.getNumber().get().compareTo(BigDecimal.ZERO));
                } else if(a.getType() == Type.COMPLEX) {
                    return new BigDecimal(modulus(a.getComplex().get()).compareTo(BigDecimal.ZERO));
                } else if(a.getType() == Type.MATRIX) {
                    return a.getMatrix().get().transmogrifyRank0(x -> new Atom(new LbcSupplier<>(() -> mul1(x))));
                } else
                    throw new Error("unreachable.");
            }

            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() == 0 || arguments.size() > 2)
                    throw new Error("Invalid * invocation.");
                if(arguments.size() == 1)
                    return new Atom(new LbcSupplier<>(() -> mul1(arguments.get(0))));
                return new Atom(new LbcSupplier<>(() -> mul2(arguments.get(0), arguments.get(1)).get().get()));
            }
        }));

        env.push("/", new Atom(new Closure() {
            private Atom IDENTITY = new Atom(BigDecimal.ZERO);

            private Atom div2(Atom a1, Atom a2) {
                if(a1.getType() == Type.NUMBER && a2.getType() == Type.NUMBER) {
                    return new Atom(a1.getNumber().get().divide(a2.getNumber().get(), MathContext.DECIMAL128));
                } else if(a1.getType() == Type.STRING_CONSTANT && a2.getType() == Type.NUMBER) {
                    String s = a1.getStringConstant().get().get();
                    return new Atom(Lists.newLinkedList(
                            Splitter
                                    .fixedLength(s.length() / a2.getNumber().get().intValue())
                                    .split(s)
                        ).stream()
                            .map(x -> new Atom(new StringConstant(x)))
                            .collect(Collectors.toList()));
                } else if(a1.getType() == Type.COMPLEX && a2.getType() == Type.COMPLEX) {
                    return new Atom(a1.getComplex().get().divide(a2.getComplex().get(), MathContext.DECIMAL128));
                } else if(a1.getType() == Type.LIST && a2.getType() == Type.NUMBER) {
                    List<Atom> s = a1.getList().get();
                    return new Atom(Lists.partition(s, s.size() / a2.getNumber().get().intValue()).stream().map(x -> new Atom(x)).collect(Collectors.toList()));
                } else {
                    throw new Error("/ unsupported on operands of type " + a1.getType().name() + " and " + a2.getType().name());
                }
            }

            public Object div1(Atom a) {
                a.guardType("Argument to monadic /", Type.NUMBER, Type.COMPLEX);
                if(a.getType() == Type.NUMBER) {
                    return BigDecimal.ONE.divide(a.getNumber().get());
                } else if(a.getType() == Type.COMPLEX) {
                    return a.getComplex().get().reciprocal(MathContext.DECIMAL128);
                } else
                    throw new Error("unreachable.");
            }

            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() == 0 || arguments.size() > 2)
                    throw new Error("Invalid / invocation.");
                if(arguments.size() == 1)
                    return new Atom(new LbcSupplier<>(() -> div1(arguments.get(0))));
                return new Atom(new LbcSupplier<>(() -> div2(arguments.get(0), arguments.get(1)).get().get()));
            }
        }));

        env.push("%", new Atom(new Closure() {
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
                            return modulus(arguments.get(0).getComplex().get());
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
        }));

        env.push("gcd", new Atom(new Closure() {
            private Atom IDENTITY = new Atom(BigDecimal.ZERO);

            private Atom gcd2(Atom a1, Atom a2) {
                a1.guardType("First argument to 'gcd'", Type.NUMBER, Type.COMPLEX);
                a2.guardType("Second argument to 'gcd'", Type.NUMBER, Type.COMPLEX);
                if(a1.getType() == Type.NUMBER && a2.getType() == Type.NUMBER) {
                    return new Atom(new BigDecimal(a1.getNumber().get().toBigInteger().gcd(a2.getNumber().get().toBigInteger())));
                } else {
                    BigComplex a, b;
                    if(a1.getType() == Type.NUMBER) { a = BigComplex.valueOf(a1.getNumber().get(), BigDecimal.ZERO); }
                    else { a = a1.getComplex().get(); }
                    if(a2.getType() == Type.NUMBER) { b = BigComplex.valueOf(a2.getNumber().get(), BigDecimal.ZERO); }
                    else { b = a2.getComplex().get(); }
                    assertGaussian(a);
                    assertGaussian(b);
                    // compute gcd(a, b).
                    return new Atom(gcd(a, b));
                }
            }

            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() == 0 || arguments.size() > 2)
                    throw new Error("Invalid 'gcd' invocation.");
                if(arguments.size() == 1)
                    return arguments.get(0);
                return new Atom(new LbcSupplier<>(() -> gcd2(arguments.get(0), arguments.get(1)).get().get()));
            }
        }));

        env.push("lcm", new Atom(new Closure() {
            private Atom IDENTITY = new Atom(BigDecimal.ZERO);

            private Atom gcd2(Atom a1, Atom a2) {
                a1.guardType("First argument to 'lcm'", Type.NUMBER, Type.COMPLEX);
                a2.guardType("Second argument to 'lcm'", Type.NUMBER, Type.COMPLEX);
                if(a1.getType() == Type.NUMBER && a2.getType() == Type.NUMBER) {
                    return new Atom(a1.getNumber().get().multiply(a2.getNumber().get()).divide(new BigDecimal(a1.getNumber().get().toBigInteger().gcd(a2.getNumber().get().toBigInteger()))));
                } else {
                    BigComplex a, b;
                    if(a1.getType() == Type.NUMBER) { a = BigComplex.valueOf(a1.getNumber().get(), BigDecimal.ZERO); }
                    else { a = a1.getComplex().get(); }
                    if(a2.getType() == Type.NUMBER) { b = BigComplex.valueOf(a2.getNumber().get(), BigDecimal.ZERO); }
                    else { b = a2.getComplex().get(); }
                    assertGaussian(a);
                    assertGaussian(b);
                    return new Atom(a.multiply(b).divide(gcd(a, b), MathContext.DECIMAL128));
                }
            }

            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() == 0 || arguments.size() > 2)
                    throw new Error("Invalid 'lcm' invocation.");
                if(arguments.size() == 1)
                    return arguments.get(0);
                return new Atom(new LbcSupplier<>(() -> gcd2(arguments.get(0), arguments.get(1)).get().get()));
            }
        }));

        env.push("~", new Atom(new Closure() {
            public String reverseCase(String text) {
                return text.chars()
                        .map(c -> Character.isUpperCase(c) ?
                                Character.toLowerCase(c) :
                                Character.toUpperCase(c))
                        .collect(
                                StringBuilder::new,
                                StringBuilder::appendCodePoint,
                                StringBuilder::append)
                        .toString();
            }

            public Atom neg1(Atom a) {
                a.guardType("First argument to monadic '~'", Type.NUMBER, Type.STRING_CONSTANT);

                if(a.getType() == Type.NUMBER) {
                    return new Atom(BigDecimal.valueOf(a.getNumber().get().compareTo(BigDecimal.ZERO) == 0 ? 1 : 0));
                } else if(a.getType() == Type.STRING_CONSTANT) {
                    return new Atom(new StringConstant(reverseCase(a.getStringConstant().get().get())));
                }

                // Should never get here.
                return null;
            }

            public Atom neg2(Atom a, Atom b) {
                a.guardType("First argument to dyadic '~'", Type.LIST);
                if(b.getType() == Type.LIST) {
                    List<Atom> clone = new LinkedList<>(a.getList().get());
                    clone.removeIf(x -> a.getList().get().contains(x.get().get()));
                    return new Atom(clone);
                } else {
                    List<Atom> clone = new LinkedList<>(a.getList().get());
                    clone.removeIf(x -> x.get().get().equals(b.get().get()));
                    return new Atom(clone);
                }
            }

            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() == 0)
                    throw new Error("Invalid invocation to '~'.");
                else if(arguments.size() == 1)
                    return new Atom(new LbcSupplier(() -> neg1(arguments.get(0)).get().get()));
                else if(arguments.size() == 2)
                    return new Atom(new LbcSupplier(() -> neg2(arguments.get(0), arguments.get(1)).get().get()));
                throw new Error("Invalid invocation to '~'.");
            }
        }));

        env.push("<", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2)
                    throw new Error("Invalid invocation to '<'.");
                return new Atom(new LbcSupplier<>(() -> {
                    if(arguments.get(0).getType() == Type.NUMBER && arguments.get(1).getType() == Type.NUMBER) {
                        return arguments.get(0).getNumber().get().compareTo(arguments.get(1).getNumber().get()) < 0 ? BigDecimal.ONE : BigDecimal.ZERO;
                    } else if(arguments.get(0).getType() == Type.COMPLEX && arguments.get(1).getType() == Type.COMPLEX) {
                        return modulus(arguments.get(0).getComplex().get()).compareTo(modulus(arguments.get(1).getComplex().get())) < 0 ? BigDecimal.ONE : BigDecimal.ZERO;
                    } else if(arguments.get(0).getType() == Type.STRING_CONSTANT && arguments.get(1).getType() == Type.STRING_CONSTANT) {
                        return arguments.get(0).getStringConstant().get().get().compareTo(arguments.get(1).getStringConstant().get().get()) < 0 ? BigDecimal.ONE : BigDecimal.ZERO;
                    } else if(arguments.get(0).getType() == Type.STRING_CONSTANT && arguments.get(1).getType() == Type.NUMBER) {
                        return arguments.get(0).getStringConstant().get().get().length() < arguments.get(1).getNumber().get().intValue() ? BigDecimal.ONE : BigDecimal.ZERO;
                    } else if(arguments.get(0).getType() == Type.NUMBER && arguments.get(1).getType() == Type.STRING_CONSTANT) {
                        return arguments.get(1).getStringConstant().get().get().length() < arguments.get(0).getNumber().get().intValue() ? BigDecimal.ONE : BigDecimal.ZERO;
                    } else {
                        throw new Error("Invalid invocation to '<'. Expected two numbers or two strings.");
                    }
                }));
            }
        }));

        env.push(">", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2)
                    throw new Error("Invalid invocation to '>'.");
                return new Atom(new LbcSupplier<>(() -> {
                    if(arguments.get(0).getType() == Type.NUMBER && arguments.get(1).getType() == Type.NUMBER) {
                        return arguments.get(0).getNumber().get().compareTo(arguments.get(1).getNumber().get()) > 0 ? BigDecimal.ONE : BigDecimal.ZERO;
                    } else if(arguments.get(0).getType() == Type.COMPLEX && arguments.get(1).getType() == Type.COMPLEX) {
                        return modulus(arguments.get(0).getComplex().get()).compareTo(modulus(arguments.get(1).getComplex().get())) > 0 ? BigDecimal.ONE : BigDecimal.ZERO;
                    } else if(arguments.get(0).getType() == Type.STRING_CONSTANT && arguments.get(1).getType() == Type.STRING_CONSTANT) {
                        return arguments.get(0).getStringConstant().get().get().compareTo(arguments.get(1).getStringConstant().get().get()) > 0 ? BigDecimal.ONE : BigDecimal.ZERO;
                    } else if(arguments.get(0).getType() == Type.STRING_CONSTANT && arguments.get(1).getType() == Type.NUMBER) {
                        return arguments.get(0).getStringConstant().get().get().length() > arguments.get(1).getNumber().get().intValue() ? BigDecimal.ONE : BigDecimal.ZERO;
                    } else if(arguments.get(0).getType() == Type.NUMBER && arguments.get(1).getType() == Type.STRING_CONSTANT) {
                        return arguments.get(1).getStringConstant().get().get().length() > arguments.get(0).getNumber().get().intValue() ? BigDecimal.ONE : BigDecimal.ZERO;
                    } else {
                        throw new Error("Invalid invocation to '>'. Expected two numbers or two strings.");
                    }
                }));
            }
        }));

        env.push("|", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2)
                    throw new Error("Invalid invocation to '|'.");
                return new Atom(new LbcSupplier<>(() -> {
                    if(arguments.get(0).getType() == Type.NUMBER && arguments.get(1).getType() == Type.NUMBER) {
                        return new BigDecimal(
                                arguments
                                        .get(0)
                                        .getNumber()
                                        .get()
                                        .toBigInteger()
                                        .or(arguments.get(1).getNumber().get().toBigInteger()));
                    } else if(arguments.get(0).getType() == Type.STRING_CONSTANT && arguments.get(1).getType() == Type.STRING_CONSTANT) {
                        return new StringConstant(arguments.get(0).getStringConstant().get().get().concat(arguments.get(1).getStringConstant().get().get())
                                        .codePoints()
                                        .distinct()
                                        .collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append)
                                        .toString());
                    } else if(arguments.get(0).getType() == Type.LIST && arguments.get(1).getType() == Type.LIST) {
                        Set<Object> result = new LinkedHashSet<>();
                        result.addAll(arguments.get(0).getList().get().stream().map(x -> x.get().get()).collect(Collectors.toList()));
                        result.addAll(arguments.get(1).getList().get().stream().map(x -> x.get().get()).collect(Collectors.toList()));
                        return result.stream().map(x -> new Atom(new LbcSupplier<>(() -> x))).collect(Collectors.toList());
                    } else
                        throw new Error("Invalid invocation to '|'. Expected two numbers, two strings or two lists.");
                }));
            }
        }));

        env.push("&", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2)
                    throw new Error("Invalid invocation to '&'.");
                return new Atom(new LbcSupplier<>(() -> {
                    if(arguments.get(0).getType() == Type.NUMBER && arguments.get(1).getType() == Type.NUMBER) {
                        return new BigDecimal(
                                arguments
                                        .get(0)
                                        .getNumber()
                                        .get()
                                        .toBigInteger()
                                        .and(arguments.get(1).getNumber().get().toBigInteger()));
                    } else if(arguments.get(0).getType() == Type.STRING_CONSTANT && arguments.get(1).getType() == Type.STRING_CONSTANT) {
                        Set<Integer> result = new LinkedHashSet<>();
                        result.addAll(arguments.get(0).getStringConstant().get().get().codePoints().boxed().collect(Collectors.toList()));
                        result.retainAll(arguments.get(1).getStringConstant().get().get().codePoints().boxed().collect(Collectors.toList()));
                        return new StringConstant(result.stream().collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append).toString());
                    } else if(arguments.get(0).getType() == Type.LIST && arguments.get(1).getType() == Type.LIST) {
                        Set<Atom> result = new LinkedHashSet<>();
                        result.addAll(arguments.get(0).getList().get());
                        result.retainAll(arguments.get(1).getList().get());
                        return result.stream().collect(Collectors.toList());
                    } else
                        throw new Error("Invalid invocation to '&'. Expected two numbers, two strings or two lists.");
                }));
            }
        }));

        env.push(">=", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2)
                    throw new Error("Invalid invocation to '>='.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom a1 = arguments.get(0);
                    Atom a2 = arguments.get(1);
                    return env.evaluate(new Atom(List.of(
                            new Atom("|"),
                            new Atom(List.of(new Atom("="), a1, a2)),
                            new Atom(List.of(new Atom(">"), a1, a2))
                    )));
                }));
            }
        }));

        env.push("<=", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2)
                    throw new Error("Invalid invocation to '<='.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom a1 = arguments.get(0);
                    Atom a2 = arguments.get(1);
                    return env.evaluate(new Atom(List.of(
                            new Atom("|"),
                            new Atom(List.of(new Atom("="), a1, a2)),
                            new Atom(List.of(new Atom("<"), a1, a2))
                    )));
                }));
            }
        }));

        env.push("=", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2)
                    throw new Error("invalid invocation to '='.");
                return new Atom(new LbcSupplier(() -> arguments.get(0).equals(arguments.get(1)) ? BigDecimal.ONE : BigDecimal.ZERO));
            }
        }));

        env.push("/=", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2)
                    throw new Error("invalid invocation to '='.");
                return new Atom(new LbcSupplier(() -> arguments.get(0).equals(arguments.get(1)) ? BigDecimal.ZERO : BigDecimal.ONE));
            }
        }));

        env.push("min", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2)
                    throw new Error("Invalid invocation to 'min'.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom a1 = arguments.get(0);
                    Atom a2 = arguments.get(1);
                    if(a1.getType() == Type.NUMBER && a2.getType() == Type.NUMBER) {
                        return a1.getNumber().get().min(a2.getNumber().get());
                    } else if(a1.getType() == Type.COMPLEX && a2.getType() == Type.COMPLEX) {
                        return modulus(a1.getComplex().get()).compareTo(modulus(a2.getComplex().get())) < 0 ? a1.get().get() : a2.get().get();
                    } else if(a1.getType() == Type.STRING_CONSTANT && a2.getType() == Type.STRING_CONSTANT) {
                        return a1.getStringConstant().get().get().compareTo(a2.getStringConstant().get().get()) < 0 ? a1.get().get() : a2.get().get();
                    } else if(a1.getType() == Type.LIST && a2.getType() == Type.LIST) {
                        return a1.getList().get().size() < a2.getList().get().size() ? a1.get().get() : a2.get().get();
                    }
                    throw new Error("Invalid invocation to 'min': expected two lists, two strings or two numbers.");
                }));
            }
        }));

        env.push("max", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2)
                    throw new Error("Invalid invocation to 'max'.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom a1 = arguments.get(0);
                    Atom a2 = arguments.get(1);
                    if(a1.getType() == Type.NUMBER && a2.getType() == Type.NUMBER) {
                        return a1.getNumber().get().max(a2.getNumber().get());
                    } else if(a1.getType() == Type.COMPLEX && a2.getType() == Type.COMPLEX) {
                        return modulus(a1.getComplex().get()).compareTo(modulus(a2.getComplex().get())) > 0 ? a1.get().get() : a2.get().get();
                    } else if(a1.getType() == Type.STRING_CONSTANT && a2.getType() == Type.STRING_CONSTANT) {
                        return a1.getStringConstant().get().get().compareTo(a2.getStringConstant().get().get()) > 0 ? a1.get().get() : a2.get().get();
                    } else if(a1.getType() == Type.LIST && a2.getType() == Type.LIST) {
                        return a1.getList().get().size() > a2.getList().get().size() ? a1.get().get() : a2.get().get();
                    }
                    throw new Error("Invalid invocation to 'max': expected two lists, two strings or two numbers.");
                }));
            }
        }));

        env.push("approx-eq", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 3)
                    throw new Error("Invalid invocation to 'approx-eq'.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom a = arguments.get(0);
                    Atom b = arguments.get(1);
                    Atom epsilon = arguments.get(2);
                    a.guardType("First argument to 'approx-eq'", Type.NUMBER);
                    b.guardType("Second argument to 'approx-eq'", Type.NUMBER);
                    epsilon.guardType("Third argument to 'approx-eq'", Type.NUMBER);
                    return a.getNumber().get().subtract(b.getNumber().get()).abs().compareTo(epsilon.getNumber().get()) < 0 ? BigDecimal.ONE : BigDecimal.ZERO;
                }));
            }
        }));

        env.push("sqrt", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'sqrt'.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom a = arguments.get(0);
                    a.guardType("First argument to 'sqrt'", Type.NUMBER, Type.COMPLEX);
                    if(a.getType() == Type.NUMBER) {
                        return BigDecimalMath.sqrt(a.getNumber().get(), MathContext.DECIMAL128);
                    } else {
                        return BigComplexMath.sqrt(a.getComplex().get(), MathContext.DECIMAL128);
                    }
                }));
            }
        }));

        env.push("exp", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'exp'.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom a = arguments.get(0);
                    a.guardType("First argument to 'exp'", Type.NUMBER, Type.COMPLEX);
                    if(a.getType() == Type.NUMBER) {
                        return BigDecimalMath.exp(a.getNumber().get(), MathContext.DECIMAL128);
                    } else {
                        return BigComplexMath.exp(a.getComplex().get(), MathContext.DECIMAL128);
                    }
                }));
            }
        }));

        env.push("**", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2)
                    throw new Error("Invalid invocation to '**'.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom a1 = arguments.get(0);
                    Atom a2 = arguments.get(1);
                    a1.guardType("First argument to '**'", Type.NUMBER, Type.COMPLEX);
                    a2.guardType("Second argument to '**'", Type.NUMBER, Type.COMPLEX);
                    if(a1.getType() == Type.NUMBER && a2.getType() == Type.NUMBER) {
                        return BigDecimalMath.pow(a1.getNumber().get(), a2.getNumber().get(), MathContext.DECIMAL128);
                    } else {
                        BigComplex a, b;
                        if(a1.getType() == Type.NUMBER) { a = BigComplex.valueOf(a1.getNumber().get(), BigDecimal.ZERO); }
                        else { a = a1.getComplex().get(); }
                        if(a2.getType() == Type.NUMBER) { b = BigComplex.valueOf(a2.getNumber().get(), BigDecimal.ZERO); }
                        else { b = a2.getComplex().get(); }
                        assertGaussian(a);
                        assertGaussian(b);
                        return BigComplexMath.pow(a, b, MathContext.DECIMAL128);
                    }
                }));
            }
        }));

        env.push("!", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to '!'.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom a = arguments.get(0);
                    a.guardType("First argument to '!'", Type.NUMBER, Type.COMPLEX);
                    if(a.getType() == Type.NUMBER) {
                        return BigDecimalMath.factorial(a.getNumber().get(), MathContext.DECIMAL128);
                    } else {
                        return BigComplexMath.factorial(a.getComplex().get(), MathContext.DECIMAL128);
                    }
                }));
            }
        }));

        env.push("binomial", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2)
                    throw new Error("Invalid invocation to 'binomial'.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom a = arguments.get(0);
                    Atom b = arguments.get(1);
                    a.guardType("First argument to 'binomial'", Type.NUMBER);
                    b.guardType("Second argument to 'binomial'", Type.NUMBER);
                    BigDecimal aBang = BigDecimalMath.factorial(a.getNumber().get(), MathContext.DECIMAL128);
                    BigDecimal bBang = BigDecimalMath.factorial(b.getNumber().get(), MathContext.DECIMAL128);
                    BigDecimal abBang = BigDecimalMath.factorial(a.getNumber().get().subtract(b.getNumber().get()), MathContext.DECIMAL128);
                    return aBang.divide(bBang.multiply(abBang), MathContext.DECIMAL128);
                }));
            }
        }));

        env.push("root", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2)
                    throw new Error("Invalid invocation to 'root'.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom a = arguments.get(0);
                    Atom b = arguments.get(1);
                    a.guardType("First argument to 'root'", Type.NUMBER, Type.COMPLEX);
                    b.guardType("Second argument to 'root'", Type.NUMBER, Type.COMPLEX);
                    if(a.getType() == Type.NUMBER && b.getType() == Type.NUMBER) {
                        return BigDecimalMath.root(b.getNumber().get(), a.getNumber().get(), MathContext.DECIMAL128);
                    } else {
                        BigComplex x = a.getComplex().get();
                        BigComplex y = b.getComplex().get();
                        return BigComplexMath.root(x, y, MathContext.DECIMAL128);
                    }
                }));
            }
        }));

        env.push("floor", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1 && arguments.size() != 2)
                    throw new Error("Invalid invocation to 'floor'.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom a = arguments.get(0);
                    a.guardType("First argument to 'floor'", Type.NUMBER, Type.COMPLEX);
                    if(a.getType() == Type.NUMBER) {
                        if(arguments.size() == 2) {
                            arguments.get(1).guardType("Second argument to 'floor'", Type.NUMBER);
                            return a.getNumber().get().setScale(arguments.get(1).getNumber().get().intValue(), RoundingMode.FLOOR);
                        } else
                            return a.getNumber().get().setScale(0, RoundingMode.FLOOR);
                    } else {
                        int scale = 0;
                        BigComplex x = a.getComplex().get();

                        if(arguments.size() == 2) {
                            arguments.get(1).guardType("Second argument to 'floor'", Type.NUMBER);
                            scale = arguments.get(1).getNumber().get().intValue();
                        }

                        return BigComplex.valueOf(x.re.setScale(scale, RoundingMode.FLOOR), x.im.setScale(scale, RoundingMode.FLOOR));
                    }
                }));
            }
        }));

        env.push("ceil", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1 && arguments.size() != 2)
                    throw new Error("Invalid invocation to 'ceil'.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom a = arguments.get(0);
                    a.guardType("First argument to 'ceil'", Type.NUMBER);
                    if(a.getType() == Type.NUMBER) {
                        if(arguments.size() == 2) {
                            arguments.get(1).guardType("Second argument to 'ceil'", Type.NUMBER);
                            return a.getNumber().get().setScale(arguments.get(1).getNumber().get().intValue(), RoundingMode.CEILING);
                        } else
                            return a.getNumber().get().setScale(0, RoundingMode.CEILING);
                    } else {
                        int scale = 0;
                        BigComplex x = a.getComplex().get();

                        if(arguments.size() == 2) {
                            arguments.get(1).guardType("Second argument to 'ceil'", Type.NUMBER);
                            scale = arguments.get(1).getNumber().get().intValue();
                        }

                        return BigComplex.valueOf(x.re.setScale(scale, RoundingMode.CEILING), x.im.setScale(scale, RoundingMode.CEILING));
                    }
                }));
            }
        }));

        env.push("is-prime?", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'is-prime'.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom a = arguments.get(0);
                    a.guardType("First argument to 'is-prime'", Type.NUMBER, Type.COMPLEX);
                    if(a.getType() == Type.NUMBER) {
                        return a.getNumber().get().toBigInteger().isProbablePrime(50) ? BigDecimal.ONE : BigDecimal.ZERO;
                    } else {
                        assertGaussian(a.getComplex().get());
                        return isPrime(a.getComplex().get()) ? BigDecimal.ONE : BigDecimal.ZERO;
                    }
                }));
            }
        }));

        env.push("hamming-weight", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'hamming-weight'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("First argument to 'hamming-weight'", Type.NUMBER);
                    BigInteger value = arguments.get(0).getNumber().get().toBigInteger();
                    BigInteger weight = new BigInteger("0");
                    for (int i = 0; i <= value.bitLength(); i++)
                        if (value.testBit(i))
                            weight = weight.add(BigInteger.ONE);
                    return new BigDecimal(weight);
                }));
            }
        }));

        env.push("decode", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2)
                    throw new Error("Invalid invocation to 'decode'.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom a = arguments.get(0);
                    Atom b = arguments.get(1);
                    b.guardType("Second argument to 'decode'", Type.LIST);
                    if(a.getType() == Type.NUMBER) {
                        BigDecimal n = new BigDecimal(1);
                        BigDecimal base = a.getNumber().get();
                        BigDecimal s = new BigDecimal(0);
                        List<Atom> l = Lists.reverse(b.getList().get());
                        for(int i = 0; i < l.size(); i++) {
                            l.get(i).guardType("Element in list argument to 'decode'", Type.NUMBER);
                            s = s.add(l.get(i).getNumber().get().multiply(n));
                            n = n.multiply(base);
                        }
                        return s;
                    } else if(a.getType() == Type.LIST) {
                        List<BigDecimal> ns = a.getList().get().stream().map(x -> {
                            x.guardType("Element in list argument to 'decode'", Type.NUMBER);
                            return x.getNumber().get();
                        }).collect(Collectors.toList());
                        BigDecimal s = new BigDecimal(0);
                        BigDecimal n = new BigDecimal(1);
                        List<Atom> l = b.getList().get();
                        for(int i = l.size() - 1; i >= 0; i--) {
                            l.get(i).guardType("Element in list argument to 'decode'", Type.NUMBER);
                            s = s.add(l.get(i).getNumber().get().multiply(n));
                            n = n.multiply(ns.get(i));
                        }
                        return s;
                    }
                    throw new Error("First argument to 'decode' must be a number or a list.");
                }));
            }
        }));

        // Math utilities implemented in Lisp for no real reason.
        // Except that they're easier to maintain.
        Evaluation.evalString(env, "(def sum (bind foldl' + 0))");
        Evaluation.evalString(env, "(def prod (bind foldl' * 1))");
        Evaluation.evalString(env, "(defun totient (x) (let ((y (p-factors x))) (prod (zip-with - y (unique-mask y)))))");
    }
}
