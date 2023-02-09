package palaiologos.kamilalisp.runtime.sh;

import palaiologos.kamilalisp.atom.*;

import java.util.List;

public abstract class ShellFunction extends PrimitiveFunction implements Lambda {
    protected abstract String command();

    protected abstract Atom execute(String flags, List<Atom> args);

    @Override
    protected String name() {
        return "sh:" + command();
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        String flags = "";
        if (args.size() >= 1 && args.get(0).getType() == Type.IDENTIFIER) {
            flags = args.get(0).getIdentifier();
            args = args.subList(1, args.size());
        }
        return execute(flags, args);
    }
}
