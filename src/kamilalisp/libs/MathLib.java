package kamilalisp.libs;

import kamilalisp.data.*;

import java.io.StringWriter;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.LinkedList;
import java.util.List;
import java.util.function.BinaryOperator;
import java.util.stream.Collectors;

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
                if(a.getType() == Type.NUMBER)
                    return new Atom(new LbcSupplier<>(() -> a.getNumber().get().negate()));
                else
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
                if(a.getType() == Type.NUMBER)
                    return new Atom(new LbcSupplier<>(() -> new BigDecimal(a.getNumber().get().compareTo(BigDecimal.ZERO))));
                else
                    throw new Error("* unsupported on operand of type " + a.getType().name());
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

        env.push("gcd", new Atom(new Closure() {
            private Atom IDENTITY = new Atom(BigDecimal.ZERO);

            private Atom gcd2(Atom a1, Atom a2) {
                if(a1.getType() != Type.NUMBER || a2.getType() != Type.NUMBER)
                    throw new Error("Invalid argument to 'gcd'.");
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
                if(a1.getType() != Type.NUMBER || a2.getType() != Type.NUMBER)
                    throw new Error("Invalid argument to 'lcm'.");
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
                if(a.getType() == Type.NUMBER) {
                    return new Atom(BigDecimal.valueOf(a.getNumber().get().compareTo(BigDecimal.ZERO) == 0 ? 1 : 0));
                } else if(a.getType() == Type.STRING_CONSTANT) {
                    return new Atom(new StringConstant(reverseCase(a.getStringConstant().get().get())));
                } else
                    throw new Error("Invalid invocation to '~', unexpected value of type " + a.getType().name());
            }

            public Atom neg2(Atom a, Atom b) {
                if(a.getType() != Type.LIST)
                    throw new Error("Dyadic '~' expects a list as the first argument, got " + a.getType().name());
                if(b.getType() == Type.LIST) {
                    List<Atom> clone = new LinkedList<>(a.getList().get());
                    clone.removeAll(b.getList().get());
                    return new Atom(clone);
                } else {
                    List<Atom> clone = new LinkedList<>(a.getList().get());
                    clone.remove(a);
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
    }
}
