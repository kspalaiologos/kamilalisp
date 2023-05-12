package palaiologos.kamilalisp.runtime.math;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.ArrayList;
import java.util.List;

public class Re extends PrimitiveFunction implements Lambda {
    private static Atom ln(Environment e, Atom a) {
        switch (a.getType()) {
            case LIST:
                ArrayList<Atom> list = new ArrayList<>(a.getList().size());
                for (Atom x : a.getList()) {
                    Atom ln = ln(e, x);
                    list.add(ln);
                }
                return new Atom(list);
            case REAL:
            case INTEGER:
                return a;
            case COMPLEX:
                return new Atom(a.getComplex().re);
            default:
                throw new UnsupportedOperationException("re not defined for: " + a.getType());
        }
    }

    @Override
    protected String name() {
        return "re";
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.isEmpty()) {
            throw new RuntimeException("re called with no arguments.");
        }

        if (args.size() == 1) {
            return ln(env, args.get(0));
        }

        List<Atom> list = new ArrayList<>(args.size());
        for (Atom x : args) {
            Atom ln = ln(env, x);
            list.add(ln);
        }
        return new Atom(list);
    }
}
