package palaiologos.kamilalisp.runtime.math.num;

import ch.obermuhlner.math.big.BigComplex;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;
import palaiologos.kamilalisp.runtime.array.Rank;

import java.math.BigInteger;
import java.util.List;

public class Trace extends PrimitiveFunction implements Lambda {

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        Atom a1 = args.get(0);
        if (Rank.computeRank(a1) != 2) {
            throw new RuntimeException("Expected a matrix of rank 2.");
        }

        List<List<Atom>> l1 = a1.getList().stream().map(Atom::getList).toList();
        int diagonalLen = Math.min(l1.size(), l1.get(0).size());
        if (diagonalLen == 0)
            return new Atom(BigInteger.ZERO);
        BigComplex result = BigComplex.ZERO;
        for (int i = 0; i < diagonalLen; i++) {
            result = result.add(l1.get(i).get(i).getComplex());
        }
        return new Atom(result);
    }

    @Override
    protected String name() {
        return "num:trace";
    }
}
