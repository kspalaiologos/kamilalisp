package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.*;

import java.util.List;
import java.util.stream.Stream;

public class Cons extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        if (args.get(1).getType() == Type.LIST) {
            return new Atom(Stream.concat(Stream.of(args.get(0)), args.get(1).getList().stream()).toList());
        } else {
            return new Atom(List.of(args.get(0), args.get(1)));
        }
    }

    @Override
    protected String name() {
        return "cons";
    }
}
