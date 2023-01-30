package palaiologos.kamilalisp.runtime.string;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.List;
import java.util.stream.Collectors;

public class Implode extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        return new Atom(args.get(0).getList().stream().map(Atom::getString).collect(Collectors.joining()));
    }

    @Override
    protected String name() {
        return "str:implode";
    }
}
