package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.*;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.IntStream;

public class Where extends PrimitiveFunction implements Lambda {
    private static boolean all(List<Atom> l, Type t) {
        for (Atom a : l)
            if (a.getType() != t)
                return false;
        return true;
    }

    private static Atom doWhere(List<Atom> inputList) {
        // Check if inputList is a scalar list.
        if (all(inputList, Type.INTEGER)) {
            List<Atom> indices = new ArrayList<>();
            for (int i = 0; i < inputList.size(); i++) {
                if (inputList.get(i).getInteger().compareTo(BigInteger.ZERO) > 0) {
                    int n = inputList.get(i).getInteger().intValueExact();
                    for (int j = 0; j < n; j++) {
                        indices.add(new Atom(BigInteger.valueOf(i)));
                    }
                }
            }
            return new Atom(indices);
        } else {
            // OK, we have a list of lists.
            List<Atom> wheres = new ArrayList<>();
            for (Atom atom : inputList) {
                Atom doWhere = doWhere(atom.getList());
                wheres.add(doWhere);
            }
            // "wheres" is a list of lists of scalar/list values.
            List<Atom> newData = IntStream.range(0, wheres.size()).mapToObj(i -> {
                BigInteger n = BigInteger.valueOf(i);
                ArrayList<List<Atom>> data = new ArrayList<>();
                for(Atom atom : wheres.get(i).getList()) {
                    if(atom.getType() == Type.INTEGER) {
                        ArrayList<Atom> list = new ArrayList<>();
                        list.add(new Atom(n));
                        list.add(atom);
                        data.add(list);
                    } else {
                        List<Atom> list = atom.getList();
                        list.add(0, new Atom(n));
                        data.add(list);
                    }
                }
                return data;
            }).flatMap(List::stream).map(Atom::new).toList();
            return new Atom(newData);
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        int rank = Rank.computeRank(args.get(0));
        if(rank < 1)
            throw new RuntimeException("Rank of input must be at least 1");
        List<Atom> inputList = args.get(0).getList();
        return doWhere(inputList);
    }

    @Override
    protected String name() {
        return "where";
    }
}
