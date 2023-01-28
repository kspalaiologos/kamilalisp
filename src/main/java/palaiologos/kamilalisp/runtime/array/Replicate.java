package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.*;

import java.math.BigInteger;
import java.util.AbstractList;
import java.util.ArrayList;
import java.util.List;

public class Replicate extends PrimitiveFunction implements Lambda {
    @Override
    protected String name() {
        return "replicate";
    }

    private static Atom replicate(List<Atom> l1, List<Atom> l2) {
        ArrayList<Atom> result = new ArrayList<>();

        if (l1.size() != l2.size()) {
            throw new RuntimeException("replicate: lists must be of equal length.");
        }

        for (int i = 0; i < l1.size(); i++) {
            Atom a1 = l1.get(i);
            Atom a2 = l2.get(i);
            if (a1.getType() == Type.INTEGER) {
                if (a1.getInteger().compareTo(BigInteger.ZERO) < 0)
                    throw new RuntimeException("replicate: negative count.");
                for (int j = 0; j < a1.getInteger().intValue(); j++)
                    result.add(a2);
            } else if (a1.getType() == Type.LIST && a2.getType() == Type.LIST) {
                result.add(replicate(a1.getList(), a2.getList()));
            } else if (a1.getType() == Type.LIST && a2.getType() == Type.STRING) {
                result.add(replicate(a1.getList(), a2.getString()));
            } else {
                throw new RuntimeException("replicate: invalid arguments.");
            }
        }

        return new Atom(result);
    }

    private static Atom replicate(List<Atom> s1, String s2) {
        StringBuilder result = new StringBuilder();
        if (s1.size() != s2.length())
            throw new RuntimeException("replicate: lists must be of equal length.");
        for (int i = 0; i < s1.size(); i++) {
            Atom a1 = s1.get(i);
            if (a1.getType() != Type.INTEGER || a1.getInteger().compareTo(BigInteger.ZERO) < 0)
                throw new RuntimeException("replicate: invalid arguments.");
            result.append(String.valueOf(s2.charAt(i)).repeat(Math.max(0, a1.getInteger().intValue())));
        }
        return new Atom(result.toString());
    }

    static class ReplicateListFacade extends AbstractList<Atom> {
        private final List<Atom> list;
        private final int len;

        public ReplicateListFacade(List<Atom> list, int len) {
            this.list = list;
            this.len = len;
        }

        @Override
        public Atom get(int index) {
            if (index >= len * list.size())
                throw new IndexOutOfBoundsException();
            return list.get(index % list.size());
        }

        @Override
        public int size() {
            return len * list.size();
        }
    }

    static class ReplicateListFacadeSingleton extends AbstractList<Atom> {
        private final Atom a;
        private final int len;

        public ReplicateListFacadeSingleton(Atom a, int len) {
            this.a = a;
            this.len = len;
        }

        @Override
        public Atom get(int index) {
            if (index >= len)
                throw new IndexOutOfBoundsException();
            return a;
        }

        @Override
        public int size() {
            return len;
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        if (args.get(0).getType() == Type.LIST && args.get(1).getType() == Type.LIST) {
            List<Atom> list1 = args.get(0).getList();
            List<Atom> list2 = args.get(1).getList();
            return replicate(list1, list2);
        } else if (args.get(0).getType() == Type.LIST && args.get(1).getType() == Type.STRING) {
            List<Atom> s1 = args.get(0).getList();
            String s2 = args.get(1).getString();
            return replicate(s1, s2);
        } else if(args.get(0).getType() == Type.INTEGER && args.get(1).getType() == Type.LIST) {
            List<Atom> list = args.get(1).getList();
            int n = args.get(0).getInteger().intValue();
            if(n < 0)
                throw new RuntimeException("replicate: negative count.");
            if(list.size() == 0)
                return Atom.NULL;
            return new Atom(new ReplicateListFacade(list, n));
        } else if(args.get(0).getType() == Type.INTEGER && args.get(1).getType() == Type.STRING) {
            String s = args.get(1).getString();
            int n = args.get(0).getInteger().intValue();
            if(n < 0)
                throw new RuntimeException("replicate: negative count.");
            return new Atom(s.repeat(n));
        } else if(args.get(0).getType() == Type.INTEGER) {
            Atom a = args.get(1);
            int n = args.get(0).getInteger().intValue();
            if(n < 0)
                throw new RuntimeException("replicate: negative count.");
            return new Atom(new ReplicateListFacadeSingleton(a, n));
        } else {
            throw new RuntimeException("replicate: invalid arguments.");
        }
    }
}
