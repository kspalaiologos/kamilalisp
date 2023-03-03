package palaiologos.kamilalisp.runtime.meta;

import palaiologos.kamilalisp.atom.*;

import java.util.List;

public class MetaAtom extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        String name = args.get(0).getString();
        if(!Parser.isValidIdentifier(name))
            throw new RuntimeException("Invalid atom name: " + name);
        return new Atom(name, true);
    }

    @Override
    protected String name() {
        return "meta:atom";
    }
}
