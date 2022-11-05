package palaiologos.kamilalisp.atom;

import palaiologos.kamilalisp.error.TypeError;

import java.util.List;

public abstract class PrimitiveFunction implements Callable {
    @Override
    public int line() {
        return 0;
    }

    @Override
    public int column() {
        return 0;
    }

    protected void assertArity(List<Atom> args, int n) {
        if(args.size() != n) {
            throw new TypeError(n + " arguments expected in application.");
        }
    }

    @Override
    public String stringify() {
        return name();
    }

    @Override
    public String frameString() {
        return name() + " primitive function";
    }

    protected abstract String name();
}
