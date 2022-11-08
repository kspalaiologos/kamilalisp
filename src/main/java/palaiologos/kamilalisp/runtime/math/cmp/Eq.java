package palaiologos.kamilalisp.runtime.math.cmp;

import com.google.common.collect.Streams;
import palaiologos.kamilalisp.atom.*;

import java.math.BigDecimal;
import java.util.List;

public class Eq extends PrimitiveFunction implements Lambda {
    private static String name = "=";

    @Override
    protected String name() {
        return name;
    }

    private static Atom cmp2(Environment e, Atom a, Atom b) {
        if(a.getType() == Type.REAL && b.getType() == Type.REAL) {
            return new Atom(a.getReal().compareTo(b.getReal()) == 0);
        } else if(a.getType() == Type.REAL && b.getType() == Type.INTEGER) {
            return new Atom(a.getReal().compareTo(new BigDecimal(b.getInteger())) == 0);
        } else if(a.getType() == Type.INTEGER && b.getType() == Type.REAL) {
            return new Atom(new BigDecimal(a.getInteger()).compareTo(b.getReal()) == 0);
        } else if(a.getType() == Type.INTEGER && b.getType() == Type.INTEGER) {
            return new Atom(a.getInteger().compareTo(b.getInteger()) == 0);
        } else if(a.getType() == Type.STRING && b.getType() == Type.STRING) {
            return new Atom(a.getString().compareTo(b.getString()) == 0);
        } else if(a.getType() == Type.COMPLEX && b.isNumeric()) {
            return new Atom(a.getComplex().equals(b.getComplex()));
        } else if(a.isNumeric() && b.getType() == Type.COMPLEX) {
            return new Atom(a.getComplex().equals(b.getComplex()));
        } else if(a.getType() == Type.LIST && (b.getType() == Type.REAL || b.getType() == Type.INTEGER || b.getType() == Type.STRING)) {
            return new Atom(a.getList().stream().map(x -> cmp2(e, x, b)).toList());
        } else if((a.getType() == Type.REAL || a.getType() == Type.INTEGER || a.getType() == Type.STRING) && b.getType() == Type.LIST) {
            return new Atom(b.getList().stream().map(x -> cmp2(e, a, x)).toList());
        } else if(a.getType() == Type.LIST && b.getType() == Type.LIST) {
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
