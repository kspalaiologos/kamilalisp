package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.*;

import java.util.ArrayList;
import java.util.List;

public class Slice extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 3);
        if(args.get(0).getType() == Type.LIST) {
            List<Atom> list = args.get(0).getList();
            int start = args.get(1).getInteger().intValueExact();
            int end = args.get(2).getInteger().intValueExact();
            if(start < 0)
                start = list.size() + start;
            if(end < 0)
                end = list.size() + end;
            return new Atom(new ArrayList<>(list.subList(start, end)));
        } else if(args.get(0).getType() == Type.STRING) {
            String string = args.get(0).getString();
            int start = args.get(1).getInteger().intValueExact();
            int end = args.get(2).getInteger().intValueExact();
            if(start < 0)
                start = string.length() + start;
            if(end < 0)
                end = string.length() + end;
            return new Atom(string.substring(start, end));
        } else {
            throw new RuntimeException("Invalid type. Expected string or list.");
        }
    }

    @Override
    protected String name() {
        return "slice";
    }
}
