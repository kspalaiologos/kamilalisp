package palaiologos.kamilalisp.runtime.array.carcdr;

import palaiologos.kamilalisp.atom.*;

import java.util.AbstractList;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class Cdr extends PrimitiveFunction implements Lambda {
    private static final int CDR_FLATTENING_THRESHOLD = 16;

    public static Cdr INSTANCE = new Cdr();

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.isEmpty()) {
            throw new RuntimeException("Expected one or more arguments to `cdr'.");
        }

        if (args.size() == 1) {
            if (args.get(0).getType() == Type.STRING) {
                if (args.get(0).getString().isEmpty())
                    return new Atom("");
                return new Atom(args.get(0).getString().substring(1));
            }

            if (args.get(0).getList().isEmpty())
                return Atom.NULL;
            if (args.get(0).getList() instanceof CdrListFacade) {
                return new Atom(((CdrListFacade) args.get(0).getList()).cdr());
            } else {
                return new Atom(new CdrListFacade(args.get(0).getList(), 1));
            }
        } else {
            ArrayList<Atom> result = new ArrayList<>();
            for(Atom a : args) {
                if (a.getType() == Type.STRING) {
                    return new Atom(a.getString().substring(1));
                }

                List<Atom> l = a.getList();
                if (l.isEmpty())
                    result.add(Atom.NULL);
                if (l instanceof CdrListFacade) {
                    result.add(new Atom(((CdrListFacade) l).cdr()));
                } else {
                    result.add(new Atom(new CdrListFacade(l, 1)));
                }
            }
            return new Atom(result);
        }
    }

    @Override
    protected String name() {
        return "cdr";
    }

    static class CdrListFacade extends AbstractList<Atom> {
        private final List<Atom> list;
        private final int cdrOffset;

        CdrListFacade(List<Atom> list, int cdrOffset) {
            this.list = list;
            this.cdrOffset = cdrOffset;
        }

        @Override
        public Atom get(int index) {
            return list.get(index + cdrOffset);
        }

        @Override
        public int size() {
            return list.size() - cdrOffset;
        }

        List<Atom> cdr() {
            if (size() <= 1)
                return List.of();
            if (cdrOffset <= CDR_FLATTENING_THRESHOLD) {
                return new CdrListFacade(list, cdrOffset + 1);
            } else {
                return new CdrListFacade(list.subList(cdrOffset, list.size()), 1);
            }
        }
    }
}
