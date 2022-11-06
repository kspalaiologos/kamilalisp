package palaiologos.kamilalisp.runtime.math.cmp;

import com.google.common.collect.Streams;
import palaiologos.kamilalisp.atom.*;

import java.util.List;

public class Lt extends PrimitiveFunction implements Lambda {
    private static String name = "<";

    @Override
    protected String name() {
        return name;
    }

    private static Atom cmp2(Environment e, Atom a, Atom b) {
        if(a.getType() == Type.LIST && b.getType() == Type.LIST) {
            return new Atom(Streams.zip(a.getList().stream(), b.getList().stream(), (x, y) -> cmp2(e, x, y)).toList());
        } else if(a.getType() == Type.REAL && b.getType() == Type.REAL) {
            return new Atom(a.getReal().compareTo(b.getReal()) < 0);
        } else if(a.getType() == Type.STRING && b.getType() == Type.STRING) {
            return new Atom(a.getString().compareTo(b.getString()) < 0);
        } else if(a.getType() == Type.LIST && b.getType() == Type.REAL) {
            return new Atom(a.getList().stream().allMatch(x -> cmp2(e, x, b).coerceBool()));
        } else if(a.getType() == Type.REAL && b.getType() == Type.LIST) {
            return new Atom(b.getList().stream().allMatch(x -> cmp2(e, a, x).coerceBool()));
        } else {
            throw new UnsupportedOperationException(name + " not defined for: " + a.getType() + " and " + b.getType());
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.isEmpty())
            throw new RuntimeException(name + " called with no arguments.");

        if(args.size() == 1 && args.get(0).getType() == Type.LIST) {
            List<Atom> data = args.get(0).getList();

            for(int i = 0; i < data.size() - 1; i++)
                if(!cmp2(env, data.get(i), data.get(i + 1)).coerceBool())
                    return Atom.FALSE;
            return Atom.TRUE;
        }

        for(int i = 0; i < args.size() - 1; i++)
            if(!cmp2(env, args.get(i), args.get(i + 1)).coerceBool())
                return Atom.FALSE;
        return Atom.TRUE;
    }
}
