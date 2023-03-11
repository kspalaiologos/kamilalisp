package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.*;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.IntStream;

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
            return new Atom(IntStream.range(0, l1.size() - l2.size() + 1)
                    .filter(i -> l1.subList(i, i + l2.size()).equals(l2))
                    .mapToObj(x -> new Atom(BigInteger.valueOf(x))).toList());
        } else if (a.getType() == Type.LIST) {
            List<Atom> l1 = a.getList();
            return new Atom(IntStream.range(0, l1.size()).filter(i -> l1.get(i).equals(b))
                    .mapToObj(x -> new Atom(BigInteger.valueOf(x))).toList());
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
