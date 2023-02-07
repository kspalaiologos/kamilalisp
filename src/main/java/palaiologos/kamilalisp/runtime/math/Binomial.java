package palaiologos.kamilalisp.runtime.math;

import ch.obermuhlner.math.big.BigDecimalMath;
import com.google.common.math.BigIntegerMath;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.List;

public class Binomial extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() != 2)
            throw new TypeError("binomial takes exactly two arguments");
        Atom a = args.get(0);
        Atom b = args.get(1);
        if (a.getType() == Type.INTEGER && b.getType() == Type.INTEGER) {
            BigInteger k = a.getInteger();
            BigInteger n = b.getInteger();
            return new Atom(BigIntegerMath.binomial(n.intValueExact(), k.intValueExact()));
        } else {
            BigDecimal k = a.getReal();
            BigDecimal n = b.getReal();
            return new Atom(BigDecimalMath.gamma(n.add(BigDecimal.ONE), env.getMathContext())
                    .divide(BigDecimalMath.gamma(k.add(BigDecimal.ONE), env.getMathContext()), env.getMathContext())
                    .divide(BigDecimalMath.gamma(n.subtract(k).add(BigDecimal.ONE), env.getMathContext()), env.getMathContext()));
        }
    }

    @Override
    protected String name() {
        return "binomial";
    }
}
