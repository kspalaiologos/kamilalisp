package kamilalisp.libs;

import kamilalisp.data.*;

import java.io.StringWriter;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.List;
import java.util.stream.Collectors;

public class MathLib {
    public static void install(Environment env) {
        env.push("+", new Atom(new Closure() {
            private Atom IDENTITY = new Atom(BigDecimal.ZERO);

            private Atom add2(Atom a1, Atom a2) {
                if(a1.getType() == Type.LIST && a2.getType() == Type.NUMBER) {
                    return new Atom(a1.getList().get().stream().map(x -> add2(x, a2)).collect(Collectors.toList()));
                } else if(a1.getType() == Type.NUMBER && a2.getType() == Type.LIST) {
                    return new Atom(a2.getList().get().stream().map(x -> add2(a1, x)).collect(Collectors.toList()));
                } else if(a1.getType() == Type.NUMBER && a2.getType() == Type.NUMBER) {
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
                if(arguments.size() == 0)
                    throw new Error("Invalid + invocation.");
                else if(arguments.size() == 1)
                    return arguments.get(0);
                return new Atom(new LbcSupplier<>(() -> arguments.stream().reduce(this::add2).orElse(IDENTITY).get().get()));
            }
        }));

        env.push("-", new Atom(new Closure() {
            private Atom IDENTITY = new Atom(BigDecimal.ZERO);

            private Atom sub2(Atom a1, Atom a2) {
                if(a1.getType() == Type.LIST && a2.getType() == Type.NUMBER) {
                    return new Atom(a1.getList().get().stream().map(x -> sub2(x, a2)).collect(Collectors.toList()));
                } else if(a1.getType() == Type.NUMBER && a2.getType() == Type.LIST) {
                    return new Atom(a2.getList().get().stream().map(x -> sub2(a1, x)).collect(Collectors.toList()));
                } else if(a1.getType() == Type.NUMBER && a2.getType() == Type.NUMBER) {
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
                else if(a.getType() == Type.LIST)
                    return new Atom(new LbcSupplier<>(() -> a.getList().get().stream().map(x -> sub1(x)).collect(Collectors.toList())));
                else
                    throw new Error("- unsupported on operand of type " + a.getType().name());
            }

            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() == 0)
                    throw new Error("Invalid - invocation.");
                else if(arguments.size() == 1)
                    return sub1(arguments.get(0));
                return new Atom(new LbcSupplier<>(() -> arguments.stream().reduce(this::sub2).orElse(IDENTITY).get().get()));
            }
        }));

        env.push("*", new Atom(new Closure() {
            private Atom IDENTITY = new Atom(BigDecimal.ZERO);

            private Atom mul2(Atom a1, Atom a2) {
                if(a1.getType() == Type.LIST && a2.getType() == Type.NUMBER) {
                    return new Atom(a1.getList().get().stream().map(x -> mul2(x, a2)).collect(Collectors.toList()));
                } else if(a1.getType() == Type.NUMBER && a2.getType() == Type.LIST) {
                    return new Atom(a2.getList().get().stream().map(x -> mul2(a1, x)).collect(Collectors.toList()));
                } else if(a1.getType() == Type.NUMBER && a2.getType() == Type.NUMBER) {
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
                if(a.getType() == Type.LIST)
                    return new Atom(new LbcSupplier<>(() -> a.getList().get().stream().map(x -> mul1(x)).collect(Collectors.toList())));
                else if(a.getType() == Type.NUMBER)
                    return new Atom(new LbcSupplier<>(() -> new BigDecimal(a.getNumber().get().compareTo(BigDecimal.ZERO))));
                else
                    throw new Error("* unsupported on operand of type " + a.getType().name());
            }

            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() == 0)
                    throw new Error("Invalid * invocation.");
                if(arguments.size() == 1)
                    return mul1(arguments.get(0));
                return new Atom(new LbcSupplier<>(() -> arguments.stream().reduce(this::mul2).orElse(IDENTITY).get().get()));
            }
        }));
    }
}
