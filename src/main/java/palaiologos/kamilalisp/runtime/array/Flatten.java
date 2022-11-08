package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.*;

import java.util.ArrayList;
import java.util.List;

public class Flatten extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        args.get(0).assertTypes(Type.LIST);
        ArrayList<Atom> result = new ArrayList<>();
        for(Atom a : args.get(0).getList()) {
            if(a.getType() == Type.LIST)
                result.addAll(a.getList());
            else
                result.add(a);
        }
        return new Atom(result);
    }

    @Override
    protected String name() {
        return "flatten";
    }
}
