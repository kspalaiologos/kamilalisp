package palaiologos.kamilalisp.runtime.flt64;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;
import palaiologos.kamilalisp.runtime.array.Rank;

import java.util.ArrayList;
import java.util.List;

public class Flt64Det extends PrimitiveFunction implements Lambda {
    public static double det(double[][] A) {
        if (A.length == 0)
            throw new RuntimeException("Empty matrix.");
        else if (A.length == 1)
            return A[0][0];
        else if (A.length == 2) {
            // 2x2 determinant.
            return A[0][0] * A[1][1] - A[0][1] * A[1][0];
        } else if (A.length == 3) {
            // 3x3 determinant.
            return
                    A[0][0] * A[1][1] * A[2][2] +
                            A[0][1] * A[1][2] * A[2][0] +
                            A[0][2] * A[1][0] * A[2][1] -
                            A[0][2] * A[1][1] * A[2][0] -
                            A[0][1] * A[1][0] * A[2][2] -
                            A[0][0] * A[1][2] * A[2][1]
                    ;
        } else {
            double[][][] lup;
            try {
                lup = Flt64PLU.lu(A);
            } catch (ArithmeticException e) {
                return 0;
            }

            double sumDiagP = 0;
            double prodL = 1, prodU = 1;
            for (int i = 0; i < lup[2].length; i++)
                sumDiagP += lup[2][i][i];
            for (int i = 0; i < lup[0].length; i++)
                prodL *= lup[0][i][i];
            for (int i = 0; i < lup[1].length; i++)
                prodU *= lup[1][i][i];

            double detp = (lup[2].length - sumDiagP - 1) % 2 == 0 ? 1 : -1;
            return detp * prodL * prodU;
        }
    }

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

        return Flt64AtomThunk.toAtom(det(A));
    }

    @Override
    protected String name() {
        return "flt64:det";
    }
}
