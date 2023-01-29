package palaiologos.kamilalisp.runtime.math;

import com.google.common.collect.Streams;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.ArrayError;

import java.util.List;

public class Max extends PrimitiveFunction implements Lambda {
    private static Atom max2(Environment e, Atom a, Atom b) {
        if (a.getType() == Type.LIST && b.getType() == Type.LIST) {
            return new Atom(Streams.zip(a.getList().stream(), b.getList().stream(), (x, y) -> max2(e, x, y)).toList());
        } else if (a.getType() == Type.REAL && b.getType() == Type.REAL) {
            return new Atom(a.getReal().max(b.getReal()));
        } else if (a.getType() == Type.INTEGER && b.getType() == Type.INTEGER) {
            return new Atom(a.getInteger().max(b.getInteger()));
        } else if (a.getType() == Type.INTEGER && b.getType() == Type.REAL) {
            return new Atom(a.getReal().max(b.getReal()));
        } else if (a.getType() == Type.REAL && b.getType() == Type.INTEGER) {
            return new Atom(a.getReal().max(b.getReal()));
        } else if (a.getType() == Type.LIST && b.getType() == Type.REAL) {
            return new Atom(a.getList().stream().map(x -> max2(e, x, b)).toList());
        } else if (a.getType() == Type.REAL && b.getType() == Type.LIST) {
            return new Atom(b.getList().stream().map(x -> max2(e, a, x)).toList());
        } else {
            throw new UnsupportedOperationException("max not defined for: " + a.getType() + " and " + b.getType());
        }
    }

    @Override
    protected String name() {
        return "max";
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() == 1 && args.get(0).getType() == Type.LIST)
            return args.get(0).getList().stream().reduce((a, b) -> max2(env, a, b)).orElseThrow(() -> new ArrayError("can't fold a list with max."));
        else if (args.size() <= 1)
            throw new RuntimeException("max called with too few arguments.");

        return args.stream().reduce((a, b) -> max2(env, a, b)).orElseThrow(() -> new ArrayError("can't fold a list with max."));
    }
}
