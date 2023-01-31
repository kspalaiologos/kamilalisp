package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.*;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class Find extends PrimitiveFunction implements Lambda {
    private static List<Atom> iotaUnderbar(List<Integer> indices) {
        int max = indices.stream().max(Integer::compareTo).orElse(0);
        List<Atom> result = new ArrayList<>();
        for (int i = 0; i <= max; i++) {
            if (indices.contains(i)) {
                result.add(Atom.TRUE);
            } else {
                result.add(Atom.FALSE);
            }
        }
        return result;
    }

    private static Atom indexOf(Atom a, Atom b) {
        if (a.getType() == Type.STRING && b.getType() == Type.STRING) {
            int index = a.getString().indexOf(b.getString());
            List<Integer> indices = new ArrayList<>();
            while(index >= 0) {
                indices.add(index);
                index = a.getString().indexOf(b.getString(), index+1);
            }
            List<Atom> result = iotaUnderbar(indices);
            // Pad to length of a.
            for (int i = result.size(); i < a.getString().length(); i++) {
                result.add(Atom.FALSE);
            }
            return new Atom(result);
        } else if (a.getType() == Type.LIST && b.getType() == Type.LIST) {
            List<Atom> l1 = a.getList();
            List<Atom> l2 = b.getList();
            List<Integer> indices = new ArrayList<>();
            int index = Collections.indexOfSubList(l1, l2);
            while(index >= 0) {
                indices.add(index);
                l1 = l1.subList(index+1, l1.size());
                index = Collections.indexOfSubList(l1, l2);
            }
            List<Atom> result = iotaUnderbar(indices);
            // Pad to length of a.
            for (int i = result.size(); i < l1.size(); i++) {
                result.add(Atom.FALSE);
            }
            return new Atom(result);
        } else {
            throw new RuntimeException("find takes two strings or two lists.");
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        return indexOf(args.get(0), args.get(1));
    }

    @Override
    protected String name() {
        return "find";
    }
}
