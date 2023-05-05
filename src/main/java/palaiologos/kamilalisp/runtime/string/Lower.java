package palaiologos.kamilalisp.runtime.string;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.List;

public class Lower extends PrimitiveFunction implements Lambda {

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        String s = args.get(0).getString();
        return new Atom(s.toLowerCase());
    }

    @Override
    protected String name() {
        return "str:lower";
    }
}
