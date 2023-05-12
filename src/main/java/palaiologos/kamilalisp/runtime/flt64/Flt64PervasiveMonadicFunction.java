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

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.size() == 0)
            return toAtom(apply());
        ArrayList<Atom> list = new ArrayList<>(args.size());
        for(Atom x : args) {
            if(x.getType() == Type.LIST)
                list.add(apply(env, x.getList()));
            else
                list.add(toAtom(apply(toFloat(x))));
        }
        return new Atom(list);
    }

    @Override
    public String name() {
        return name;
    }
}
