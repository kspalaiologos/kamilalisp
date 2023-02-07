package palaiologos.kamilalisp.runtime.meta;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.List;

public class Exit extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() == 1) {
            int code = args.get(0).getInteger().intValueExact();
            System.exit(code);
        } else {
            System.exit(0);
        }

        return Atom.NULL;
    }

    @Override
    protected String name() {
        return "exit";
    }
}
