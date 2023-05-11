package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.*;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.stream.IntStream;

public class Find extends PrimitiveFunction implements Lambda {
    private static List<Atom> iotaUnderbar(int[] indices) {
        int max = 0;
        for (int index : indices)
            if (index > max)
                max = index;
        List<Atom> result = new ArrayList<>(max + 1);
        for(int i = 0; i <= max; i++)
            result.add(Atom.FALSE);
        for(int i : indices)
            result.set(i, Atom.TRUE);
        return result;
    }

    private static List<Atom> iotaUnderbar(List<Integer> indices) {
        int max = 0;
        for (Integer x : indices)
            if (x > max)
                max = x;
        List<Atom> result = new ArrayList<>(max + 1);
        for(int i = 0; i <= max; i++)
            result.add(Atom.FALSE);
        for(int i : indices)
            result.set(i, Atom.TRUE);
        return result;
    }

    private static Atom indexOf(Atom a, Atom b) {
        if (a.getType() == Type.STRING && b.getType() == Type.STRING) {
            int index = a.getString().indexOf(b.getString());
            List<Integer> indices = new ArrayList<>();
            while (index >= 0) {
                indices.add(index);
                index = a.getString().indexOf(b.getString(), index + 1);
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
            List<Atom> result = iotaUnderbar(IntStream.range(0, l1.size() - l2.size() + 1).filter(i -> l1.subList(i, i + l2.size()).equals(l2)).toArray());
            // Pad to length of a.
            for (int i = result.size(); i < l1.size(); i++) {
                result.add(Atom.FALSE);
            }
            return new Atom(result);
        } else if (a.getType() == Type.LIST) {
            List<Atom> l1 = a.getList();
            List<Atom> result = iotaUnderbar(IntStream.range(0, l1.size()).filter(i -> l1.get(i).equals(b)).toArray());
            // Pad to length of a.
            for (int i = result.size(); i < l1.size(); i++) {
                result.add(Atom.FALSE);
            }
            return new Atom(result);
        } else {
            throw new RuntimeException("find takes two strings, two lists, or a list and an atom.");
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
