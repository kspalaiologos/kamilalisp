package palaiologos.kamilalisp.runtime.math;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.util.List;
import java.util.stream.Collectors;

public class Abs extends PrimitiveFunction implements Lambda {
    private static Atom sgn1(Environment e, Atom a) {
        a.assertTypes(Type.INTEGER, Type.REAL, Type.COMPLEX, Type.LIST);
        if (a.getType() == Type.COMPLEX) {
            return new Atom(a.getComplex().abs(e.getMathContext()));
        } else if (a.getType() == Type.REAL) {
            return new Atom(a.getReal().abs(e.getMathContext()));
        } else if (a.getType() == Type.INTEGER) {
            return new Atom(a.getInteger().abs());
        } else if (a.getType() == Type.LIST) {
            return new Atom(a.getList().stream().map(x -> sgn1(e, x)).collect(Collectors.toList()));
        } else {
            throw new TypeError("`abs' not defined for: " + a.getType());
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() == 1) {
            return sgn1(env, args.get(0));
        } else if (args.isEmpty()) {
            throw new TypeError("Expected 1 or more arguments to `abs'.");
        } else {
            return new Atom(args.stream().map(x -> sgn1(env, x)).toList());
        }
    }

    @Override
    protected String name() {
        return "abs";
    }
}
