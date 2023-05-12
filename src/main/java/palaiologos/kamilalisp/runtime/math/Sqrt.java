package palaiologos.kamilalisp.runtime.math;

import ch.obermuhlner.math.big.BigComplexMath;
import ch.obermuhlner.math.big.BigDecimalMath;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.ArrayList;
import java.util.List;

public class Sqrt extends PrimitiveFunction implements Lambda {
    private static Atom sqrt(Environment e, Atom a) {
        switch (a.getType()) {
            case LIST:
                ArrayList<Atom> list = new ArrayList<>(a.getList().size());
                for (Atom x : a.getList()) {
                    Atom sqrt = sqrt(e, x);
                    list.add(sqrt);
                }
                return new Atom(list);
            case REAL:
            case INTEGER:
                return new Atom(BigDecimalMath.sqrt(a.getReal(), e.getMathContext()));
            case COMPLEX:
                return new Atom(BigComplexMath.sqrt(a.getComplex(), e.getMathContext()));
            default:
                throw new UnsupportedOperationException("sqrt not defined for: " + a.getType());
        }
    }

    @Override
    protected String name() {
        return "sqrt";
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.isEmpty()) {
            throw new RuntimeException("sqrt called with no arguments.");
        }

        if (args.size() == 1) {
            return sqrt(env, args.get(0));
        }

        ArrayList<Atom> list = new ArrayList<>(args.size());
        for (Atom x : args) {
            Atom sqrt = sqrt(env, x);
            list.add(sqrt);
        }
        return new Atom(list);
    }
}
