package palaiologos.kamilalisp.runtime.array;

import com.google.common.collect.Streams;
import palaiologos.kamilalisp.atom.*;

import java.util.AbstractList;
import java.util.List;

public class Cycle extends PrimitiveFunction implements Lambda {
    @Override
    protected String name() {
        return "cycle";
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

    private static Atom cycle(Atom a, Atom b) {
        if (a.getType() == Type.INTEGER && b.getType() == Type.LIST) {
            if (a.getInteger().intValueExact() < 0)
                throw new RuntimeException("cycle: negative length");
            if(b.getList().size() == 0)
                return Atom.NULL;
            return new Atom(new CycleListFacade(b.getList(), a.getInteger().intValueExact()));
        } else if (a.getType() == Type.LIST && b.getType() == Type.LIST) {
            return new Atom(Streams.zip(a.getList().stream(), b.getList().stream(), Cycle::cycle).toList());
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
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        return cycle(args.get(0), args.get(1));
    }
}
