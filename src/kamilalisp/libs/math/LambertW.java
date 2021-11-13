package kamilalisp.libs.math;

import ch.obermuhlner.math.big.BigDecimalMath;
import kamilalisp.data.*;

import java.math.BigDecimal;
import java.math.MathContext;
import java.math.RoundingMode;
import java.util.List;

public class LambertW {
    private static final BigDecimal e1 = BigDecimalMath.exp(new BigDecimal(1), new MathContext(100, RoundingMode.HALF_EVEN));

    public static void install(Environment env) {
        // Magic. You weren't meant to understand this.
        env.push("lambert-w", new Atom(new Closure() {
            private BigDecimal ratio(Environment env, int x, int y) {
                return BigDecimal.valueOf(x).divide(BigDecimal.valueOf(y), Constant.getFr(env));
            }

            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'lambert-w'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("Argument to 'lambert-w'", Type.NUMBER);
                    BigDecimal x = arguments.get(0).getNumber().get();
                    if(x.compareTo(new BigDecimal("-0.36787944118")) == -1)
                        throw new Error("'lambert-w' domain error: x < -1/e");
                    BigDecimal w;
                    if(x.compareTo(new BigDecimal("0.06")) == -1) {
                        BigDecimal ti = x.multiply(BigDecimal.valueOf(2)).multiply(e1).add(BigDecimal.valueOf(2));
                        if(ti.compareTo(BigDecimal.ZERO) == -1 || ti.compareTo(BigDecimal.ZERO) == 0)
                            return new BigDecimal(-1);
                        BigDecimal t = BigDecimalMath.sqrt(ti, Constant.getFr(env.env));
                        w = BigDecimal.valueOf(-1)
                                .add(t.multiply(ratio(env.env, 1, 6)))
                                .add(t.multiply(t).multiply(ratio(env.env, 257,720)))
                                .add(t.multiply(t).multiply(t).multiply(ratio(env.env, 13, 720))).divide(
                                        BigDecimal.valueOf(1)
                                                .add(t.multiply(ratio(env.env, 5, 6)))
                                                .add(t.multiply(t).multiply(ratio(env.env, 103, 720)))
                                );
                    } else if(x.compareTo(new BigDecimal("1.363")) == -1) {
                        BigDecimal l1 = BigDecimalMath.log(x.add(BigDecimal.ONE), Constant.getFr(env.env));
                        w = l1.multiply(BigDecimal.ONE.subtract(
                                BigDecimalMath.log(BigDecimal.ONE.add(l1), Constant.getFr(env.env))
                                        .divide(BigDecimal.valueOf(2).add(l1), Constant.getFr(env.env))));
                    } else if(x.compareTo(new BigDecimal("3.7")) == -1) {
                        BigDecimal l1 = BigDecimalMath.log(x, Constant.getFr(env.env));
                        BigDecimal l2 = BigDecimalMath.log(l1, Constant.getFr(env.env));
                        w = l1.subtract(l2).subtract(
                                BigDecimalMath.log(BigDecimal.ONE.subtract(l2.divide(l1, Constant.getFr(env.env))), Constant.getFr(env.env))
                                        .divide(BigDecimal.valueOf(2), Constant.getFr(env.env)));
                    } else {
                        BigDecimal l1 = BigDecimalMath.log(x, Constant.getFr(env.env));
                        BigDecimal l2 = BigDecimalMath.log(l1, Constant.getFr(env.env));
                        BigDecimal d1 = BigDecimal.valueOf(2).multiply(l1).multiply(l1);
                        BigDecimal d2 = BigDecimal.valueOf(3).multiply(l1).multiply(d1);
                        BigDecimal d3 = BigDecimal.valueOf(2).multiply(l1).multiply(d2);
                        BigDecimal d4 = BigDecimal.valueOf(5).multiply(l1).multiply(d3);
                        w = l1.subtract(l2)
                                .add(l2.divide(l1, Constant.getFr(env.env)))
                                .add(l2.multiply(l2.subtract(BigDecimal.valueOf(2))).divide(d1, Constant.getFr(env.env)))
                                .add(l2.multiply(BigDecimal.valueOf(6).add(l2.multiply(BigDecimal.valueOf(-9).add(BigDecimal.valueOf(2).multiply(l2))))).divide(d2, Constant.getFr(env.env)))
                                .add(l2.multiply(BigDecimal.valueOf(-12).add(l2.multiply(BigDecimal.valueOf(36).add(l2.multiply(BigDecimal.valueOf(-22).add(BigDecimal.valueOf(3).multiply(l2))))))).divide(d3, Constant.getFr(env.env)))
                                .add(l2.multiply(BigDecimal.valueOf(60).add(l2.multiply(BigDecimal.valueOf(-300).add(l2.multiply(BigDecimal.valueOf(350).add(l2.multiply(BigDecimal.valueOf(-125).add(BigDecimal.valueOf(12).multiply(l2))))))))).divide(d4, Constant.getFr(env.env)));
                    }
                    BigDecimal tol = new BigDecimal("1e-16");
                    for(int i = 0; i < 200; i++) {
                        if(w.compareTo(BigDecimal.ZERO) == 0) {
                            break;
                        }
                        BigDecimal w1 = w.add(BigDecimal.ONE);
                        BigDecimal zn = BigDecimalMath.log(x.divide(w, Constant.getFr(env.env)), Constant.getFr(env.env)).subtract(w);
                        BigDecimal qn = w1.multiply(BigDecimal.valueOf(2)).multiply(w1.add(BigDecimal.valueOf(2).multiply(zn.divide(BigDecimal.valueOf(3), Constant.getFr(env.env)))));
                        BigDecimal en = zn.divide(w1, Constant.getFr(env.env)).multiply(qn.subtract(zn)).divide(qn.subtract(zn.multiply(BigDecimal.valueOf(2))), Constant.getFr(env.env));
                        BigDecimal wen = w.multiply(en);
                        w = w.add(wen);
                        if(wen.abs().compareTo(tol) < 0) {
                            break;
                        }
                    }
                    return w;
                }));
            }
        }));
    }
}
