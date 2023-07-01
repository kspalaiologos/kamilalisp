package palaiologos.kamilalisp.runtime.sh;

import palaiologos.kamilalisp.atom.Atom;

import java.io.File;
import java.util.List;
import java.io.IOException;

public class Cd extends ShellFunction {
    @Override
    protected String command() {
        return "cd";
    }

    @Override
    protected Atom execute(String flags, List<Atom> args) {
        assertArity(args, 1);
        String dir = args.get(0).getString();
        File dest = Wd.relativeTo(dir);
        if (!dest.exists())
            throw new RuntimeException("Directory " + dir + " does not exist");
        if (!dest.isDirectory())
            throw new RuntimeException(dir + " is not a directory");
        Wd.set(dest);
        return Atom.NULL;
    }
}
