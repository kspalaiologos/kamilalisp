package palaiologos.kamilalisp.runtime.math;

import ch.obermuhlner.math.big.BigComplex;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.List;
import java.util.stream.Collectors;

public class Not extends PrimitiveFunction implements Lambda {
    public static Atom not1(Atom a) {
        a.assertTypes(Type.INTEGER, Type.REAL, Type.COMPLEX, Type.LIST);
        if(a.getType() == Type.REAL) {
            return new Atom(a.getReal().equals(BigDecimal.ZERO) ? BigDecimal.ONE : BigDecimal.ZERO);
        } else if(a.getType() == Type.INTEGER) {
            return new Atom(a.getInteger().equals(BigInteger.ZERO) ? BigInteger.ONE : BigInteger.ZERO);
        } else if(a.getType() == Type.LIST) {
            return new Atom(a.getList().stream().map(Not::not1).collect(Collectors.toList()));
        } else {
            throw new TypeError("`not' not defined for: " + a.getType());
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.size() == 1) {
            return not1(args.get(0));
        } else if(args.size() == 0) {
            throw new TypeError("Expected 1 or more arguments to `not'.");
        } else {
            return new Atom(args.stream().map(Not::not1).toList());
        }
    }

    @Override
    protected String name() {
        return "not";
    }
}
