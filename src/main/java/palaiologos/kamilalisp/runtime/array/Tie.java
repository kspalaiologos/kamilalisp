package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.*;

import java.util.List;

public class Tie extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        return new Atom(args);
    }

    @Override
    protected String name() {
        return "tie";
    }
}
