package palaiologos.kamilalisp.runtime.regex;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.Arrays;
import java.util.List;

public class RegexSplit extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        String regex = args.get(0).getString();
        String string = args.get(1).getString();
        return new Atom(Arrays.stream(string.split(regex)).map(Atom::new).toList());
    }

    @Override
    protected String name() {
        return "regex:split";
    }
}
