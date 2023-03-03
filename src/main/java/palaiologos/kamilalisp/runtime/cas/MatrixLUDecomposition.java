package palaiologos.kamilalisp.runtime.cas;

import ch.obermuhlner.math.big.BigComplex;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.runtime.array.Rank;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.LinkedHashSet;

public class MatrixLUDecomposition extends PrimitiveFunction implements Lambda {

    private static final Atom plus = new Atom("+", true);
    private static final Atom minus = new Atom("-", true);
    private static final Atom times = new Atom("*", true);
    private static final Atom slash = new Atom("/", true);

    private static void casLU(Atom[][] A, Atom[][] lower, Atom[][] upper, LinkedHashSet<String> vars) {
        for (int i = 0; i < A.length; i++) {
            for (int j = 0; j < A.length; j++) {
                if (A[i][j].isUserdata(MathExpression.class)) {
                    vars.addAll(A[i][j].getUserdata(MathExpression.class).getArgs());
                    A[i][j] = A[i][j].getUserdata(MathExpression.class).getData();
                }
            }
        }
        for (int i = 0; i < A.length; i++) {
            for (int k = i; k < A.length; k++) {
                List<Atom> sum = new ArrayList<>();
                sum.add(plus);
                for (int j = 0; j < i; j++) {
                    if ((lower[i][j].isNumeric() && lower[i][j].getComplex().equals(BigComplex.ONE))
                            || (upper[j][k].isNumeric() && upper[j][k].getComplex().equals(BigComplex.ZERO))) {
                        continue;
                    }
                    sum.add(new Atom(List.of(times, lower[i][j], upper[j][k])));
                }
                if (sum.size() == 1) {
                    upper[i][k] = A[i][k];
                } else if (sum.size() == 2) {
                    upper[i][k] = new Atom(List.of(minus, A[i][k], sum.get(1)));
                } else {
                    upper[i][k] = new Atom(List.of(minus, A[i][k], new Atom(sum)));
                }
            }

            // Lower Triangular
            for (int k = i; k < A.length; k++) {
                if (i == k) {
                    lower[i][i] = new Atom(BigDecimal.ONE);
                } else {
                    List<Atom> sum = new ArrayList<>();
                    sum.add(plus);
                    for (int j = 0; j < i; j++) {
                        if ((lower[k][i].isNumeric() && lower[k][i].getComplex().equals(BigComplex.ZERO))
                                || (upper[j][i].isNumeric() && upper[j][i].getComplex().equals(BigComplex.ZERO))) {
                            continue;
                        }
                        sum.add(new Atom(List.of(times, lower[k][i], upper[j][i])));
                    }
                    if (sum.size() == 1) {
                        if (upper[i][i].isNumeric() && upper[i][i].getComplex().equals(BigComplex.ONE)) {
                            lower[k][i] = A[k][i];
                        } else {
                            lower[k][i] = new Atom(List.of(slash, A[k][i], upper[i][i]));
                        }
                    } else if(sum.size() == 2) { 
                        if (upper[i][i].isNumeric() && upper[i][i].getComplex().equals(BigComplex.ONE)) {
                            lower[k][i] = new Atom(List.of(minus, A[k][i], sum.get(1)));
                        } else {
                            lower[k][i] = new Atom(List.of(slash, new Atom(List.of(minus, A[k][i], sum.get(1))), upper[i][i]));
                        }
                    } else {
                        if (upper[i][i].isNumeric() && upper[i][i].getComplex().equals(BigComplex.ONE)) {
                            lower[k][i] = new Atom(List.of(minus, A[k][i], new Atom(sum)));
                        } else {
                            lower[k][i] = new Atom(List.of(slash, new Atom(List.of(minus, A[k][i], new Atom(sum))), upper[i][i]));
                        }
                    }
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

        Atom[][] A = l1.stream().map(x -> x.stream().toArray(Atom[]::new)).toArray(Atom[][]::new);
        Atom[][] L = new Atom[A.length][A.length];
        Atom[][] U = new Atom[A.length][A.length];
        for (int i = 0; i < A.length; i++) {
            for (int j = 0; j < A.length; j++) {
                L[i][j] = new Atom(BigDecimal.ZERO);
                U[i][j] = new Atom(BigDecimal.ZERO);
            }
        }

        LinkedHashSet<String> vars = new LinkedHashSet<>();
        casLU(A, L, U, vars);

        Atom MathL = new Atom(Arrays.stream(L)
                .map(x -> new Atom(
                Arrays.stream(x)
                        .map(a -> new Atom(new MathExpression(env, vars, a)))
                        .toList()))
                .toList());
        Atom MathU = new Atom(Arrays.stream(U)
                .map(x -> new Atom(
                Arrays.stream(x)
                        .map(a -> new Atom(new MathExpression(env, vars, a)))
                        .toList()))
                .toList());
        return new Atom(List.of(MathL, MathU));
    }

    @Override
    public String name() {
        return "cas:matrix:LU";
    }

}
