package palaiologos.kamilalisp.runtime.math;

import com.google.common.collect.Streams;
import palaiologos.kamilalisp.atom.*;

import java.util.List;

public class Or extends PrimitiveFunction implements Lambda {
    @Override
    protected String name() {
        return "or";
    }

    private static Atom min2(Environment e, Atom a, Atom b) {
        if(a.getType() == Type.LIST && b.getType() == Type.LIST) {
            return new Atom(Streams.zip(a.getList().stream(), b.getList().stream(), (x, y) -> min2(e, x, y)).toList());
        } else {
            return new Atom(a.coerceBool() || b.coerceBool());
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.isEmpty())
            throw new RuntimeException("or called with no arguments.");

        if(args.size() == 1 && args.get(0).getType() == Type.LIST) {
            List<Atom> data = args.get(0).getList();

            for(int i = 0; i < data.size() - 1; i++)
                if(min2(env, data.get(i), data.get(i + 1)).coerceBool())
                    return Atom.TRUE;
            return Atom.FALSE;
        }

        for(int i = 0; i < args.size() - 1; i++)
            if(min2(env, args.get(i), args.get(i + 1)).coerceBool())
                return Atom.TRUE;
        return Atom.FALSE;
    }
}
