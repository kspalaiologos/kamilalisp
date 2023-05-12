package palaiologos.kamilalisp.runtime.math.bit;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class BitNot extends PrimitiveFunction implements Lambda {
    private static Atom sgn1(Atom a) {
        a.assertTypes(Type.INTEGER, Type.LIST);
        if (a.getType() == Type.INTEGER) {
            return new Atom(a.getInteger().not());
        } else if (a.getType() == Type.LIST) {
            ArrayList<Atom> list = new ArrayList<>();
            for (Atom atom : a.getList()) {
                Atom sgn1 = sgn1(atom);
                list.add(sgn1);
            }
            return new Atom(list);
        } else {
            throw new TypeError("`bit:not' not defined for: " + a.getType());
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() == 1) {
            return sgn1(args.get(0));
        } else if (args.isEmpty()) {
            throw new TypeError("Expected 1 or more arguments to `bit:not'.");
        } else {
            ArrayList<Atom> list = new ArrayList<>();
            for (Atom arg : args) {
                Atom atom = sgn1(arg);
                list.add(atom);
            }
            return new Atom(list);
        }
    }

    @Override
    protected String name() {
        return "bit:not";
    }
}
