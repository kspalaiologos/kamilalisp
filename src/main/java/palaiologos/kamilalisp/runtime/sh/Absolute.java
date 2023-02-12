package palaiologos.kamilalisp.runtime.sh;

import palaiologos.kamilalisp.atom.Atom;

import java.io.File;
import java.util.List;

public class Absolute extends ShellFunction {
    @Override
    protected String command() {
        return "absolute";
    }

    @Override
    protected Atom execute(String flags, List<Atom> args) {
        String p = args.get(0).toString();
        return new Atom(new File(p).getAbsolutePath());
    }
}
