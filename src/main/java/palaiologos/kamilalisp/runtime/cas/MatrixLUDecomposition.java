package palaiologos.kamilalisp.runtime.cas;

import ch.obermuhlner.math.big.BigComplex;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;
import palaiologos.kamilalisp.runtime.array.Rank;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedHashSet;
import java.util.List;

public class MatrixLUDecomposition extends PrimitiveFunction implements Lambda {

    private static final Atom plus = new Atom("+", true);
    private static final Atom minus = new Atom("-", true);
    private static final Atom times = new Atom("*", true);
    private static final Atom slash = new Atom("/", true);

    static void casLU(Environment env, Atom[][] A, Atom[][] lower, Atom[][] upper, LinkedHashSet<String> vars, boolean vigillant) {
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
                    if ((lower[i][j].isNumeric() && lower[i][j].getComplex().equals(BigComplex.ZERO))
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
                    } else if (sum.size() == 2) {
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
        for (int i = 0; i < A.length; i++) {
            for (int j = 0; j < A.length; j++) {
                MathExpression mel = new MathExpression(env, vars, lower[i][j]);
                MathExpression meu = new MathExpression(env, vars, upper[i][j]);
                if (!lower[i][j].isNumeric())
                    mel = mel.simplify(env);
                if (!upper[i][j].isNumeric())
                    meu = meu.simplify(env);
                lower[i][j] = new Atom(mel);
                upper[i][j] = new Atom(meu);
            }
        }
        // This is a good moment to determine if det(L) == 0 || det(U) == 0
        // If the diagonal product of L = 0 or the diagonal product of U = 0,
        // matrix is singular. We should error in this case.
        // => check if there is a literal zero on the leading diagonal of L or U.
        for (int i = 0; i < A.length; i++) {
            Atom l = lower[i][i].getUserdata(MathExpression.class).getData();
            Atom u = upper[i][i].getUserdata(MathExpression.class).getData();
            if (l.isNumeric() && l.getComplex().equals(BigComplex.ZERO)) {
                throw new RuntimeException("Matrix is singular.");
            }
            if (u.isNumeric() && u.getComplex().equals(BigComplex.ZERO)) {
                throw new RuntimeException("Matrix is singular.");
            }
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        Atom a1 = args.get(0);
        if (Rank.computeRank(a1) != 2) {
            throw new RuntimeException("Expected a matrix of rank 2.");
        }

        List<Atom> a1l = a1.getList();
        for (Atom atom : a1l) {
            if (atom.getList().size() != a1l.get(0).getList().size()) {
                throw new RuntimeException("Expected a square matrix.");
            }
        }

        List<Atom[]> list = new ArrayList<>();
        for (Atom atom : a1l) {
            Atom[] atoms = atom.getList().toArray(Atom[]::new);
            list.add(atoms);
        }
        Atom[][] A = list.toArray(new Atom[0][]);
        Atom[][] L = new Atom[A.length][A.length];
        Atom[][] U = new Atom[A.length][A.length];
        for (int i = 0; i < A.length; i++) {
            for (int j = 0; j < A.length; j++) {
                L[i][j] = new Atom(BigDecimal.ZERO);
                U[i][j] = new Atom(BigDecimal.ZERO);
            }
        }

        LinkedHashSet<String> vars = new LinkedHashSet<>();
        casLU(env, A, L, U, vars, true);
        List<Atom> result = new ArrayList<>();
        for (Atom[] atoms : L) {
            Atom atom = new Atom(Arrays.asList(atoms));
            result.add(atom);
        }
        Atom MathL = new Atom(result);
        List<Atom> list1 = new ArrayList<>();
        for (Atom[] x : U) {
            Atom atom = new Atom(Arrays.asList(x));
            list1.add(atom);
        }
        Atom MathU = new Atom(list1);
        return new Atom(List.of(MathL, MathU));
    }

    @Override
    public String name() {
        return "cas:matrix:LU";
    }

}
