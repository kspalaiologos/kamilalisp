package palaiologos.kamilalisp.runtime.cas;

import palaiologos.kamilalisp.atom.*;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

public class Fn extends PrimitiveFunction implements SpecialForm {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        Set<String> arguments;
        if(args.get(0).getType() == Type.LIST)
            arguments = args.get(0).getList().stream().map(Atom::getIdentifier).collect(Collectors.toSet());
        else if(args.get(0).getType() == Type.IDENTIFIER)
            arguments = Set.of(args.get(0).getIdentifier());
        else
            throw new RuntimeException("Invalid argument for cas:fn (expected list or identifier).");
        Atom body = args.get(1);
        return new Atom(new MathExpression(env, arguments, body));
    }

    @Override
    protected String name() {
        return "cas:fn";
    }
}
