package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;

public class Union extends PrimitiveFunction implements Lambda {
    @Override
    public String name() {
        return "union";
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.isEmpty())
            return Atom.NULL;
        else if (args.get(0).getType() == Type.STRING) {
            LinkedHashSet<Character> set = new LinkedHashSet<>();
            for (Atom arg : args)
                for (char c : arg.getString().toCharArray())
                    set.add(c);
            StringBuilder sb = new StringBuilder();
            for (char c : set)
                sb.append(c);
            return new Atom(sb.toString());
        } else if (args.get(0).getType() == Type.LIST) {
            LinkedHashSet<Atom> set = new LinkedHashSet<>();
            for (Atom arg : args)
                set.addAll(arg.getList());
            return new Atom(new ArrayList<>(set));
        } else {
            throw new TypeError("union: invalid argument type, expected string or list.");
        }
    }
}
