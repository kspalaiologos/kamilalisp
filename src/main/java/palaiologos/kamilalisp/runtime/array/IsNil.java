package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.List;

public class IsNil extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        return args.get(0).equals(Atom.NULL) ? Atom.TRUE : Atom.FALSE;
    }

    @Override
    protected String name() {
        return "empty?";
    }
}
