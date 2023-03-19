package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.*;

import java.util.AbstractList;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Stream;

public class Cons extends PrimitiveFunction implements Lambda {
    private static final int CONS_FLATTENING_THRESHOLD = 16;

    public static List<Atom> doCons(Atom cell, List<Atom> list) {
        if(!(list instanceof ConsListFacade facade)) {
            return new ConsListFacade(list, cell, 0);
        } else {
            if(facade.getDepth() < CONS_FLATTENING_THRESHOLD) {
                return new ConsListFacade(list, cell, facade.getDepth() + 1);
            } else {
                List<Atom> result = new ArrayList<>(facade.depth + facade.list.size() + 1);
                result.add(cell);
                result.addAll(list);
                return result;
            }
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        if (args.get(1).getType() == Type.LIST) {
            List<Atom> orig = args.get(1).getList();
            return new Atom(doCons(args.get(0), orig));
        } else {
            return new Atom(List.of(args.get(0), args.get(1)));
        }
    }

    @Override
    protected String name() {
        return "cons";
    }

    private static class ConsListFacade extends AbstractList<Atom> {
        private final List<Atom> list;
        private final Atom cell;
        private final int depth;

        ConsListFacade(List<Atom> list, Atom cell, int depth) {
            this.list = list;
            this.cell = cell;
            this.depth = depth;
        }

        @Override
        public Atom get(int index) {
            return index == 0 ? cell : list.get(index - 1);
        }

        @Override
        public int size() {
            return 1 + list.size();
        }

        public int getDepth() {
            return depth;
        }
    }
}
