package kamilalisp.libs.math;

import kamilalisp.data.*;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.List;

public class MobiusMu {
    public static void install(Environment env) {
        env.push("mobius-mu", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'mobius-mu'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("Argument to 'mobius-mu'", Type.NUMBER);
                    BigInteger n = arguments.get(0).getNumber().get().toBigInteger();
                    if(n.compareTo(BigInteger.ONE) <= 0)
                        return n.compareTo(BigInteger.ONE) == 0 ? BigDecimal.ONE : BigDecimal.ZERO;
                    if(n.compareTo(BigInteger.valueOf(49)) >= 0) {
                        if(!(n.mod(BigInteger.valueOf(4)).equals(BigInteger.ZERO) &&
                                n.mod(BigInteger.valueOf(9)).equals(BigInteger.ZERO) &&
                                n.mod(BigInteger.valueOf(25)).equals(BigInteger.ZERO) &&
                                n.mod(BigInteger.valueOf(49)).equals(BigInteger.ZERO)))
                            return BigDecimal.ZERO;
                    }
                    PollardRho r = new PollardRho();
                    r.factor(n);
                    List<BigInteger> factors = r.getFactors();
                    for(int i = 1; i < factors.size(); i++)
                        if(factors.get(i).equals(factors.get(i - 1)))
                            return BigDecimal.ZERO;
                    return factors.size() % 2 == 0 ? BigDecimal.ONE : BigDecimal.ONE.negate();
                }));
            }
        }));
    }
}
