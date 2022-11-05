package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.*;

import java.util.AbstractList;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class Cdr extends PrimitiveFunction implements Lambda {
    class CdrListFacade extends AbstractList<Atom> {
        private List<Atom> list;
        private int cdrOffset;

        public CdrListFacade(List<Atom> list, int cdrOffset) {
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

        @Override
        public void add(int index, Atom element) {
            list.add(index + cdrOffset, element);
        }

        @Override
        public Atom set(int index, Atom element) {
            return list.set(index + cdrOffset, element);
        }

        @Override
        public Atom remove(int index) {
            return list.remove(index + cdrOffset);
        }

        public List<Atom> cdr() {
            if(size() == 1)
                return List.of();
            if(cdrOffset <= 16) {
                return new CdrListFacade(list, cdrOffset + 1);
            } else {
                return new CdrListFacade(list.stream().skip(cdrOffset).toList(), 1);
            }
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.isEmpty()) {
            throw new RuntimeException("Expected one or more arguments to `cdr'.");
        }

        if(args.size() == 1) {
            args.get(0).assertTypes(Type.LIST);
            if(args.get(0).getList().isEmpty())
                return Atom.NULL;
            if(args.get(0).getList() instanceof CdrListFacade) {
                return new Atom(((CdrListFacade) args.get(0).getList()).cdr());
            } else {
                return new Atom(new CdrListFacade(args.get(0).getList(), 1));
            }
        } else {
            args.forEach(a -> a.assertTypes(Type.LIST));
            return new Atom(args.stream().map(Atom::getList).map(l -> {
                if(l.isEmpty())
                    return Atom.NULL;
                if(l instanceof CdrListFacade) {
                    return new Atom(((CdrListFacade) l).cdr());
                } else {
                    return new Atom(new CdrListFacade(l, 1));
                }
            }).collect(Collectors.toList()));
        }
    }

    @Override
    protected String name() {
        return "cdr";
    }
}
