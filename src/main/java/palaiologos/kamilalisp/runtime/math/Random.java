package palaiologos.kamilalisp.runtime.math;

import ch.obermuhlner.math.big.BigComplex;
import com.google.common.primitives.Chars;
import org.apache.commons.lang3.StringUtils;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

public class Random extends PrimitiveFunction implements Lambda {
    private static java.util.Random rng = new java.util.Random();

    private static Atom shuffle(Atom a) {
        a.assertTypes(Type.INTEGER, Type.REAL, Type.COMPLEX);
        if(a.getType() == Type.INTEGER) {
            // Random BigInteger in range [0, a).
            BigInteger n = a.getInteger();
            return new Atom(new BigInteger(n.bitLength(), rng).mod(n));
        } else if(a.getType() == Type.REAL) {
            // Random double in range [0, a).
            BigDecimal n = a.getReal();
            return new Atom(n.multiply(BigDecimal.valueOf(rng.nextDouble())));
        } else {
            // Random complex in range [0, a).
            BigComplex n = a.getComplex();
            BigDecimal re = n.re.multiply(BigDecimal.valueOf(rng.nextDouble()));
            BigDecimal im = n.im.multiply(BigDecimal.valueOf(rng.nextDouble()));
            return new Atom(BigComplex.valueOf(re, im));
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.isEmpty())
            throw new TypeError("Expected 1 or more arguments to `random'.");
        if (args.size() == 1)
            return shuffle(args.get(0));
        return new Atom(args.stream().map(Random::shuffle).collect(Collectors.toList()));
    }

    @Override
    protected String name() {
        return "random";
    }
}
