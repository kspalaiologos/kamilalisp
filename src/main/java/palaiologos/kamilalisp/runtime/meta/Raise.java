package palaiologos.kamilalisp.runtime.meta;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.RaiseError;

import java.util.List;

public class Raise extends PrimitiveFunction implements Lambda {

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.size() == 1) {
            Atom arg = args.get(0);
            if (arg.getType() != Type.STRING)
                throw new RuntimeException("Expected string in `raise'.");
            throw new RaiseError(Identifier.of("generic-error"), arg.getString());
        } else if(args.size() == 2) {
            Atom id = args.get(0);
            Atom message = args.get(1);
            if (id.getType() != Type.IDENTIFIER)
                throw new RuntimeException("Expected identifier as the first argument to `raise'.");
            if (message.getType() != Type.STRING)
                throw new RuntimeException("Expected string as the second argument to `raise'.");
            throw new RaiseError(id.getIdentifier(), message.getString());
        } else {
            throw new RuntimeException("Expected 1 or 2 arguments in `raise'.");
        }
    }

    @Override
    protected String name() {
        return "raise";
    }
}
