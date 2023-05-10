package palaiologos.kamilalisp.runtime.sh;

import palaiologos.kamilalisp.atom.*;

import java.util.List;

public class Getenv extends ShellFunction {
    @Override
    protected String command() {
        return "getenv";
    }

    @Override
    protected Atom execute(String flags, List<Atom> args) {
        assertArity(args, 1);
        String name = args.get(0).getString();
        return new Atom(System.getenv(name));
    }
}
