package palaiologos.kamilalisp.runtime.array;

import com.google.common.collect.Streams;
import palaiologos.kamilalisp.atom.*;

import java.util.AbstractList;
import java.util.ArrayList;
import java.util.List;

public class Cycle extends PrimitiveFunction implements Lambda {
    private static Atom cycle(Atom a, Atom b) {
        if (a.getType() == Type.INTEGER && b.getType() == Type.LIST) {
            if (a.getInteger().intValueExact() < 0)
                throw new RuntimeException("cycle: negative length");
            if (b.getList().isEmpty())
                return Atom.NULL;
            return new Atom(new CycleListFacade(b.getList(), a.getInteger().intValueExact()));
        } else if (a.getType() == Type.LIST && b.getType() == Type.LIST) {
            // Zip a and b and call cycle.
            ArrayList<Atom> result = new ArrayList<>();
            int len = Math.min(a.getList().size(), b.getList().size());
            for (int i = 0; i < len; i++) {
                result.add(cycle(a.getList().get(i), b.getList().get(i)));
            }
            return new Atom(result);
        } else if (a.getType() == Type.INTEGER && b.getType() == Type.STRING) {
            if (a.getInteger().intValueExact() < 0)
                throw new RuntimeException("cycle: negative length");
            StringBuilder result = new StringBuilder();
            int times = a.getInteger().intValueExact() / b.getString().length();
            for (int i = 0; i < times; i++)
                result.append(b.getString());
            result.append(b.getString(), 0, a.getInteger().intValueExact() % b.getString().length());
            return new Atom(result.toString());
        } else {
            throw new UnsupportedOperationException("cycle not defined for: " + a.getType() + " and " + b.getType());
        }
    }

    @Override
    protected String name() {
        return "cycle";
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        return cycle(args.get(0), args.get(1));
    }

    static class CycleListFacade extends AbstractList<Atom> {
        private final List<Atom> list;
        private final int len;

        public CycleListFacade(List<Atom> list, int len) {
            this.list = list;
            this.len = len;
        }

        @Override
        public Atom get(int index) {
            if (index >= len)
                throw new IndexOutOfBoundsException();
            return list.get(index % list.size());
        }

        @Override
        public int size() {
            return len;
        }
    }
}
