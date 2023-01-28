package palaiologos.kamilalisp.runtime.meta;

import palaiologos.kamilalisp.atom.*;

import java.util.List;

public class Raise extends PrimitiveFunction implements SpecialForm {

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        Atom arg = args.get(0);
        if (arg.getType() != Type.STRING)
            throw new RuntimeException("Expected string in `raise'.");
        throw new RaiseError(arg.getString());
    }

    @Override
    protected String name() {
        return "raise";
    }
}
