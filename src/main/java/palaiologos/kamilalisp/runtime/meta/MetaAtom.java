package palaiologos.kamilalisp.runtime.meta;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.List;

public class MetaAtom extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        String name = args.get(0).getString();
        return new Atom(name, true);
    }

    @Override
    protected String name() {
        return "meta:atom";
    }
}
