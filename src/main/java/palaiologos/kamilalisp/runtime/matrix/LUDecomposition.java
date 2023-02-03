package palaiologos.kamilalisp.runtime.matrix;

import ch.obermuhlner.math.big.BigComplex;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.runtime.array.Rank;

import java.math.BigDecimal;
import java.math.MathContext;
import java.util.Arrays;
import java.util.List;
import java.util.stream.IntStream;

public class LUDecomposition extends PrimitiveFunction implements Lambda {
    private static void realLU(MathContext mc, BigDecimal[][] A, BigDecimal[][] lower, BigDecimal[][] upper) {
        for (int i = 0; i < A.length; i++) {
            for (int k = i; k < A.length; k++) {
                BigDecimal sum = BigDecimal.ZERO;
                for (int j = 0; j < i; j++)
                    sum = sum.add(lower[i][j].multiply(upper[j][k]));

                upper[i][k] = A[i][k].subtract(sum);
            }

            // Lower Triangular
            for (int k = i; k < A.length; k++) {
                if (i == k)
                    lower[i][i] = BigDecimal.ONE;
                else {
                    BigDecimal sum = BigDecimal.ZERO;
                    for (int j = 0; j < i; j++)
                        sum = sum.add(lower[k][j].multiply(upper[j][i]));

                    lower[k][i] = (A[k][i].subtract(sum)).divide(upper[i][i], mc);
                }
            }
        }
    }

    private static void complexLU(MathContext mc, BigComplex[][] A, BigComplex[][] lower, BigComplex[][] upper) {
        for (int i = 0; i < A.length; i++) {
            for (int k = i; k < A.length; k++) {
                BigComplex sum = BigComplex.ZERO;
                for (int j = 0; j < i; j++)
                    sum = sum.add(lower[i][j].multiply(upper[j][k]));

                upper[i][k] = A[i][k].subtract(sum);
            }

            // Lower Triangular
            for (int k = i; k < A.length; k++) {
                if (i == k)
                    lower[i][i] = BigComplex.ONE;
                else {
                    BigComplex sum = BigComplex.ZERO;
                    for (int j = 0; j < i; j++)
                        sum = sum.add(lower[k][j].multiply(upper[j][i]));

                    lower[k][i] = (A[k][i].subtract(sum)).divide(upper[i][i], mc);
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

        if (l1.stream().allMatch(x -> x.stream().allMatch(y -> y.getType() == Type.INTEGER || y.getType() == Type.REAL))) {
            BigDecimal[][] A = l1.stream().map(x -> x.stream().map(Atom::getReal).toArray(BigDecimal[]::new)).toArray(BigDecimal[][]::new);
            BigDecimal[][] L = new BigDecimal[A.length][A.length];
            BigDecimal[][] U = new BigDecimal[A.length][A.length];
            for (int i = 0; i < A.length; i++) {
                Arrays.fill(L[i], BigDecimal.ZERO);
                Arrays.fill(U[i], BigDecimal.ZERO);
            }
            realLU(env.getMathContext(), A, L, U);
            return new Atom(List.of(
                    new Atom(Arrays.stream(L).map(x -> new Atom(Arrays.stream(x).map(Atom::new).toList())).toList()),
                    new Atom(Arrays.stream(U).map(x -> new Atom(Arrays.stream(x).map(Atom::new).toList())).toList())
            ));
        } else {
            BigComplex[][] A = l1.stream().map(x -> x.stream().map(Atom::getComplex).toArray(BigComplex[]::new)).toArray(BigComplex[][]::new);
            BigComplex[][] L = new BigComplex[A.length][A.length];
            BigComplex[][] U = new BigComplex[A.length][A.length];
            for (int i = 0; i < A.length; i++) {
                Arrays.fill(L[i], BigComplex.ZERO);
                Arrays.fill(U[i], BigComplex.ZERO);
            }
            complexLU(env.getMathContext(), A, L, U);
            return new Atom(List.of(
                    new Atom(Arrays.stream(L).map(x -> new Atom(Arrays.stream(x).map(Atom::new).toList())).toList()),
                    new Atom(Arrays.stream(U).map(x -> new Atom(Arrays.stream(x).map(Atom::new).toList())).toList())
            ));
        }
    }

    @Override
    protected String name() {
        return "matrix:LU";
    }
}
