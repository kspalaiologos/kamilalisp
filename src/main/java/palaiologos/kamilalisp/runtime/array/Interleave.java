package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.*;

import java.util.ArrayList;
import java.util.List;

public class Interleave extends PrimitiveFunction implements Lambda {
    @Override
    public String name() {
        return "interleave";
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() > 0) {
            int len = args.stream().map(Atom::getList).mapToInt(List::size).max().orElse(0);
            List<Atom> result = new ArrayList<>();
            for (int i = 0; i < len; i++)
                for (Atom a : args)
                    if (a.getType() != Type.LIST)
                        result.add(a);
                    else if (a.getType() == Type.LIST && i < a.getList().size())
                        result.add(a.getList().get(i));
            return new Atom(result);
        } else {
            return Atom.NULL;
        }
    }
}
