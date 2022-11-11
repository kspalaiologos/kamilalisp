package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.*;

import java.util.List;
import java.util.stream.Stream;

public class Append extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        if (args.get(0).getType() == Type.STRING && args.get(1).getType() == Type.STRING) {
            return new Atom(args.get(0).getString() + args.get(1).getString());
        }

        Atom a1, a2;
        if (args.get(0).getType() == Type.LIST) {
            a1 = args.get(0);
        } else {
            a1 = new Atom(List.of(args.get(0)));
        }
        if (args.get(1).getType() == Type.LIST) {
            a2 = args.get(1);
        } else {
            a2 = new Atom(List.of(args.get(1)));
        }
        return new Atom(Stream.concat(a1.getList().stream(), a2.getList().stream()).toList());
    }

    @Override
    protected String name() {
        return "append";
    }
}
