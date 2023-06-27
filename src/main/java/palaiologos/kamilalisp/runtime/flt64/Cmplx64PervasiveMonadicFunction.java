package palaiologos.kamilalisp.runtime.flt64;

import palaiologos.kamilalisp.atom.*;
import rocks.palaiologos.maja.Complex;

import java.util.ArrayList;
import java.util.List;

import static palaiologos.kamilalisp.runtime.flt64.Cmplx64AtomThunk.toAtom;
import static palaiologos.kamilalisp.runtime.flt64.Cmplx64AtomThunk.toComplex;
import static palaiologos.kamilalisp.runtime.flt64.Flt64AtomThunk.toFloat;

public abstract class Cmplx64PervasiveMonadicFunction extends PrimitiveFunction implements Lambda {
    private String name;

    public Cmplx64PervasiveMonadicFunction(String name) {
        this.name = name;
    }

    public abstract Complex apply(Complex x);
    public Complex apply() {
        throw new RuntimeException("Expected at least one argument.");
    }

    private Atom process(Environment env, List<Atom> args) {
        ArrayList<Atom> list = new ArrayList<>(args.size());
        for(Atom x : args) {
            if(x.getType() == Type.LIST)
                list.add(process(env, x.getList()));
            else
                list.add(Cmplx64AtomThunk.toAtom(apply(toComplex(x))));
        }
        return new Atom(list);
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.size() == 0)
            return toAtom(apply());
        else if(args.size() == 1)
            return toAtom(apply(toComplex(args.get(0))));
        else return process(env, args);
    }

    @Override
    public String name() {
        return name;
    }
}
