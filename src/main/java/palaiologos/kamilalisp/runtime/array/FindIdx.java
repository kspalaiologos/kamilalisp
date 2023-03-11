package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.*;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class FindIdx extends PrimitiveFunction implements Lambda {
    private static Atom indexOf(Atom a, Atom b) {
        if (a.getType() == Type.STRING && b.getType() == Type.STRING) {
            int index = a.getString().indexOf(b.getString());
            List<Atom> indices = new ArrayList<>();
            while (index >= 0) {
                indices.add(new Atom(BigInteger.valueOf(index)));
                index = a.getString().indexOf(b.getString(), index + 1);
            }
            return new Atom(indices);
        } else if (a.getType() == Type.LIST && b.getType() == Type.LIST) {
            List<Atom> l1 = a.getList();
            List<Atom> l2 = b.getList();
            List<Atom> indices = new ArrayList<>();
            int index = Collections.indexOfSubList(l1, l2);
            while (index >= 0) {
                indices.add(new Atom(BigInteger.valueOf(index)));
                l1 = l1.subList(index + 1, l1.size());
                index = Collections.indexOfSubList(l1, l2);
            }
            return new Atom(indices);
        } else if (a.getType() == Type.LIST) {
            List<Atom> l1 = a.getList();
            List<Atom> indices = new ArrayList<>();
            int index = l1.indexOf(b);
            while (index >= 0) {
                indices.add(new Atom(BigInteger.valueOf(index)));
                l1 = l1.subList(index + 1, l1.size());
                index = l1.indexOf(b);
            }
            return new Atom(indices);
        } else {
            throw new RuntimeException("find-idx takes two strings, two lists or a list and an atom.");
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        return indexOf(args.get(0), args.get(1));
    }

    @Override
    protected String name() {
        return "find-idx";
    }
}
