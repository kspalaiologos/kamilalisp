package palaiologos.kamilalisp.runtime.flt64;

import ch.obermuhlner.math.big.BigComplex;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.runtime.array.Rank;

import java.math.BigDecimal;
import java.math.MathContext;
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
        if (l1.stream().anyMatch(x -> x.size() != l1.get(0).size())) {
            throw new RuntimeException("Expected a square matrix.");
        }

        double[][] A = l1.stream().map(x -> x.stream().mapToDouble(Flt64Base::toFlt64).toArray()).toArray(double[][]::new);
        double[][] L = new double[A.length][A.length];
        double[][] U = new double[A.length][A.length];
        realLU(A, L, U);
        return new Atom(List.of(
                new Atom(Arrays.stream(L).map(x -> new Atom(Arrays.stream(x).mapToObj(Flt64Base::toAtom).toList())).toList()),
                new Atom(Arrays.stream(U).map(x -> new Atom(Arrays.stream(x).mapToObj(Flt64Base::toAtom).toList())).toList())
        ));
    }

    @Override
    protected String name() {
        return "flt64:LU";
    }
}
