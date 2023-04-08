package palaiologos.kamilalisp.runtime.flt64;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;
import palaiologos.kamilalisp.runtime.array.Rank;

import java.util.Arrays;
import java.util.List;

public class Flt64Inv extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        Atom a1 = args.get(0);
        if (Rank.computeRank(a1) != 2) {
            throw new RuntimeException("Expected a matrix of rank 2.");
        }

        List<List<Atom>> l1 = a1.getList().stream().map(Atom::getList).toList();
        if (l1.stream().anyMatch(x -> x.size() != l1.get(0).size())) {
            throw new RuntimeException("Expected a square matrix.");
        }

        double[][] A = l1.stream().map(x -> x.stream().mapToDouble(Flt64AtomThunk::toFloat).toArray()).toArray(double[][]::new);

        double invdet = 1 / Flt64Det.det(A);
        for (int i = 0; i < A.length; i++) {
            for (int j = 0; j < A.length; j++) {
                A[i][j] *= invdet;
            }
        }

        return new Atom(Arrays.stream(A).map(x -> new Atom(Arrays.stream(x).mapToObj(Flt64AtomThunk::toAtom).toList())).toList());
    }

    @Override
    protected String name() {
        return "flt64:invert";
    }
}
