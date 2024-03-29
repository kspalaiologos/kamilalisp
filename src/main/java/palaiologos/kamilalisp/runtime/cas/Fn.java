package palaiologos.kamilalisp.runtime.cas;

import palaiologos.kamilalisp.atom.*;

import java.util.LinkedHashSet;
import java.util.List;

public class Fn extends PrimitiveFunction implements SpecialForm {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        LinkedHashSet<String> arguments;
        if (args.get(0).getType() == Type.LIST) {
            arguments = new LinkedHashSet<>();
            for (Atom atom : args.get(0).getList()) {
                String identifier = atom.getIdentifier();
                arguments.add(identifier);
            }
        } else if (args.get(0).getType() == Type.IDENTIFIER) {
            arguments = new LinkedHashSet<>();
            arguments.add(args.get(0).getIdentifier());
        } else
            throw new RuntimeException("Invalid argument for cas:fn (expected list or identifier).");
        Atom body = args.get(1);
        return new Atom(new MathExpression(env, arguments, body));
    }

    @Override
    protected String name() {
        return "cas:fn";
    }
}
