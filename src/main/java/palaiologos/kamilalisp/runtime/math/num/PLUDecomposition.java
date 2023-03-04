package palaiologos.kamilalisp.runtime.math.num;

import ch.obermuhlner.math.big.BigComplex;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.runtime.array.Rank;

import java.math.BigDecimal;
import java.math.MathContext;
import java.math.RoundingMode;
import java.util.Arrays;
import java.util.List;
import java.util.stream.IntStream;

public class PLUDecomposition extends PrimitiveFunction implements Lambda {
    // Real case
    static BigDecimal dotProduct(BigDecimal[] a, BigDecimal[] b) {
        return IntStream.range(0, a.length).mapToObj(i -> a[i].multiply(b[i])).reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    static BigDecimal[][] matrixMul(BigDecimal[][] A, BigDecimal[][] B) {
        BigDecimal[][] result = new BigDecimal[A.length][B[0].length];
        for(int i = 0; i < A.length; i++) {
            Arrays.fill(result[i], BigDecimal.ZERO);
        }
        BigDecimal[] aux = new BigDecimal[B.length];
        for(int i = 0; i < B.length; i++) {
            Arrays.fill(aux, BigDecimal.ZERO);
        }

        for (int j = 0; j < B[0].length; j++) {

            for (int k = 0; k < B.length; k++)
                aux[k] = B[k][j];

            for (int i = 0; i < A.length; i++)
                result[i][j] = dotProduct(A[i], aux);
        }
        return result;
    }

    static BigDecimal[][] pivotize(BigDecimal[][] m) {
        int n = m.length;
        BigDecimal[][] id =
                IntStream.range(0, n).mapToObj(j ->
                        IntStream.range(0, n).mapToObj(i ->
                                i == j ? BigDecimal.ONE : BigDecimal.ZERO
                        ).toArray(BigDecimal[]::new)).toArray(BigDecimal[][]::new);

        for (int i = 0; i < n; i++) {
            BigDecimal maxm = m[i][i];
            int row = i;
            for (int j = i; j < n; j++)
                if (m[j][i].compareTo(maxm) > 0) {
                    maxm = m[j][i];
                    row = j;
                }

            if (i != row) {
                BigDecimal[] tmp = id[i];
                id[i] = id[row];
                id[row] = tmp;
            }
        }
        return id;
    }

    static BigDecimal[][][] lu(MathContext mc, BigDecimal[][] A) {
        try {
            int n = A.length;
            BigDecimal[][] L = new BigDecimal[n][n];
            BigDecimal[][] U = new BigDecimal[n][n];
            for (int i = 0; i < n; i++) {
                Arrays.fill(L[i], BigDecimal.ZERO);
                Arrays.fill(U[i], BigDecimal.ZERO);
            }
            BigDecimal[][] P = pivotize(A);
            BigDecimal[][] A2 = matrixMul(P, A);

            for (int j = 0; j < n; j++) {
                L[j][j] = BigDecimal.ONE;
                for (int i = 0; i < j + 1; i++) {
                    BigDecimal s1 = BigDecimal.ZERO;
                    for (int k = 0; k < i; k++)
                        s1 = s1.add(U[k][j].multiply(L[i][k]));
                    U[i][j] = A2[i][j].subtract(s1);
                }
                for (int i = j; i < n; i++) {
                    BigDecimal s2 = BigDecimal.ZERO;
                    for (int k = 0; k < j; k++)
                        s2 = s2.add(U[k][j].multiply(L[i][k]));
                    L[i][j] = A2[i][j].subtract(s2).divide(U[j][j], mc);
                }
            }
            return new BigDecimal[][][]{L, U, P};
        } catch (ArithmeticException e) {
            throw new RuntimeException("Singular matrix.");
        }
    }

    // Complex case
    static BigComplex dotProduct(BigComplex[] a, BigComplex[] b) {
        return IntStream.range(0, a.length).mapToObj(i -> a[i].multiply(b[i])).reduce(BigComplex.ZERO, BigComplex::add);
    }

    static BigComplex[][] matrixMul(BigComplex[][] A, BigComplex[][] B) {
        BigComplex[][] result = new BigComplex[A.length][B[0].length];
        for(int i = 0; i < A.length; i++) {
            Arrays.fill(result[i], BigComplex.ZERO);
        }
        BigComplex[] aux = new BigComplex[B.length];
        for(int i = 0; i < B.length; i++) {
            Arrays.fill(aux, BigComplex.ZERO);
        }

        for (int j = 0; j < B[0].length; j++) {

            for (int k = 0; k < B.length; k++)
                aux[k] = B[k][j];

            for (int i = 0; i < A.length; i++)
                result[i][j] = dotProduct(A[i], aux);
        }
        return result;
    }

    static BigComplex[][] pivotize(MathContext mc, BigComplex[][] m) {
        int n = m.length;
        BigComplex[][] id =
                IntStream.range(0, n).mapToObj(j ->
                        IntStream.range(0, n).mapToObj(i ->
                                i == j ? BigComplex.ONE : BigComplex.ZERO
                        ).toArray(BigComplex[]::new)).toArray(BigComplex[][]::new);

        for (int i = 0; i < n; i++) {
            BigComplex maxm = m[i][i];
            int row = i;
            for (int j = i; j < n; j++)
                if (m[j][i].abs(mc).compareTo(maxm.abs(mc)) > 0) {
                    maxm = m[j][i];
                    row = j;
                }

            if (i != row) {
                BigComplex[] tmp = id[i];
                id[i] = id[row];
                id[row] = tmp;
            }
        }
        return id;
    }

    static BigComplex[][][] lu(MathContext mc, BigComplex[][] A) {
        try {
            int n = A.length;
            BigComplex[][] L = new BigComplex[n][n];
            BigComplex[][] U = new BigComplex[n][n];
            for (int i = 0; i < n; i++) {
                Arrays.fill(L[i], BigComplex.ZERO);
                Arrays.fill(U[i], BigComplex.ZERO);
            }
            BigComplex[][] P = pivotize(mc, A);
            BigComplex[][] A2 = matrixMul(P, A);

            for (int j = 0; j < n; j++) {
                L[j][j] = BigComplex.ONE;
                for (int i = 0; i < j + 1; i++) {
                    BigComplex s1 = BigComplex.ZERO;
                    for (int k = 0; k < i; k++)
                        s1 = s1.add(U[k][j].multiply(L[i][k]));
                    U[i][j] = A2[i][j].subtract(s1);
                }
                for (int i = j; i < n; i++) {
                    BigComplex s2 = BigComplex.ZERO;
                    for (int k = 0; k < j; k++)
                        s2 = s2.add(U[k][j].multiply(L[i][k]));
                    L[i][j] = A2[i][j].subtract(s2).divide(U[j][j], mc);
                }
            }
            return new BigComplex[][][]{L, U, P};
        } catch (ArithmeticException e) {
            throw new RuntimeException("Singular matrix.");
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

        MathContext wp = new MathContext(env.getMathContext().getPrecision() + 20);

        if(l1.stream().allMatch(x -> x.stream().allMatch(y -> y.getType() == Type.INTEGER || y.getType() == Type.REAL))) {
            // Real case
            BigDecimal[][] A = l1.stream().map(x -> x.stream().map(Atom::getReal).toArray(BigDecimal[]::new)).toArray(BigDecimal[][]::new);
            BigDecimal[][][] data = lu(wp, A);
            for(int i = 0; i < data.length; i++) {
                for(int j = 0; j < data[i].length; j++) {
                    for(int k = 0; k < data[i][j].length; k++) {
                        data[i][j][k] = data[i][j][k].setScale(env.getMathContext().getPrecision() - 10, RoundingMode.HALF_UP);
                        data[i][j][k] = data[i][j][k].stripTrailingZeros();
                    }
                }
            }
            return new Atom(List.of(
                    new Atom(Arrays.stream(data[0]).map(x -> new Atom(Arrays.stream(x).map(Atom::new).toList())).toList()),
                    new Atom(Arrays.stream(data[1]).map(x -> new Atom(Arrays.stream(x).map(Atom::new).toList())).toList()),
                    new Atom(Arrays.stream(data[2]).map(x -> new Atom(Arrays.stream(x).map(Atom::new).toList())).toList())
            ));
        } else {
            // Complex case.
            BigComplex[][] A = l1.stream().map(x -> x.stream().map(Atom::getComplex).toArray(BigComplex[]::new)).toArray(BigComplex[][]::new);
            BigComplex[][][] data = lu(wp, A);
            for(int i = 0; i < data.length; i++) {
                for(int j = 0; j < data[i].length; j++) {
                    for(int k = 0; k < data[i][j].length; k++) {
                        BigDecimal re = data[i][j][k].re.setScale(env.getMathContext().getPrecision() - 10, RoundingMode.HALF_UP).stripTrailingZeros();
                        BigDecimal im = data[i][j][k].im.setScale(env.getMathContext().getPrecision() - 10, RoundingMode.HALF_UP).stripTrailingZeros();
                        data[i][j][k] = BigComplex.valueOf(re, im);
                    }
                }
            }
            return new Atom(List.of(
                    new Atom(Arrays.stream(data[0]).map(x -> new Atom(Arrays.stream(x).map(Atom::new).toList())).toList()),
                    new Atom(Arrays.stream(data[1]).map(x -> new Atom(Arrays.stream(x).map(Atom::new).toList())).toList()),
                    new Atom(Arrays.stream(data[2]).map(x -> new Atom(Arrays.stream(x).map(Atom::new).toList())).toList())
            ));
        }
    }

    @Override
    protected String name() {
        return "num:PLU";
    }
}
