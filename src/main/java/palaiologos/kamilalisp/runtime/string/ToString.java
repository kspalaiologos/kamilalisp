package palaiologos.kamilalisp.runtime.string;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;
import palaiologos.kamilalisp.error.TypeError;

import java.util.List;

public class ToString extends PrimitiveFunction implements Lambda {
    @Override
    protected String name() {
        return "to-string";
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() == 1) {
            return new Atom(args.get(0).toString());
        } else if (args.isEmpty()) {
            throw new TypeError("Expected 1 or more arguments to `to-string'.");
        } else {
            return new Atom(args.stream().map(Atom::toString).map(Atom::new).toList());
        }
    }
}
