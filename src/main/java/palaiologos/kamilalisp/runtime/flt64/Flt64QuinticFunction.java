package palaiologos.kamilalisp.runtime.flt64;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.List;

import static palaiologos.kamilalisp.runtime.flt64.Flt64AtomThunk.toAtom;
import static palaiologos.kamilalisp.runtime.flt64.Flt64AtomThunk.toFloat;

public abstract class Flt64QuinticFunction extends PrimitiveFunction implements Lambda {
    private String name;

    public Flt64QuinticFunction(String name) {
        this.name = name;
    }

    public abstract double apply(double u, double w, double x, double y, double z);

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() != 5)
            throw new IllegalArgumentException("Expected 5 arguments, got " + args.size());
        return toAtom(apply(toFloat(args.get(0)), toFloat(args.get(1)), toFloat(args.get(2)), toFloat(args.get(3)), toFloat(args.get(4))));
    }

    @Override
    public String name() {
        return name;
    }
}
