package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.*;

import java.util.List;

public class StartsWith extends PrimitiveFunction implements Lambda {

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        if (args.get(0).getType() == Type.LIST && args.get(1).getType() == Type.LIST) {
            List<Atom> list = args.get(0).getList();
            List<Atom> prefix = args.get(1).getList();
            if (list.size() < prefix.size())
                return Atom.FALSE;
            for (int i = 0; i < prefix.size(); i++) {
                if (!list.get(i).equals(prefix.get(i)))
                    return Atom.FALSE;
            }
            return Atom.TRUE;
        } else if (args.get(0).getType() == Type.STRING && args.get(1).getType() == Type.STRING) {
            String x = args.get(0).getString();
            String prefix = args.get(1).getString();
            return new Atom(x.startsWith(prefix));
        } else {
            throw new RuntimeException("Invalid arguments");
        }
    }

    @Override
    protected String name() {
        return "starts-with";
    }
}
