package kamilalisp.libs;

import ch.obermuhlner.math.big.BigComplex;
import ch.obermuhlner.math.big.BigComplexMath;
import ch.obermuhlner.math.big.BigDecimalMath;
import com.google.common.collect.Collections2;
import com.google.common.collect.Lists;
import com.google.common.collect.Sets;
import com.google.common.collect.Streams;
import kamilalisp.api.Evaluation;
import kamilalisp.data.*;
import kamilalisp.libs.math.*;
import kamilalisp.libs.math.bigop.Bernoulli;
import kamilalisp.libs.math.bigop.Rational;
import kamilalisp.libs.primitives.DyadicMultivariateFunction;
import kamilalisp.libs.primitives.list.Sort;
import kamilalisp.libs.primitives.math.*;
import kamilalisp.libs.primitives.statistics.Average;
import kamilalisp.libs.primitives.statistics.Median;
import kamilalisp.libs.primitives.statistics.Variance;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.math.MathContext;
import java.math.RoundingMode;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import java.util.stream.Stream;

public class MathLib {
    private static BigComplex gaussianRem(Environment env, BigComplex a, BigComplex b) {
        BigComplex prod = a.multiply(b.conjugate());
        BigDecimal p = prod.re.divide(b.absSquare(Constant.getFr(env)), Constant.getFr(env));
        BigDecimal q = prod.im.divide(b.absSquare(Constant.getFr(env)), Constant.getFr(env));
        BigComplex gamma = BigComplex.valueOf(p.setScale(0, RoundingMode.HALF_EVEN), q.setScale(0, RoundingMode.HALF_EVEN));
        BigComplex rho = a.subtract(gamma.multiply(b));
        return rho;
    }

    public static BigComplex asComplex(Atom a) {
        a.guardType("Argument to 'asComplex'", Type.NUMBER, Type.COMPLEX);
        if(a.getType() == Type.NUMBER)
            return BigComplex.valueOf(a.getNumber().get(), BigDecimal.ZERO);
        else
            return a.getComplex().get();
    }

    private static int decimalPlaces(BigDecimal number) {
        int scale = number.stripTrailingZeros().scale();
        return scale > 0 ? scale : 0;
    }

    private static Atom gcdAtom(Environment env, Atom a1, Atom a2) {
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
            BigComplex a, b;
            if(a1.getType() == Type.NUMBER) { a = BigComplex.valueOf(a1.getNumber().get(), BigDecimal.ZERO); }
            else { a = a1.getComplex().get(); }
            if(a2.getType() == Type.NUMBER) { b = BigComplex.valueOf(a2.getNumber().get(), BigDecimal.ZERO); }
            else { b = a2.getComplex().get(); }
            assertGaussian(a);
            assertGaussian(b);
            // compute gcd(a, b).
            return new Atom(gcd(env, a, b));
        }
    }

    private static BigComplex gcd(Environment env, BigComplex alpha, BigComplex beta) {
        if (gaussianRem(env, alpha, beta).equals(BigComplex.ZERO))
            return beta;
        return gcd(env, beta, gaussianRem(env, alpha, beta));
    }

    private static void assertGaussian(BigComplex x) {
        assert x.re.stripTrailingZeros().scale() <= 0 && x.im.stripTrailingZeros().scale() <= 0;
    }

    private static boolean isPrime(Environment env, BigComplex n) {
        if(n.absSquare(Constant.getFr(env)).toBigInteger().isProbablePrime(50))
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
        env.push("fr", new Atom(new BigDecimal(100)));

        Logarithm.install(env);
        Constant.install(env);
        Trigonometry.install(env);
        PollardRho.install(env);
        LambertW.install(env);
        MobiusMu.install(env);

        env.push("+", DyadicMultivariateFunction.of(new Add()));

        env.push("-", DyadicMultivariateFunction.of(new Subtract()));

        env.push("*", DyadicMultivariateFunction.of(new Product()));

        env.push("/", DyadicMultivariateFunction.of(new Quotient()));

        env.push("%", new Atom(new Remainder()));

        env.push("gcd", DyadicMultivariateFunction.of(new GCD()));

        env.push("lcm", DyadicMultivariateFunction.of(new LCM()));

        env.push("~", DyadicMultivariateFunction.of(new Tilde()));

        env.push("<", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2)
                    throw new Error("Invalid invocation to '<'.");
                return new Atom(new LbcSupplier<>(() -> {
                    if(arguments.get(0).getType() == Type.NUMBER && arguments.get(1).getType() == Type.NUMBER) {
                        return arguments.get(0).getNumber().get().compareTo(arguments.get(1).getNumber().get()) < 0 ? BigDecimal.ONE : BigDecimal.ZERO;
                    } else if(arguments.get(0).getType() == Type.COMPLEX && arguments.get(1).getType() == Type.COMPLEX) {
                        return Remainder.norm(env.env, arguments.get(0).getComplex().get()).compareTo(Remainder.norm(env.env, arguments.get(1).getComplex().get())) < 0 ? BigDecimal.ONE : BigDecimal.ZERO;
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
                        return Remainder.norm(env.env, arguments.get(0).getComplex().get()).compareTo(Remainder.norm(env.env, arguments.get(1).getComplex().get())) > 0 ? BigDecimal.ONE : BigDecimal.ZERO;
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

        env.push("bernoulli", new Atom(new Closure() {
            private Bernoulli b = new Bernoulli();

            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'bernoulli'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("Argument to 'bernoulli'", Type.NUMBER);
                    BigDecimal p = arguments.get(0).getNumber().get();
                    Rational r = b.at(p.intValue());
                    return List.of(new Atom(new BigDecimal(r.numer())), new Atom(new BigDecimal(r.denom())));
                }));
            }
        }));

        env.push("digamma", new Atom(new Closure() {
            private Bernoulli b = new Bernoulli();

            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'digamma'.");
                return new Atom(new LbcSupplier<>(() -> {
                    boolean numeric = false;
                    arguments.get(0).guardType("Argument to 'digamma'", Type.NUMBER, Type.COMPLEX);
                    if(arguments.get(0).getType() == Type.NUMBER)
                        numeric = true;
                    BigComplex z = asComplex(arguments.get(0));

                    // phi(z) = ln(z) - 1/2z + sum n=1 to inf zeta(1-2n)/z^2n
                    // = ln(z) - 1/2z - sum n=1 to inf B_2n/2nz^2n
                    BigComplex ln = BigComplexMath.log(z, Constant.getFr(env.env));
                    BigComplex r2z = BigComplex.ONE.divide(z.multiply(BigComplex.valueOf(BigDecimal.valueOf(2))), Constant.getFr(env.env));
                    // Compute the sum now.
                    BigComplex sum = BigComplex.ZERO;
                    if(z.abs(Constant.getFr(env.env)).compareTo(new BigDecimal(100)) >= 0) {
                        for (int n = 1; n < Constant.getFr(env.env).getPrecision() / 10; n++) {
                            BigComplex num = BigComplex.valueOf(b.at(2 * n).BigDecimalValue(Constant.getFr(env.env)));
                            BigComplex den = BigComplexMath.pow(z, 2 * n, Constant.getFr(env.env)).multiply(BigComplex.valueOf(BigDecimal.valueOf(2 * n)));
                            sum = sum.add(num.divide(den, Constant.getFr(env.env)));
                        }
                    }
                    BigComplex result = ln.subtract(r2z).subtract(sum);
                    return numeric ? result.re : result;
                }));
            }
        }));

        env.push("&", DyadicMultivariateFunction.of(new And()));

        env.push("xor", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2)
                    throw new Error("Invalid invocation to 'xor'.");
                return new Atom(new LbcSupplier<>(() -> {
                    if(arguments.get(0).getType() == Type.NUMBER && arguments.get(1).getType() == Type.NUMBER) {
                        return new BigDecimal(
                                arguments
                                        .get(0)
                                        .getNumber()
                                        .get()
                                        .toBigInteger()
                                        .xor(arguments.get(1).getNumber().get().toBigInteger()));
                    } else if(arguments.get(0).getType() == Type.STRING_CONSTANT && arguments.get(1).getType() == Type.STRING_CONSTANT) {
                        return new StringConstant(arguments.get(0).getStringConstant().get().get().concat(arguments.get(1).getStringConstant().get().get())
                                .codePoints()
                                .distinct()
                                .filter(x -> arguments.get(0).getStringConstant().get().get().codePoints().anyMatch(y -> y == x)
                                          || arguments.get(1).getStringConstant().get().get().codePoints().anyMatch(y -> y == x))
                                .collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append)
                                .toString());
                    } else if(arguments.get(0).getType() == Type.LIST && arguments.get(1).getType() == Type.LIST) {
                        Set<Object> result = new LinkedHashSet<>();
                        result.addAll(arguments.get(0).getList().get().stream().map(x -> x.get().get()).collect(Collectors.toList()));
                        result.addAll(arguments.get(1).getList().get().stream().map(x -> x.get().get()).collect(Collectors.toList()));
                        Set<Object> intersection = new LinkedHashSet<>();
                        intersection.addAll(arguments.get(0).getList().get().stream().map(x -> x.get().get()).collect(Collectors.toList()));
                        intersection.retainAll(arguments.get(1).getList().get().stream().map(x -> x.get().get()).collect(Collectors.toList()));
                        result.removeAll(intersection);
                        return result.stream().map(x -> new Atom(new LbcSupplier<>(() -> x))).collect(Collectors.toList());
                    } else
                        throw new Error("Invalid invocation to 'xor'. Expected two numbers, two strings or two lists.");
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
                    ))).get().get();
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
                    ))).get().get();
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

        env.push("brown", new Atom(new Closure() {
            public BigDecimal brown(BigInteger n, Environment env) {
                return BigDecimalMath.sqrt(new BigDecimal(brownSub(n)), Constant.getFr(env));
            }

            private BigInteger brownSub(BigInteger n) {
                if (n.compareTo(BigInteger.ZERO) <= 0) {
                    return BigInteger.ZERO;
                } else {
                    return BigInteger.TEN.multiply(brownSub(n.subtract(BigInteger.ONE))).add(n);
                }
            }

            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'brown'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("Argument to 'brown'", Type.NUMBER);
                    return brown(arguments.get(0).getNumber().get().toBigInteger(), env.env);
                }));
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

        env.push("odd-f", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("invalid invocation to 'odd-f'.");
                return new Atom(new LbcSupplier(() -> {
                    arguments.get(0).guardType("Argument to 'odd-f'", Type.NUMBER, Type.COMPLEX);
                    Atom a = arguments.get(0);
                    if(a.getType() == Type.NUMBER) {
                        BigDecimal n = a.getNumber().get();
                        return n.multiply(BigDecimal.valueOf(2)).add(BigDecimal.ONE);
                    } else {
                        BigComplex n = a.getComplex().get();
                        return n.multiply(BigComplex.valueOf(new BigDecimal(2), new BigDecimal(2))).add(BigComplex.valueOf(BigDecimal.ONE, BigDecimal.ONE));
                    }
                }));
            }
        }));

        env.push("even-f", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("invalid invocation to 'even-f'.");
                return new Atom(new LbcSupplier(() -> {
                    arguments.get(0).guardType("Argument to 'even-f'", Type.NUMBER, Type.COMPLEX);
                    Atom a = arguments.get(0);
                    if(a.getType() == Type.NUMBER) {
                        BigDecimal n = a.getNumber().get();
                        return n.multiply(BigDecimal.valueOf(2));
                    } else {
                        BigComplex n = a.getComplex().get();
                        return n.multiply(BigComplex.valueOf(new BigDecimal(2), new BigDecimal(2)));
                    }
                }));
            }
        }));

        env.push("min", DyadicMultivariateFunction.of(new Closure() {
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
                        return Remainder.norm(env.env, a1.getComplex().get()).compareTo(Remainder.norm(env.env, a2.getComplex().get())) < 0 ? a1.get().get() : a2.get().get();
                    } else if(a1.getType() == Type.STRING_CONSTANT && a2.getType() == Type.STRING_CONSTANT) {
                        return a1.getStringConstant().get().get().compareTo(a2.getStringConstant().get().get()) < 0 ? a1.get().get() : a2.get().get();
                    } else if(a1.getType() == Type.LIST && a2.getType() == Type.LIST) {
                        return a1.getList().get().size() < a2.getList().get().size() ? a1.get().get() : a2.get().get();
                    }
                    throw new Error("Invalid invocation to 'min': expected two lists, two strings or two numbers.");
                }));
            }
        }));

        env.push("max", DyadicMultivariateFunction.of(new Closure() {
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
                        return Remainder.norm(env.env, a1.getComplex().get()).compareTo(Remainder.norm(env.env, a2.getComplex().get())) > 0 ? a1.get().get() : a2.get().get();
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

        env.push("sqrt", new Atom(new Sqrt()));

        env.push("exp", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'exp'.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom a = arguments.get(0);
                    a.guardType("First argument to 'exp'", Type.NUMBER, Type.COMPLEX);
                    if(a.getType() == Type.NUMBER) {
                        return BigDecimalMath.exp(a.getNumber().get(), Constant.getFr(env.env));
                    } else {
                        return BigComplexMath.exp(a.getComplex().get(), Constant.getFr(env.env));
                    }
                }));
            }
        }));

        env.push("**", DyadicMultivariateFunction.of(new Power()));

        env.push("!", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to '!'.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom a = arguments.get(0);
                    a.guardType("First argument to '!'", Type.NUMBER, Type.COMPLEX);
                    if(a.getType() == Type.NUMBER) {
                        if(decimalPlaces(a.getNumber().get()) > 0)
                            return BigDecimalMath.factorial(a.getNumber().get(), Constant.getFr(env.env));
                        else
                            return BigDecimalMath.factorial(a.getNumber().get().intValue());
                    } else {
                        return BigComplexMath.factorial(a.getComplex().get(), Constant.getFr(env.env));
                    }
                }));
            }
        }));

        env.push("pvec", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'pvec'.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom a = arguments.get(0);
                    a.guardType("First argument to 'pvec'", Type.NUMBER);
                    int n = a.getNumber().get().intValue();
                    return new ArrayList<>(Collections2.permutations(
                                IntStream.range(0, n)
                                        .mapToObj(x -> new Atom(new BigDecimal(x)))
                                        .collect(Collectors.toList())))
                            .stream().map(Atom::new).collect(Collectors.toList());
                }));
            }
        }));

        env.push("cvec", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2)
                    throw new Error("Invalid invocation to 'cvec'.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom a = arguments.get(0);
                    Atom b = arguments.get(1);
                    a.guardType("First argument to 'cvec'", Type.NUMBER);
                    b.guardType("Second argument to 'cvec'", Type.NUMBER);
                    int pick = a.getNumber().get().intValue();
                    int all = b.getNumber().get().intValue();
                    Set<Set<Atom>> combinations = Sets.combinations(IntStream.range(0, all)
                            .mapToObj(x -> new Atom(new BigDecimal(x)))
                            .collect(Collectors.toSet()), pick);
                    return combinations.stream().map(x -> new Atom(Lists.newArrayList(x))).collect(Collectors.toList());
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
                    BigDecimal aBang = BigDecimalMath.factorial(a.getNumber().get(), Constant.getFr(env.env));
                    BigDecimal bBang = BigDecimalMath.factorial(b.getNumber().get(), Constant.getFr(env.env));
                    BigDecimal abBang = BigDecimalMath.factorial(a.getNumber().get().subtract(b.getNumber().get()), Constant.getFr(env.env));
                    return aBang.divide(bBang.multiply(abBang), Constant.getFr(env.env));
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
                        return BigDecimalMath.root(b.getNumber().get(), a.getNumber().get(), Constant.getFr(env.env));
                    } else {
                        BigComplex x = a.getComplex().get();
                        BigComplex y = b.getComplex().get();
                        return BigComplexMath.root(x, y, Constant.getFr(env.env));
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
                        return isPrime(env.env, a.getComplex().get()) ? BigDecimal.ONE : BigDecimal.ZERO;
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

        env.push("poly", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2)
                    throw new Error("Invalid invocation to 'poly'.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom a = arguments.get(0);
                    Atom b = arguments.get(1);
                    b.guardType("Second argument to 'poly'", Type.LIST);
                    if(a.getType() == Type.NUMBER) {
                        BigDecimal n = new BigDecimal(1);
                        BigDecimal base = a.getNumber().get();
                        BigDecimal s = new BigDecimal(0);
                        List<Atom> l = Lists.reverse(b.getList().get());
                        for(int i = 0; i < l.size(); i++) {
                            l.get(i).guardType("Element in list argument to 'poly'", Type.NUMBER);
                            s = s.add(l.get(i).getNumber().get().multiply(n));
                            n = n.multiply(base);
                        }
                        return s;
                    } else if(a.getType() == Type.LIST) {
                        List<BigDecimal> ns = a.getList().get().stream().map(x -> {
                            x.guardType("Element in list argument to 'poly'", Type.NUMBER);
                            return x.getNumber().get();
                        }).collect(Collectors.toList());
                        BigDecimal s = new BigDecimal(0);
                        BigDecimal n = new BigDecimal(1);
                        List<Atom> l = b.getList().get();
                        for(int i = l.size() - 1; i >= 0; i--) {
                            l.get(i).guardType("Element in list argument to 'poly'", Type.NUMBER);
                            s = s.add(l.get(i).getNumber().get().multiply(n));
                            n = n.multiply(ns.get(i));
                        }
                        return s;
                    }
                    throw new Error("First argument to 'poly' must be a number or a list.");
                }));
            }
        }));

        env.push("encode", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2)
                    throw new Error("Invalid invocation to 'encode'.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom a = arguments.get(0);
                    Atom b = arguments.get(1);
                    a.guardType("First argument to 'encode'", Type.NUMBER);
                    b.guardType("Second argument to 'encode'", Type.NUMBER);
                    BigInteger base = a.getNumber().get().toBigInteger();
                    BigInteger s = b.getNumber().get().toBigInteger();
                    List<Atom> l = Lists.reverse(new ArrayList<>());
                    while(s.compareTo(BigInteger.ZERO) != 0) {
                        l.add(new Atom(new BigDecimal(s.remainder(base))));
                        s = s.divide(base);
                    }
                    return Lists.reverse(l);
                }));
            }
        }));

        env.push("p-until", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'p-until'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("First argument to 'p-until'", Type.NUMBER);
                    BigInteger n = arguments.get(0).getNumber().get().toBigInteger();
                    List<Atom> primes = new LinkedList<>();
                    for(BigInteger i = new BigInteger("2"); i.compareTo(n) < 0; i = i.add(BigInteger.ONE)) {
                        if(i.isProbablePrime(50))
                            primes.add(new Atom(new BigDecimal(i)));
                    }
                    return primes;
                }));
            }
        }));

        env.push("p-no", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'p-no'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("First argument to 'p-no'", Type.NUMBER);
                    int n = arguments.get(0).getNumber().get().intValue();
                    List<Atom> primes = new LinkedList<>();
                    for(BigInteger i = new BigInteger("2"); primes.size() != n; i = i.add(BigInteger.ONE)) {
                        if(i.isProbablePrime(50))
                            primes.add(new Atom(new BigDecimal(i)));
                    }
                    return primes;
                }));
            }
        }));

        env.push("match", new Atom(new Macro() {
            private boolean visit(Atom pattern, Atom source, List<String> boundNames, HashMap<String, Atom> valueMap) {
                if(pattern.getType() == Type.LIST) {
                    if(source.getType() != Type.LIST)
                        return false;
                    List<Atom> p = pattern.getList().get();
                    List<Atom> s = source.getList().get();

                    if(p.size() < s.size() && p.size() > 0) {
                        // Check for kleene star presence.
                        Atom pLast = p.get(p.size() - 1);
                        if(pLast.getType() != Type.STRING || !pLast.getString().get().endsWith("..."))
                            return false;
                        String name = pLast.getString().get().substring(0, pLast.getString().get().length() - 3);
                        if(!boundNames.contains(name) && !valueMap.containsKey(name)) {
                            // eek, it's a verbatim value.
                            // don't match because the size is wrong.
                            return false;
                        }
                        // match as much as we can.
                        // example:
                        //    /------\ /----\
                        // s: ((1 0) 1 1 0 0)
                        // p: ((1 0) 1 a...)
                        List<Atom> part1P = p.subList(0, p.size() - 1);
                        List<Atom> part1S = s.subList(0, p.size() - 1);
                        // now take the rest...
                        List<Atom> part2S = s.subList(p.size() - 1, s.size());
                        // check if 1P and 1S match.
                        if(visit(new Atom(part1P), new Atom(part1S), boundNames, valueMap)) {
                            // put part2S bound as a..., or verify if matched correctly.
                            if(valueMap.containsKey(name))
                                return valueMap.get(name).getList().get().equals(part2S);
                            boundNames.remove(name);
                            valueMap.put(name, new Atom(part2S));
                            return true;
                        }
                    }

                    if(p.size() != s.size())
                        return false;
                    if(p.size() == 0)
                        return true;
                    Atom pLast = p.get(p.size() - 1);
                    if(pLast.getType() != Type.STRING || !pLast.getString().get().endsWith("..."))
                        return Streams.zip(p.stream(), s.stream(), (x, y) -> visit(x, y, boundNames, valueMap)).noneMatch(x -> x.booleanValue() == false);
                    else {
                        // kleene star in lists of equal size.
                        // match as much as we can, assign the leftover to x...
                        // example:
                        //    /------\ /---\
                        // s: ((1 0) 1 1)
                        // p: ((1 0) 1 a...)

                        // First pair: bound variable and corresponding element
                        Atom x1 = new Atom(pLast.getString().get().substring(0, pLast.getString().get().length() - 3));
                        Atom x2 = s.get(s.size() - 1);
                        // Second pair: corresponding lists.
                        Atom y1 = new Atom(p.subList(0, p.size() - 1));
                        Atom y2 = new Atom(s.subList(0, s.size() - 1));
                        // First match y1 and y2...
                        if(!visit(y1, y2, boundNames, valueMap))
                            return false;
                        // Now match x1 and x2...
                        return visit(x1, x2, boundNames, valueMap);
                    }
                } else if(pattern.getType() == Type.STRING) {
                    String s = pattern.getString().get();
                    if(valueMap.containsKey(s) && !valueMap.get(s).equals(source))
                        return false;
                    if(!boundNames.contains(s))
                        return pattern.equals(source);
                    valueMap.put(s, source);
                    boundNames.remove(s);
                    return true;
                } else {
                    return pattern.equals(source);
                }
            }

            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() < 2)
                    throw new Error("'match' expects at least one case handler.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom source = env.evaluate(arguments.get(0));
                    List<Atom> clauses = arguments.subList(1, arguments.size());

                    for(Atom clause : clauses) {
                        clause.guardType("'match' case", Type.LIST);
                        List<Atom> data = clause.getList().get();
                        if(data.size() == 1)
                            return env.evaluate(data.get(0)).get().get();
                        else if(data.size() == 3) {
                            Atom binds = data.get(0);
                            Atom pattern = data.get(1);
                            Atom handler = data.get(2);
                            List<String> boundNames;
                            HashMap<String, Atom> bindings = new HashMap<>();
                            binds.guardType("Bind section of the 'match' case", Type.STRING, Type.LIST);
                            if (binds.getType() == Type.LIST)
                                boundNames = binds.getList().get().stream().map(x -> {
                                    x.guardType("Bound variable in 'match' case", Type.STRING);
                                    return x.getString().get();
                                }).collect(Collectors.toList());
                            else
                                boundNames = new LinkedList<>(List.of(binds.getString().get()));
                            // Now, match `pattern` against `source`.
                            // Ignore all entries present in `boundNames`.
                            if (visit(pattern, source, boundNames, bindings) && boundNames.isEmpty()) {
                                Environment de = env.env.descendant("'match' handler section");
                                bindings.forEach(de::push);
                                return new Executor(de).evaluate(handler).get().get();
                            }
                        } else if(data.size() == 2) {
                            Atom pattern = data.get(0);
                            Atom handler = data.get(1);
                            if(pattern.equals(source))
                                return new Executor(env.env.descendant("'match' handler section")).evaluate(handler).get().get();
                        } else
                            throw new Error("'match' case clause must have 1, 2 or 3 elements.");
                    }

                    throw new Error("Unexhaustive 'match'.");
                }));
            }
        }));

        env.push("median", new Atom(new Median()));
        env.push("avg", new Atom(new Average()));

        env.push("stddev", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("'stddev' expects exactly one argument.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom source = arguments.get(0);
                    source.guardType("'stddev' argument", Type.LIST);
                    return Sqrt.sqrt(Variance.variance(source, env), env).get().get();
                }));
            }
        }));

        env.push("variance", new Atom(new Variance()));

        env.push("maxk", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2)
                    throw new Error("'maxk' expects exactly two arguments.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom source = arguments.get(0);
                    Atom k = arguments.get(1);
                    source.guardType("'maxk' argument", Type.LIST);
                    k.guardType("'maxk' argument", Type.NUMBER);
                    List<Atom> l = source.getList().get();
                    int mv = arguments.get(1).getNumber().get().intValue();
                    return Lists.reverse(Sort.sort(l)).subList(0, mv);
                }));
            }
        }));

        env.push("mink", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2)
                    throw new Error("'mink' expects exactly two arguments.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom source = arguments.get(0);
                    Atom k = arguments.get(1);
                    source.guardType("'mink' argument", Type.LIST);
                    k.guardType("'mink' argument", Type.NUMBER);
                    List<Atom> l = source.getList().get();
                    int mv = arguments.get(1).getNumber().get().intValue();
                    return Sort.sort(l).subList(0, mv);
                }));
            }
        }));

        // Exponent of next power of 2 after...
        env.push("enp2", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("'enp2' expects exactly one argument.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom source = arguments.get(0);
                    source.guardType("'enp2' argument", Type.NUMBER);
                    if(decimalPlaces(source.getNumber().get()) != 0)
                        throw new Error("'enp2' argument must be an integer.");
                    return new BigDecimal(source.getNumber().get().toBigInteger().bitLength());
                }));
            }
        }));

        // re/im of a complex number.
        env.push("re", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("'re' expects exactly one argument.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom source = arguments.get(0);
                    source.guardType("'re' argument", Type.COMPLEX, Type.NUMBER);
                    if(source.getType() == Type.COMPLEX)
                        return source.getComplex().get().re;
                    else
                        return source.getNumber().get();
                }));
            }
        }));

        env.push("im", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("'im' expects exactly one argument.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom source = arguments.get(0);
                    source.guardType("'im' argument", Type.COMPLEX, Type.NUMBER);
                    if(source.getType() == Type.COMPLEX)
                        return source.getComplex().get().im;
                    else
                        return BigDecimal.ZERO;
                }));
            }
        }));

        env.push("phasor", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("'phasor' expects exactly one argument.");
                return new Atom(new LbcSupplier<>(() -> {
                    Atom source = arguments.get(0);
                    source.guardType("'phasor' argument", Type.COMPLEX, Type.NUMBER);
                    BigComplex z;
                    if(source.getType() == Type.COMPLEX)
                        z = source.getComplex().get();
                    else
                        return BigDecimal.ZERO;
                    return z.angle(Constant.getFr(env.env));
                }));
            }
        }));

        // Create a polynomial from roots.
        env.push("mkpoly", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("'mkpoly' expects exactly one argument.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("'mkpoly' argument", Type.LIST);
                    List<Atom> roots = arguments.get(0).getList().get();
                    LinkedList<Atom> p = new LinkedList<>();
                    p.add(new Atom(BigDecimal.ONE));
                    for(Atom r : roots) {
                        // multiply polynomial p by (x - r).
                        // p(x) * (x - r) = x * p(x) - r * p(x)
                        // Compute p_1(x) = r * p(x)
                        List<Atom> p1 = Streams.concat(p.stream().map(x -> Product.mul2(r, x)), Stream.of(new Atom(BigDecimal.ZERO))).collect(Collectors.toList());
                        // Multiply polynomial times x - shift it.
                        p.addFirst(new Atom(BigDecimal.ZERO));
                        // imperatively: p(x) = p(x) - p1(x). Subtract corresponding coefficients.
                        for(int i = 0; i < p.size(); i++)
                            p.set(i, Subtract.sub2(p.get(i), p1.get(i)));
                    }
                    return Lists.reverse(p);
                }));
            }
        }));

        env.push("p-dirchlet", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("'p-dirchlet' expects exactly one argument.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("'p-dirchlet' argument", Type.NUMBER);
                    BigInteger n = arguments.get(0).getNumber().get().toBigInteger();
                    if(n.compareTo(BigInteger.valueOf(6)) < 0)
                        throw new Error("'p-dirchlet' argument must be at least 6.");
                    BigInteger nn = n.multiply(BigInteger.valueOf(2));
                    // Find a 4k+1 & 4m+3 prime.
                    // First, find the lowest multiple of 4 greater than n.
                    BigInteger m = n.divide(BigInteger.valueOf(4)).add(BigInteger.valueOf(1)).multiply(BigInteger.valueOf(4));
                    // Now, find the greatest multiple of 4 less than 2n.
                    BigInteger k = nn.divide(BigInteger.valueOf(4)).subtract(BigInteger.valueOf(1)).multiply(BigInteger.valueOf(4));
                    // Now, find the primes between `m` and `k`.
                    List<Atom> primes = new ArrayList<>();
                    for(BigInteger i = m; i.compareTo(k) <= 0; i = i.add(BigInteger.valueOf(1)))
                        if(i.isProbablePrime(100))
                            primes.add(new Atom(new BigDecimal(i)));
                    return primes;
                }));
            }
        }));
    }
}
