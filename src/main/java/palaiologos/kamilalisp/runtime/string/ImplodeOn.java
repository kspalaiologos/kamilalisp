package palaiologos.kamilalisp.runtime.string;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.List;
import java.util.stream.Collectors;

public class ImplodeOn extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        String glue = args.get(0).getString();
        return new Atom(args.get(1).getList().stream().map(Atom::getString).collect(Collectors.joining(glue)));
    }

    @Override
    protected String name() {
        return "str:implode-on";
    }
}
