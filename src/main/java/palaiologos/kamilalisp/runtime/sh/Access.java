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
        StringBuilder sb = new StringBuilder();
        sb.append(f.exists() ? "e" : "-");
        sb.append(f.canRead() ? "r" : "-");
        sb.append(f.canWrite() ? "w" : "-");
        sb.append(f.canExecute() ? "x" : "-");
        return new Atom(sb.toString());
    }
}
