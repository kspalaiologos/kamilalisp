package palaiologos.kamilalisp.runtime.flt64;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;
import palaiologos.kamilalisp.runtime.array.Rank;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Flt64LU extends PrimitiveFunction implements Lambda {
    private static void realLU(double[][] A, double[][] lower, double[][] upper) {
        for (int i = 0; i < A.length; i++) {
            for (int k = i; k < A.length; k++) {
                double sum = 0;

                for (int j = 0; j < i; j++)
                    sum += lower[i][j] * upper[j][k];

                upper[i][k] = A[i][k] - sum;
            }

            // Lower Triangular
            for (int k = i; k < A.length; k++) {
                if (i == k)
                    lower[i][i] = 1;
                else {
                    double sum = 0;
                    for (int j = 0; j < i; j++)
                        sum += lower[k][j] * upper[j][i];

                    lower[k][i] = A[k][i] * sum / upper[i][i];
                }
            }
        }

        // check if lower/upper contains NaN
        for (int i = 0; i < A.length; i++) {
            for (int j = 0; j < A.length; j++) {
                if (Double.isNaN(lower[i][j]) || Double.isNaN(upper[i][j])) {
                    throw new ArithmeticException("Singular matrix.");
                }
            }
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        Atom a1 = args.get(0);
        if (Rank.computeRank(a1) != 2) {
            throw new RuntimeException("Expected a matrix of rank 2.");
        }

        List<List<Atom>> l1 = a1.getList().stream().map(Atom::getList).toList();
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
        double[][] L = new double[A.length][A.length];
        double[][] U = new double[A.length][A.length];
        realLU(A, L, U);
        ArrayList<Atom> a = new ArrayList<>();
        for (double[] doubles : L) {
            ArrayList<Atom> list = new ArrayList<>();
            for (double v : doubles) {
                Atom toAtom = Flt64AtomThunk.toAtom(v);
                list.add(toAtom);
            }
            Atom atom = new Atom(list);
            a.add(atom);
        }
        ArrayList<Atom> b = new ArrayList<>();
        for (double[] x : U) {
            ArrayList<Atom> list = new ArrayList<>();
            for (double v : x) {
                Atom toAtom = Flt64AtomThunk.toAtom(v);
                list.add(toAtom);
            }
            Atom atom = new Atom(list);
            b.add(atom);
        }
        return new Atom(List.of(
                new Atom(a),
                new Atom(b)
        ));
    }

    @Override
    protected String name() {
        return "flt64:LU";
    }
}
