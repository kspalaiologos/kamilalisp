package palaiologos.kamilalisp.runtime.math;

import ch.obermuhlner.math.big.BigComplex;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class Round extends PrimitiveFunction implements Lambda {
    private static Atom sgn1(Environment e, Atom a) {
        a.assertTypes(Type.INTEGER, Type.REAL, Type.COMPLEX, Type.LIST);
        if (a.getType() == Type.COMPLEX) {
            return new Atom(BigComplex.valueOf(
                    a.getComplex().re.setScale(0, RoundingMode.HALF_UP),
                    a.getComplex().im.setScale(0, RoundingMode.HALF_UP)));
        } else if (a.getType() == Type.REAL) {
            return new Atom(a.getReal().setScale(0, RoundingMode.HALF_UP).unscaledValue());
        } else if (a.getType() == Type.INTEGER) {
            return a;
        } else if (a.getType() == Type.LIST) {
            ArrayList<Atom> list = new ArrayList<>(a.getList().size());
            for (Atom x : a.getList()) {
                Atom atom = sgn1(e, x);
                list.add(atom);
            }
            return new Atom(list);
        } else {
            throw new TypeError("`round' not defined for: " + a.getType());
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() == 1) {
            return sgn1(env, args.get(0));
        } else if (args.isEmpty()) {
            throw new TypeError("Expected 1 or more arguments to `round'.");
        } else {
            ArrayList<Atom> list = new ArrayList<>(args.size());
            for (Atom x : args) {
                Atom atom = sgn1(env, x);
                list.add(atom);
            }
            return new Atom(list);
        }
    }

    @Override
    protected String name() {
        return "round";
    }
}
