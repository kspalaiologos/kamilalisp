package palaiologos.kamilalisp.runtime.meta;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.List;

public class Same extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() == 2) {
            return new Atom(args.get(0).equals(args.get(1)));
        } else if (args.size() > 2) {
            Atom first = args.get(0);
            for (int i = 1; i < args.size(); i++) {
                if (!first.equals(args.get(i))) {
                    return Atom.FALSE;
                }
            }
            return Atom.TRUE;
        } else {
            throw new IllegalArgumentException("`same' requires at least 2 arguments");
        }
    }

    @Override
    protected String name() {
        return "same";
    }
}
