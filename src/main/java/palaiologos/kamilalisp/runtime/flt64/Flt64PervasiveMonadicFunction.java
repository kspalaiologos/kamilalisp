package palaiologos.kamilalisp.runtime.flt64;

import palaiologos.kamilalisp.atom.*;

import java.util.ArrayList;
import java.util.List;

import static palaiologos.kamilalisp.runtime.flt64.Flt64AtomThunk.*;

public abstract class Flt64PervasiveMonadicFunction extends PrimitiveFunction implements Lambda {
    private String name;

    public Flt64PervasiveMonadicFunction(String name) {
        this.name = name;
    }

    public abstract double apply(double x);
    public double apply() {
        throw new RuntimeException("Expected at least one argument.");
    }

    private Atom process(Environment env, List<Atom> args) {
        ArrayList<Atom> list = new ArrayList<>(args.size());
        for(Atom x : args) {
            if(x.getType() == Type.LIST)
                list.add(process(env, x.getList()));
            else
                list.add(Flt64AtomThunk.toAtom(apply(toFloat(x))));
        }
        return new Atom(list);
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.size() == 0)
            return toAtom(apply());
        else if(args.size() == 1)
            return toAtom(apply(toFloat(args.get(0))));
        else return process(env, args);
    }

    @Override
    public String name() {
        return name;
    }
}
