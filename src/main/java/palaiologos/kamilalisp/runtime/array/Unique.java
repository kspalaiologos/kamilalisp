package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

public class Unique extends PrimitiveFunction implements Lambda {

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        List<Atom> list = args.get(0).getList();
        HashSet<Atom> set = new HashSet<>(list);
        return new Atom(new ArrayList<>(set));
    }

    @Override
    protected String name() {
        return "unique";
    }
}
