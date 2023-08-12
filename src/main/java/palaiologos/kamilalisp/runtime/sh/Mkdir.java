package palaiologos.kamilalisp.runtime.sh;

import palaiologos.kamilalisp.atom.Atom;

import java.io.File;
import java.util.List;

public class Mkdir extends ShellFunction {
    @Override
    protected String command() {
        return "mkdir";
    }

    @Override
    protected Atom execute(String flags, List<Atom> args) {
        if (flags.contains("s")) {
            args.stream().map(Atom::getString).forEach(s -> {
                if (!Wd.relativeTo(s).mkdirs()) {
                    if (!flags.contains("f")) throw new RuntimeException("mkdir: failed to create directory '" + s + "'");
                }
            });
        } else {
            args.stream().map(Atom::getString).forEach(s -> {
                if (!Wd.relativeTo(s).mkdir()) {
                    if (!flags.contains("f")) throw new RuntimeException("mkdir: failed to create directory '" + s + "'");
                }
            });
        }
        return Atom.NULL;
    }
}
