package palaiologos.kamilalisp.runtime.math;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class Not extends PrimitiveFunction implements Lambda {
    private static Atom not1(Atom a) {
        a.assertTypes(Type.INTEGER, Type.REAL, Type.COMPLEX, Type.LIST);
        if (a.getType() == Type.REAL) {
            return new Atom(a.getReal().equals(BigDecimal.ZERO) ? BigDecimal.ONE : BigDecimal.ZERO);
        } else if (a.getType() == Type.INTEGER) {
            return new Atom(a.getInteger().equals(BigInteger.ZERO) ? BigInteger.ONE : BigInteger.ZERO);
        } else if (a.getType() == Type.LIST) {
            ArrayList<Atom> list = new ArrayList<>(a.getList().size());
            for (Atom atom : a.getList()) {
                Atom not1 = not1(atom);
                list.add(not1);
            }
            return new Atom(list);
        } else {
            throw new TypeError("`not' not defined for: " + a.getType());
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() == 1) {
            return not1(args.get(0));
        } else if (args.isEmpty()) {
            throw new TypeError("Expected 1 or more arguments to `not'.");
        } else {
            ArrayList<Atom> list = new ArrayList<>(args.size());
            for (Atom arg : args) {
                Atom atom = not1(arg);
                list.add(atom);
            }
            return new Atom(list);
        }
    }

    @Override
    protected String name() {
        return "not";
    }
}
