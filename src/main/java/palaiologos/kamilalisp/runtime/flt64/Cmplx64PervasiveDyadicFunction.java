package palaiologos.kamilalisp.runtime.flt64;

import palaiologos.kamilalisp.atom.*;
import rocks.palaiologos.maja.Complex;

import java.util.ArrayList;
import java.util.List;

import static palaiologos.kamilalisp.runtime.flt64.Cmplx64AtomThunk.toAtom;
import static palaiologos.kamilalisp.runtime.flt64.Cmplx64AtomThunk.toComplex;

public abstract class Cmplx64PervasiveDyadicFunction extends PrimitiveFunction implements Lambda {
    private String name;

    public Cmplx64PervasiveDyadicFunction(String name) {
        this.name = name;
    }

    public abstract Complex apply(Complex x, Complex y);

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() != 2)
            throw new IllegalArgumentException("Expected 2 arguments, got " + args.size());
        if (args.get(0).getType() == Type.LIST && args.get(1).getType() == Type.LIST) {
            List<Atom> result = new ArrayList<>();
            for(int i = 0; i < Math.min(args.get(0).getList().size(), args.get(1).getList().size()); i++) {
                Atom a = args.get(0).getList().get(i);
                Atom b = args.get(1).getList().get(i);
                result.add(apply(env, List.of(a, b)));
            }
            return new Atom(result);
        } else if(args.get(0).getType() == Type.LIST) {
            List<Atom> result = new ArrayList<>();
            for(int i = 0; i < args.get(0).getList().size(); i++) {
                Atom a = args.get(0).getList().get(i);
                result.add(apply(env, List.of(a, args.get(1))));
            }
            return new Atom(result);
        } else if(args.get(1).getType() == Type.LIST) {
            List<Atom> result = new ArrayList<>();
            for(int i = 0; i < args.get(1).getList().size(); i++) {
                Atom b = args.get(1).getList().get(i);
                result.add(apply(env, List.of(args.get(0), b)));
            }
            return new Atom(result);
        }
        return toAtom(apply(toComplex(args.get(0)), toComplex(args.get(1))));
    }

    @Override
    public String name() {
        return name;
    }
}
