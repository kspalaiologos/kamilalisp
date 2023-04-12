package palaiologos.kamilalisp.runtime.flt64;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;
import rocks.palaiologos.maja.Complex;

import java.util.List;

import static palaiologos.kamilalisp.runtime.flt64.Cmplx64AtomThunk.toAtom;
import static palaiologos.kamilalisp.runtime.flt64.Cmplx64AtomThunk.toComplex;

public abstract class Cmplx64TriadicFunction extends PrimitiveFunction implements Lambda {
    private String name;

    public Cmplx64TriadicFunction(String name) {
        this.name = name;
    }

    public abstract Complex apply(Complex x, Complex y, Complex z);

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() != 3)
            throw new IllegalArgumentException("Expected 3 arguments, got " + args.size());
        return toAtom(apply(toComplex(args.get(0)), toComplex(args.get(1)), toComplex(args.get(2))));
    }

    @Override
    public String name() {
        return name;
    }
}
