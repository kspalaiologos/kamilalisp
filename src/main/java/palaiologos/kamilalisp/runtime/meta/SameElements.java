package palaiologos.kamilalisp.runtime.meta;

import palaiologos.kamilalisp.atom.*;

import java.util.List;

public class SameElements extends PrimitiveFunction implements Lambda {
    private static boolean cmpUnordered(Atom a1, Atom a2) {
        if (a1.getType() == Type.LIST && a2.getType() == Type.LIST) {
            List<Atom> l1 = a1.getList();
            List<Atom> l2 = a2.getList();
            if (l1.size() != l2.size()) {
                return false;
            }
            for (Atom a : l1) {
                if (!l2.contains(a)) {
                    return false;
                }
            }
            return true;
        } else {
            return a1.equals(a2);
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() == 2) {
            return new Atom(cmpUnordered(args.get(0), args.get(1)));
        } else if (args.size() > 2) {
            Atom first = args.get(0);
            for (int i = 1; i < args.size(); i++) {
                if (!cmpUnordered(first, args.get(i))) {
                    return Atom.FALSE;
                }
            }
            return Atom.TRUE;
        } else {
            throw new IllegalArgumentException("`same-elements' requires at least 2 arguments");
        }
    }

    @Override
    protected String name() {
        return "same-elements";
    }
}
