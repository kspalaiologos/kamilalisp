package palaiologos.kamilalisp.runtime.math;

import ch.obermuhlner.math.big.BigComplex;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class Signum extends PrimitiveFunction implements Lambda {
    private static Atom sgn1(Atom a) {
        a.assertTypes(Type.INTEGER, Type.REAL, Type.COMPLEX, Type.LIST);
        if (a.getType() == Type.COMPLEX) {
            return new Atom(BigComplex.valueOf(a.getComplex().re.signum(), a.getComplex().im.signum()));
        } else if (a.getType() == Type.REAL) {
            return new Atom(BigDecimal.valueOf(a.getReal().signum()));
        } else if (a.getType() == Type.INTEGER) {
            return new Atom(BigInteger.valueOf(a.getInteger().signum()));
        } else if (a.getType() == Type.LIST) {
            List<Atom> list = new ArrayList<>(a.getList().size());
            for (Atom atom : a.getList()) {
                Atom sgn1 = sgn1(atom);
                list.add(sgn1);
            }
            return new Atom(list);
        } else {
            throw new TypeError("`signum' not defined for: " + a.getType());
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() == 1) {
            return sgn1(args.get(0));
        } else if (args.isEmpty()) {
            throw new TypeError("Expected 1 or more arguments to `signum'.");
        } else {
            List<Atom> list = new ArrayList<>(args.size());
            for (Atom arg : args) {
                Atom atom = sgn1(arg);
                list.add(atom);
            }
            return new Atom(list);
        }
    }

    @Override
    protected String name() {
        return "signum";
    }
}
