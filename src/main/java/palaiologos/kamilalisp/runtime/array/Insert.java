package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.ArrayList;
import java.util.List;

public class Insert extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 3);
        List<Atom> list = new ArrayList<>(args.get(0).getList());
        Atom a = args.get(1);
        int index = args.get(2).getInteger().intValueExact();
        list.add(index, a);
        return new Atom(list);
    }

    @Override
    protected String name() {
        return "insert";
    }
}
