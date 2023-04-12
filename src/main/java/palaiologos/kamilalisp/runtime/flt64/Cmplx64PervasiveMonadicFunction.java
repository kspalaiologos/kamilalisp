package palaiologos.kamilalisp.runtime.flt64;

import palaiologos.kamilalisp.atom.*;
import rocks.palaiologos.maja.Complex;

import java.util.List;

import static palaiologos.kamilalisp.runtime.flt64.Cmplx64AtomThunk.toAtom;
import static palaiologos.kamilalisp.runtime.flt64.Cmplx64AtomThunk.toComplex;

public abstract class Cmplx64PervasiveMonadicFunction extends PrimitiveFunction implements Lambda {
    private String name;

    public Cmplx64PervasiveMonadicFunction(String name) {
        this.name = name;
    }

    public abstract Complex apply(Complex x);
    public Complex apply() {
        throw new RuntimeException("Expected at least one argument.");
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.size() == 0)
            return toAtom(apply());
        return new Atom(args.stream().map(x -> {
            if(x.getType() == Type.LIST)
                return apply(env, x.getList());
            return toAtom(apply(toComplex(x)));
        }).toList());
    }

    @Override
    public String name() {
        return name;
    }
}
