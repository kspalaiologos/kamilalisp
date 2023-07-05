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
        } else if (a.getType() == Type.LIST && b.getType() == Type.LIST) {
            List<Atom> haystack = b.getList();
            List<Atom> needle = a.getList();
            // Find instances of needle in haystack using a sliding window.
            List<Atom> instances = new ArrayList<>();
            for (int i = 0; i < haystack.size() - needle.size() + 1; i++) {
                boolean found = true;
                for (int j = 0; j < needle.size(); j++) {
                    if (!haystack.get(i + j).equals(needle.get(j))) {
                        found = false;
                        break;
                    }
                }
                if (found) {
                    instances.add(new Atom(BigInteger.valueOf(i)));
                }
            }
            return new Atom(instances);
        } else {
            throw new RuntimeException("index-of takes two lists or two strings as arguments");
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
