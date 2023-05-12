package palaiologos.kamilalisp.runtime.flt64;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;
import palaiologos.kamilalisp.runtime.array.Rank;

import java.util.ArrayList;
import java.util.List;

public class Flt64Permanent extends PrimitiveFunction implements Lambda {
    public static double[][] minor(double[][] a, int x, int y) {
        int length = a.length - 1;
        double[][] result = new double[length][length];
        for (int i = 0; i < length; i++)
            for (int j = 0; j < length; j++) {
                if (i < x && j < y) {
                    result[i][j] = a[i][j];
                } else if (i >= x && j < y) {
                    result[i][j] = a[i + 1][j];
                } else if (i < x && j >= y) {
                    result[i][j] = a[i][j + 1];
                } else {
                    result[i][j] = a[i + 1][j + 1];
                }
            }
        return result;
    }

    public static double perm(double[][] a) {
        if (a.length == 1) {
            return a[0][0];
        } else {
            double sum = 0;
            for (int i = 0; i < a.length; i++) {
                sum += a[0][i] * perm(minor(a, 0, i));
            }
            return sum;
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
        for (List<Atom> x : l1) {
            if (x.size() != l1.get(0).size()) {
                throw new RuntimeException("Expected a square matrix.");
            }
        }

        double[][] A = new double[l1.size()][l1.get(0).size()];
        for (int i = 0; i < l1.size(); i++) {
            for (int j = 0; j < l1.get(0).size(); j++) {
                A[i][j] = Flt64AtomThunk.toFloat(l1.get(i).get(j));
            }
        }

        return Flt64AtomThunk.toAtom(perm(A));
    }

    @Override
    protected String name() {
        return "flt64:permanent";
    }
}
