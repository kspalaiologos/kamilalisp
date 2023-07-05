package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.*;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

public class IndexOf extends PrimitiveFunction implements Lambda {
    private static Atom indexOf(Atom a, Atom b) {
        if (a.getType() == Type.STRING && b.getType() == Type.STRING) {
            String haystack = b.getString();
            String needle = a.getString();
            int index = haystack.indexOf(needle);
            List<Atom> list = new ArrayList<>();
            while (index >= 0) {
                list.add(new Atom(BigInteger.valueOf(index)));
                index = haystack.indexOf(needle, index + 1);
            }
            return new Atom(list);
        } else if (b.getType() == Type.LIST) {
            List<Atom> haystack = b.getList();
            int index = haystack.indexOf(a);
            List<Atom> list = new ArrayList<>();
            while (index >= 0) {
                list.add(new Atom(BigInteger.valueOf(index)));
                index = haystack.subList(index + 1, haystack.size()).indexOf(a);
            }
            return new Atom(list);
        } else {
            throw new RuntimeException("index-of takes an atom and a list or two strings as arguments");
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        return indexOf(args.get(0), args.get(1));
    }

    @Override
    protected String name() {
        return "index-of";
    }
}
