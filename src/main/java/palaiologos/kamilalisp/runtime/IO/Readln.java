package palaiologos.kamilalisp.runtime.IO;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.List;

public class Readln extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        // Read line from standard input.
        String line = System.console().readLine();
        return new Atom(line);
    }

    @Override
    protected String name() {
        return "io:readln";
    }
}
