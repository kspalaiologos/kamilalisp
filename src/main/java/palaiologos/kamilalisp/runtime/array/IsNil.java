package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.util.List;

public class IsNil extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        if (args.get(0).getType() == Type.LIST)
            return args.get(0).getList().isEmpty() ? Atom.TRUE : Atom.FALSE;
        else if (args.get(0).getType() == Type.STRING)
            return args.get(0).getString().isEmpty() ? Atom.TRUE : Atom.FALSE;
        else
            throw new TypeError("empty?: invalid argument type, expected string or list.");
    }

    @Override
    protected String name() {
        return "empty?";
    }
}
