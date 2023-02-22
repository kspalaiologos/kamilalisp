package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.List;

public class Unique extends PrimitiveFunction implements Lambda {

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        if(args.get(0).getType() == Type.LIST) {
            List<Atom> list = args.get(0).getList();
            LinkedHashSet<Atom> set = new LinkedHashSet<>(list);
            return new Atom(new ArrayList<>(set));
        } else if(args.get(0).getType() == Type.STRING) {
            String str = args.get(0).getString();
            LinkedHashSet<Character> set = new LinkedHashSet<>();
            for (char c : str.toCharArray())
                set.add(c);
            StringBuilder sb = new StringBuilder();
            for (char c : set)
                sb.append(c);
            return new Atom(sb.toString());
        } else {
            throw new TypeError("unique: invalid argument type, expected string or list.");
        }
    }

    @Override
    protected String name() {
        return "unique";
    }
}
