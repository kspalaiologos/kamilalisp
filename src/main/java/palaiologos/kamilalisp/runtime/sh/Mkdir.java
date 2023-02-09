package palaiologos.kamilalisp.runtime.sh;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.io.File;
import java.util.List;

public class Mkdir extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        args.stream().map(Atom::getString).forEach(x -> {
            File file = new File(x);
            if (!file.exists()) {
                if(!file.mkdir()) {
                    throw new RuntimeException("mkdir: failed to create directory: " + x);
                }
            }
        });
        return Atom.NULL;
    }

    @Override
    protected String name() {
        return "sh:mkdir";
    }
}
