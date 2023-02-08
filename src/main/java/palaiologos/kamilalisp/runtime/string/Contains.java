package palaiologos.kamilalisp.runtime.string;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.List;

public class Contains extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        String str = args.get(0).getString();
        String substr = args.get(1).getString();
        return str.contains(substr) ? Atom.TRUE : Atom.FALSE;
    }

    @Override
    protected String name() {
        return "str:contains";
    }
}
