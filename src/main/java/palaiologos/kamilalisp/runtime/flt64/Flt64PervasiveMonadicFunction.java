package palaiologos.kamilalisp.runtime.flt64;

import palaiologos.kamilalisp.atom.*;

import java.util.List;

import static palaiologos.kamilalisp.runtime.flt64.Flt64AtomThunk.*;

public abstract class Flt64PervasiveMonadicFunction extends PrimitiveFunction implements Lambda {
    private String name;

    public Flt64PervasiveMonadicFunction(String name) {
        this.name = name;
    }

    public abstract double apply(double x);

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        return new Atom(args.stream().map(x -> {
            if(x.getType() == Type.LIST)
                return apply(env, x.getList());
            return toAtom(apply(toFloat(x)));
        }).toList());
    }

    @Override
    public String name() {
        return name;
    }
}
