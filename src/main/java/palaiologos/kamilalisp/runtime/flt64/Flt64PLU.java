package palaiologos.kamilalisp.runtime.flt64;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;
import palaiologos.kamilalisp.runtime.array.Rank;

import java.util.Arrays;
import java.util.List;
import java.util.stream.IntStream;

public class Flt64PLU extends PrimitiveFunction implements Lambda {
    static double dotProduct(double[] a, double[] b) {
        return IntStream.range(0, a.length).mapToDouble(i -> a[i] * b[i]).sum();
    }

    static double[][] matrixMul(double[][] A, double[][] B) {
        double[][] result = new double[A.length][B[0].length];
        double[] aux = new double[B.length];

        for (int j = 0; j < B[0].length; j++) {

            for (int k = 0; k < B.length; k++)
                aux[k] = B[k][j];

            for (int i = 0; i < A.length; i++)
                result[i][j] = dotProduct(A[i], aux);
        }
        return result;
    }

    static double[][] pivotize(double[][] m) {
        int n = m.length;
        double[][] id = IntStream.range(0, n).mapToObj(j -> IntStream.range(0, n)
                        .mapToDouble(i -> i == j ? 1 : 0).toArray())
                .toArray(double[][]::new);

        for (int i = 0; i < n; i++) {
            double maxm = m[i][i];
            int row = i;
            for (int j = i; j < n; j++)
                if (m[j][i] > maxm) {
                    maxm = m[j][i];
                    row = j;
                }

            if (i != row) {
                double[] tmp = id[i];
                id[i] = id[row];
                id[row] = tmp;
            }
        }
        return id;
    }

    static double[][][] lu(double[][] A) {
        int n = A.length;
        double[][] L = new double[n][n];
        double[][] U = new double[n][n];
        double[][] P = pivotize(A);
        double[][] A2 = matrixMul(P, A);

        for (int j = 0; j < n; j++) {
            L[j][j] = 1;
            for (int i = 0; i < j + 1; i++) {
                double s1 = 0;
                for (int k = 0; k < i; k++)
                    s1 += U[k][j] * L[i][k];
                U[i][j] = A2[i][j] - s1;
            }
            for (int i = j; i < n; i++) {
                double s2 = 0;
                for (int k = 0; k < j; k++)
                    s2 += U[k][j] * L[i][k];
                L[i][j] = (A2[i][j] - s2) / U[j][j];
            }
        }

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (Double.isNaN(L[i][j]) || Double.isNaN(P[i][j]) || Double.isNaN(U[i][j])) {
                    throw new ArithmeticException("Singular matrix.");
                }
            }
        }

        return new double[][][]{L, U, P};
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

        double[][] A = l1.stream().map(x -> x.stream().mapToDouble(Flt64AtomThunk::toFloat).toArray()).toArray(double[][]::new);
        double[][][] data = lu(A);
        return new Atom(List.of(
                new Atom(Arrays.stream(data[0]).map(x -> new Atom(Arrays.stream(x).mapToObj(Flt64AtomThunk::toAtom).toList())).toList()),
                new Atom(Arrays.stream(data[1]).map(x -> new Atom(Arrays.stream(x).mapToObj(Flt64AtomThunk::toAtom).toList())).toList()),
                new Atom(Arrays.stream(data[2]).map(x -> new Atom(Arrays.stream(x).mapToObj(Flt64AtomThunk::toAtom).toList())).toList())
        ));
    }

    @Override
    protected String name() {
        return "flt64:PLU";
    }
}
