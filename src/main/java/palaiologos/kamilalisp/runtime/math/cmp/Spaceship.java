package palaiologos.kamilalisp.runtime.math.cmp;

import com.google.common.collect.Streams;
import palaiologos.kamilalisp.atom.*;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.List;

public class Spaceship extends PrimitiveFunction implements Lambda {
    private static final String name = "<=>";

    @Override
    protected String name() {
        return name;
    }

    private static Atom cmp2(Environment e, Atom a, Atom b) {
        if (a.getType() == Type.REAL && b.getType() == Type.REAL) {
            return new Atom(BigInteger.valueOf(a.getReal().compareTo(b.getReal())));
        } else if (a.getType() == Type.REAL && b.getType() == Type.INTEGER) {
            return new Atom(BigInteger.valueOf(a.getReal().compareTo(new BigDecimal(b.getInteger()))));
        } else if (a.getType() == Type.INTEGER && b.getType() == Type.REAL) {
            return new Atom(BigInteger.valueOf(new BigDecimal(a.getInteger()).compareTo(b.getReal())));
        } else if (a.getType() == Type.INTEGER && b.getType() == Type.INTEGER) {
            return new Atom(BigInteger.valueOf(a.getInteger().compareTo(b.getInteger())));
        } else if (a.getType() == Type.STRING && b.getType() == Type.STRING) {
            return new Atom(BigInteger.valueOf(a.getString().compareTo(b.getString())));
        } else if (a.getType() == Type.LIST && (b.getType() == Type.REAL || b.getType() == Type.INTEGER || b.getType() == Type.STRING)) {
            return new Atom(a.getList().stream().map(x -> cmp2(e, x, b)).toList());
        } else if ((a.getType() == Type.REAL || a.getType() == Type.INTEGER || a.getType() == Type.STRING) && b.getType() == Type.LIST) {
            return new Atom(b.getList().stream().map(x -> cmp2(e, a, x)).toList());
        } else if (a.getType() == Type.LIST && b.getType() == Type.LIST) {
            return new Atom(Streams.zip(a.getList().stream(), b.getList().stream(), (x, y) -> cmp2(e, x, y)).toList());
        } else {
            throw new UnsupportedOperationException(name + " not defined for: " + a.getType() + " and " + b.getType());
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        return cmp2(env, args.get(0), args.get(1));
    }
}
