package palaiologos.kamilalisp.runtime.IO;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.List;

public class Writeln extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        for (Atom arg : args) {
            System.out.println(arg.toDisplayString());
        }

        return new Atom(args);
    }

    @Override
    protected String name() {
        return "writeln";
    }
}
