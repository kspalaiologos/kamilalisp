package palaiologos.kamilalisp.runtime.math;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;
import palaiologos.kamilalisp.error.TypeError;

import java.util.*;
import java.util.stream.Collectors;

public class Transpose extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() != 1)
            throw new TypeError("transpose takes exactly one argument");
        List<Atom> arg = args.get(0).getList();
        if (arg.isEmpty())
            return Atom.NULL;
        // Assert all members are of the same length:
        long count = 0L;
        Set<Integer> uniqueValues = new HashSet<>();
        for (Atom x : arg) {
            Integer size = x.getList().size();
            if (uniqueValues.add(size)) {
                count++;
            }
        }
        if (count != 1)
            throw new TypeError("transpose takes a matrix as argument");
        if (arg.get(0).getList().isEmpty())
            return args.get(0);
        return new Atom(new AbstractList<>() {
            @Override
            public int size() {
                return arg.get(0).getList().size();
            }

            @Override
            public Atom get(int index) {
                if (index < 0 || index >= size())
                    throw new IndexOutOfBoundsException();
                ArrayList<Atom> list = new ArrayList<>();
                for (Atom x : arg) {
                    Atom atom = x.getList().get(index);
                    list.add(atom);
                }
                return new Atom(list);
            }
        });
    }

    @Override
    protected String name() {
        return "transpose";
    }
}
