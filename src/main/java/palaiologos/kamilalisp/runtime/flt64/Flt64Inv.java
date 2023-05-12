package palaiologos.kamilalisp.runtime.flt64;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;
import palaiologos.kamilalisp.runtime.array.Rank;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Flt64Inv extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        Atom a1 = args.get(0);
        if (Rank.computeRank(a1) != 2) {
            throw new RuntimeException("Expected a matrix of rank 2.");
        }

        List<List<Atom>> l1 = new ArrayList<>();
        for (Atom atom : a1.getList()) {
            List<Atom> list = atom.getList();
            l1.add(list);
        }
        for (List<Atom> atoms : l1) {
            if (atoms.size() != l1.get(0).size()) {
                throw new RuntimeException("Expected a square matrix.");
            }
        }

        double[][] A = new double[l1.size()][l1.get(0).size()];
        for (int i = 0; i < l1.size(); i++) {
            for (int j = 0; j < l1.get(0).size(); j++) {
                A[i][j] = Flt64AtomThunk.toFloat(l1.get(i).get(j));
            }
        }

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
