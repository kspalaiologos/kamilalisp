package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.List;

public class In extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        Atom element = args.get(0);
        List<Atom> array = args.get(1).getList();
        return new Atom(array.contains(element));
    }

    @Override
    protected String name() {
        return "in?";
    }
}
