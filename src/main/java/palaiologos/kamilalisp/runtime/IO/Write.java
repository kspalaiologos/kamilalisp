package palaiologos.kamilalisp.runtime.IO;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.List;

public class Write extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        for (Atom arg : args) {
            System.out.print(arg.toDisplayString());
        }

        if (args.size() == 1)
            return args.get(0);
        else
            return new Atom(args);
    }

    @Override
    protected String name() {
        return "io:write";
    }
}
