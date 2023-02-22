package palaiologos.kamilalisp.runtime.sh;

import palaiologos.kamilalisp.atom.Atom;

import java.io.File;
import java.util.List;

public class Access extends ShellFunction {
    @Override
    protected String command() {
        return "access";
    }

    @Override
    protected Atom execute(String flags, List<Atom> args) {
        File f = new File(args.get(0).getString()).getAbsoluteFile();
        String sb = (f.exists() ? "e" : "-") +
                (f.canRead() ? "r" : "-") +
                (f.canWrite() ? "w" : "-") +
                (f.canExecute() ? "x" : "-");
        return new Atom(sb);
    }
}
