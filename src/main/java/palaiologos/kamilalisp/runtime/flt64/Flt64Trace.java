package palaiologos.kamilalisp.runtime.flt64;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;
import palaiologos.kamilalisp.runtime.array.Rank;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

public class Flt64Trace extends PrimitiveFunction implements Lambda {

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        Atom a1 = args.get(0);
        if (Rank.computeRank(a1) != 2) {
            throw new RuntimeException("Expected a matrix of rank 2.");
        }

        ArrayList<List<Atom>> l1 = new ArrayList<>();
        for (Atom atom : a1.getList()) {
            List<Atom> list = atom.getList();
            l1.add(list);
        }
        int diagonalLen = Math.min(l1.size(), l1.get(0).size());
        if (diagonalLen == 0)
            return new Atom(BigInteger.ZERO);
        double result = 0;
        for (int i = 0; i < diagonalLen; i++)
            result += Flt64AtomThunk.toFloat(l1.get(i).get(i));
        return Flt64AtomThunk.toAtom(result);
    }

    @Override
    protected String name() {
        return "flt64:trace";
    }
}
