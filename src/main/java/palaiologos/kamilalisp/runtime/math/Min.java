package palaiologos.kamilalisp.runtime.math;

import com.google.common.collect.Streams;
import palaiologos.kamilalisp.atom.*;

import java.util.List;

public class Min extends PrimitiveFunction implements Lambda {
    @Override
    protected String name() {
        return "min";
    }

    private static Atom min2(Environment e, Atom a, Atom b) {
        if(a.getType() == Type.LIST && b.getType() == Type.LIST) {
            return new Atom(Streams.zip(a.getList().stream(), b.getList().stream(), (x, y) -> min2(e, x, y)).toList());
        } else if(a.getType() == Type.REAL && b.getType() == Type.REAL) {
            return new Atom(a.getReal().min(b.getReal()));
        } else if(a.getType() == Type.LIST && b.getType() == Type.REAL) {
            return new Atom(a.getList().stream().map(x -> min2(e, x, b)).toList());
        } else if(a.getType() == Type.REAL && b.getType() == Type.LIST) {
            return new Atom(b.getList().stream().map(x -> min2(e, a, x)).toList());
        } else {
            throw new UnsupportedOperationException("min not defined for: " + a.getType() + " and " + b.getType());
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.isEmpty())
            throw new RuntimeException("min called with no arguments.");

        if(args.size() == 1)
            return args.get(0);

        return args.stream().reduce((a, b) -> min2(env, a, b)).get();
    }
}
