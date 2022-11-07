package palaiologos.kamilalisp.runtime.math.bit;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.util.List;
import java.util.stream.Collectors;

public class BitNot extends PrimitiveFunction implements Lambda {
    public static Atom sgn1(Atom a) {
        a.assertTypes(Type.INTEGER, Type.LIST);
        if(a.getType() == Type.INTEGER) {
            return new Atom(a.getInteger().not());
        } else if(a.getType() == Type.LIST) {
            return new Atom(a.getList().stream().map(BitNot::sgn1).collect(Collectors.toList()));
        } else {
            throw new TypeError("`bit-not' not defined for: " + a.getType());
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.size() == 1) {
            return sgn1(args.get(0));
        } else if(args.size() == 0) {
            throw new TypeError("Expected 1 or more arguments to `bit-not'.");
        } else {
            return new Atom(args.stream().map(BitNot::sgn1).toList());
        }
    }

    @Override
    protected String name() {
        return "bit-not";
    }
}
