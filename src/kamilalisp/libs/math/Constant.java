package kamilalisp.libs.math;

import ch.obermuhlner.math.big.BigDecimalMath;
import kamilalisp.data.*;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.math.MathContext;
import java.math.RoundingMode;
import java.util.List;

public class Constant {
    public static MathContext getFr(Environment env) {
        return new MathContext(env.get("fr").getNumber().get().intValue(), RoundingMode.HALF_EVEN);
    }

    public static void install(Environment env) {
        env.push("pi", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() == 0)
                    return new Atom(new LbcSupplier<>(() -> BigDecimalMath.pi(Constant.getFr(env.env))));
                else
                    return new Atom(new LbcSupplier<>(() -> {
                        arguments.get(0).guardType("Argument to 'pi'", Type.NUMBER);
                        return BigDecimalMath.pi(new MathContext(arguments.get(0).getNumber().get().intValue()));
                    }));
            }
        }));

        env.push("e", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() == 0)
                    return new Atom(new LbcSupplier<>(() -> BigDecimalMath.e(Constant.getFr(env.env))));
                else
                    return new Atom(new LbcSupplier<>(() -> {
                        arguments.get(0).guardType("Argument to 'e'", Type.NUMBER);
                        return BigDecimalMath.e(new MathContext(arguments.get(0).getNumber().get().intValue()));
                    }));
            }
        }));

        env.push("golden-ratio", new Atom(new Closure() {
            private BigDecimal goldenRatio(MathContext precision) {
                return BigDecimal.valueOf(5L).sqrt(precision).add(BigDecimal.ONE).divide(BigDecimal.valueOf(2L), precision);
            }

            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() == 0)
                    return new Atom(new LbcSupplier<>(() -> goldenRatio(Constant.getFr(env.env))));
                else
                    return new Atom(new LbcSupplier<>(() -> {
                        arguments.get(0).guardType("Argument to 'golden-ratio'", Type.NUMBER);
                        return goldenRatio(new MathContext(arguments.get(0).getNumber().get().intValue()));
                    }));
            }
        }));

        env.push("euler-gamma", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() == 0)
                    return new Atom(new LbcSupplier<>(() -> kamilalisp.libs.math.bigop.BigDecimalMath.gamma(Constant.getFr(env.env))));
                else
                    return new Atom(new LbcSupplier<>(() -> {
                        arguments.get(0).guardType("Argument to 'euler-gamma'", Type.NUMBER);
                        return kamilalisp.libs.math.bigop.BigDecimalMath.gamma(new MathContext(arguments.get(0).getNumber().get().intValue()));
                    }));
            }
        }));
    }
}
