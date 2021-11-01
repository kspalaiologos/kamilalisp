package kamilalisp.libs;

import com.google.common.base.Splitter;
import com.google.common.collect.Lists;
import kamilalisp.data.*;

import java.io.StringWriter;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.math.MathContext;
import java.math.RoundingMode;
import java.util.*;
import java.util.function.BinaryOperator;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

public class MathLib {
    public static void install(Environment env) {
        env.push("+", new Atom(new Closure() {
            private Atom IDENTITY = new Atom(BigDecimal.ZERO);

            private Atom add2(Atom a1, Atom a2) {
                if(a1.getType() == Type.NUMBER && a2.getType() == Type.NUMBER) {
                    return new Atom(a1.getNumber().get().add(a2.getNumber().get()));
                } else if(a1.getType() == Type.STRING_CONSTANT && a2.getType() == Type.STRING_CONSTANT) {
                    return new Atom(new StringConstant(a1.getStringConstant().get().get() + a2.getStringConstant().get().get()));
                } else if(a1.getType() == Type.NUMBER && a2.getType() == Type.STRING_CONSTANT) {
                    return new Atom(new StringConstant(a1.getNumber().get().toPlainString() + a2.getStringConstant().get().get()));
                } else if(a1.getType() == Type.STRING_CONSTANT && a2.getType() == Type.NUMBER) {
                    return new Atom(new StringConstant(a1.getStringConstant().get().get() + a2.getNumber().get().toPlainString()));
                } else {
                    throw new Error("+ unsupported on operands of type " + a1.getType().name() + " and " + a1.getType().name());
                }
            }

            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() == 0 || arguments.size() > 2)
                    throw new Error("Invalid + invocation.");
                else if(arguments.size() == 1)
                    return arguments.get(0);
                return new Atom(new LbcSupplier<>(() -> add2(arguments.get(0), arguments.get(1)).get().get()));
            }
        }));

        env.push("-", new Atom(new Closure() {
            private Atom IDENTITY = new Atom(BigDecimal.ZERO);

            private Atom sub2(Atom a1, Atom a2) {
                if(a1.getType() == Type.NUMBER && a2.getType() == Type.NUMBER) {
                    return new Atom(a1.getNumber().get().subtract(a2.getNumber().get()));
                } else if(a1.getType() == Type.STRING_CONSTANT && a2.getType() == Type.STRING_CONSTANT) {
                    final String lookup = a2.getStringConstant().get().get();
                    return new Atom(new StringConstant(a1.getStringConstant().get().get()
                            .chars().filter(x -> lookup.indexOf(x) != -1).collect(StringWriter::new, StringWriter::write,
                                    (swl, swr) -> swl.write(swr.toString())).toString()));
                } else if(a1.getType() == Type.NUMBER && a2.getType() == Type.STRING_CONSTANT) {
                    return new Atom(new StringConstant(a2.getStringConstant().get().get().substring(a1.getNumber().get().intValue())));
                } else if(a1.getType() == Type.STRING_CONSTANT && a2.getType() == Type.NUMBER) {
                    String s = a1.getStringConstant().get().get();
                    return new Atom(new StringConstant(s.substring(0, s.length() - a2.getNumber().get().intValue())));
                } else {
                    throw new Error("- unsupported on operands of type " + a1.getType().name() + " and " + a1.getType().name());
                }
            }

            private Atom sub1(Atom a) {
                a.guardType("Argument to monadic -", Type.NUMBER);
                throw new Error("- unsupported on operand of type " + a.getType().name());
            }

            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() == 0 || arguments.size() > 2)
                    throw new Error("Invalid - invocation.");
                else if(arguments.size() == 1)
                    return sub1(arguments.get(0));
                return new Atom(new LbcSupplier<>(() -> sub2(arguments.get(0), arguments.get(1)).get().get()));
            }
        }));

        env.push("*", new Atom(new Closure() {
            private Atom IDENTITY = new Atom(BigDecimal.ZERO);

            private Atom mul2(Atom a1, Atom a2) {
                if(a1.getType() == Type.NUMBER && a2.getType() == Type.NUMBER) {
                    return new Atom(a1.getNumber().get().multiply(a2.getNumber().get()));
                } else if(a1.getType() == Type.NUMBER && a2.getType() == Type.STRING_CONSTANT) {
                    return new Atom(new StringConstant(a2.getStringConstant().get().get().repeat(a1.getNumber().get().intValue())));
                } else if(a1.getType() == Type.STRING_CONSTANT && a2.getType() == Type.NUMBER) {
                    return new Atom(new StringConstant(a1.getStringConstant().get().get().repeat(a2.getNumber().get().intValue())));
                } else {
                    throw new Error("* unsupported on operands of type " + a1.getType().name() + " and " + a1.getType().name());
                }
            }

            public Atom mul1(Atom a) {
                a.guardType("Argument to monadic *", Type.NUMBER);
                return new Atom(new LbcSupplier<>(() -> new BigDecimal(a.getNumber().get().compareTo(BigDecimal.ZERO))));
            }

            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() == 0 || arguments.size() > 2)
                    throw new Error("Invalid * invocation.");
                if(arguments.size() == 1)
                    return mul1(arguments.get(0));
                return new Atom(new LbcSupplier<>(() -> mul2(arguments.get(0), arguments.get(1)).get().get()));
            }
        }));

        env.push("/", new Atom(new Closure() {
            private Atom IDENTITY = new Atom(BigDecimal.ZERO);

            private Atom div2(Atom a1, Atom a2) {
                if(a1.getType() == Type.NUMBER && a2.getType() == Type.NUMBER) {
                    return new Atom(a1.getNumber().get().divide(a2.getNumber().get(), MathContext.DECIMAL128).setScale(0, RoundingMode.FLOOR));
                } else if(a1.getType() == Type.STRING_CONSTANT && a2.getType() == Type.NUMBER) {
                    String s = a1.getStringConstant().get().get();
                    return new Atom(Lists.newLinkedList(
                            Splitter
                                    .fixedLength(s.length() / a2.getNumber().get().intValue())
                                    .split(s)
                        ).stream()
                            .map(x -> new Atom(new StringConstant(x)))
                            .collect(Collectors.toList()));
                } else if(a1.getType() == Type.LIST && a2.getType() == Type.NUMBER) {
                    List<Atom> s = a1.getList().get();
                    return new Atom(Lists.partition(s, s.size() / a2.getNumber().get().intValue()).stream().map(x -> new Atom(x)).collect(Collectors.toList()));
                } else {
                    throw new Error("/ unsupported on operands of type " + a1.getType().name() + " and " + a1.getType().name());
                }
            }

            public Atom div1(Atom a) {
                a.guardType("Argument to monadic /", Type.NUMBER);
                return new Atom(new LbcSupplier<>(() -> BigDecimal.ONE.divide(a.getNumber().get())));
            }

            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() == 0 || arguments.size() > 2)
                    throw new Error("Invalid / invocation.");
                if(arguments.size() == 1)
                    return div1(arguments.get(0));
                return new Atom(new LbcSupplier<>(() -> div2(arguments.get(0), arguments.get(1)).get().get()));
            }
        }));

        env.push("gcd", new Atom(new Closure() {
            private Atom IDENTITY = new Atom(BigDecimal.ZERO);

            private Atom gcd2(Atom a1, Atom a2) {
                a1.guardType("First argument to 'gcd'", Type.NUMBER);
                a2.guardType("Second argument to 'gcd'", Type.NUMBER);
                return new Atom(new BigDecimal(a1.getNumber().get().toBigInteger().gcd(a2.getNumber().get().toBigInteger())));
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
                a1.guardType("First argument to 'lcm'", Type.NUMBER);
                a2.guardType("Second argument to 'lcm'", Type.NUMBER);
                return new Atom(a1.getNumber().get().multiply(a2.getNumber().get()).divide(new BigDecimal(a1.getNumber().get().toBigInteger().gcd(a2.getNumber().get().toBigInteger()))));
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

        env.push("iota", new Atom(new Closure() {
            private List<BigDecimal> iota(long n) {
                List<BigDecimal> result = new ArrayList<>();
                for(long i = 0; i < n; i++)
                    result.add(BigDecimal.valueOf(i));
                return result;
            }

            protected <T> List<List<T>> cartesianProduct(List<List<T>> lists) {
                List<List<T>> resultLists = new ArrayList<List<T>>();
                if (lists.size() == 0) {
                    resultLists.add(new ArrayList<T>());
                    return resultLists;
                } else {
                    List<T> firstList = lists.get(0);
                    List<List<T>> remainingLists = cartesianProduct(lists.subList(1, lists.size()));
                    for (T condition : firstList) {
                        for (List<T> remainingList : remainingLists) {
                            ArrayList<T> resultList = new ArrayList<T>();
                            resultList.add(condition);
                            resultList.addAll(remainingList);
                            resultLists.add(resultList);
                        }
                    }
                }
                return resultLists;
            }

            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'iota'.");
                if(arguments.get(0).getType() == Type.NUMBER)
                    return new Atom(new LbcSupplier<>(() ->
                            iota(arguments.get(0).getNumber().get().toBigInteger().intValue())
                                    .stream().map(Atom::new).collect(Collectors.toList())));
                else if(arguments.get(0).getType() == Type.LIST) {
                    return new Atom(new LbcSupplier<>(() -> {
                        List<List<BigDecimal>> iotas = arguments.get(0).getList().get().stream().map(x -> {
                            if(x.getType() != Type.NUMBER)
                                throw new Error("Invalid invocation to 'iota'. Expected a list of numbers.");
                            return iota(x.getNumber().get().toBigInteger().intValue());
                        }).collect(Collectors.toList());

                        return cartesianProduct(iotas)
                                .stream()
                                .map(x -> new Atom(x.stream().map(Atom::new).collect(Collectors.toList())))
                                .collect(Collectors.toList());
                    }));
                }
                throw new Error("Unimplemented");
            }
        }));
    }
}
