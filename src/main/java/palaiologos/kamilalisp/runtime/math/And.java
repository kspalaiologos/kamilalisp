package palaiologos.kamilalisp.runtime.math;

import com.google.common.collect.Streams;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.util.List;

public class And extends PrimitiveFunction implements Lambda {
    private static Atom and2(Atom a, Atom b) {
        if (a.getType() == Type.LIST && b.getType() == Type.LIST) {
            return new Atom(Streams.zip(a.getList().stream(), b.getList().stream(), And::and2).toList());
        } else {
            return new Atom(a.coerceBool() && b.coerceBool());
        }
    }

    @Override
    protected String name() {
        return "and";
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() == 2) {
            return and2(args.get(0), args.get(1));
        } else if (args.size() <= 1) {
            throw new TypeError("Expected 2 or more arguments to `and'.");
        } else {
            return args.stream().reduce(And::and2).get();
        }
    }
}
