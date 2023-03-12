package palaiologos.kamilalisp.runtime.math.num;

import ch.obermuhlner.math.big.BigComplex;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.runtime.array.Rank;

import java.math.BigDecimal;
import java.math.MathContext;
import java.util.Arrays;
import java.util.List;

public class QRDecomposition extends PrimitiveFunction implements Lambda {

    private static BigDecimal realNorm(MathContext mc, BigDecimal[] x) {
        return Arrays.stream(x).map(v -> v.pow(2, mc)).reduce(BigDecimal.ZERO, BigDecimal::add).sqrt(mc);
    }

    private static BigDecimal complexNorm(MathContext mc, BigComplex[] x) {
        return Arrays.stream(x).map(v -> v.absSquare(mc)).reduce(BigDecimal.ZERO, BigDecimal::add).sqrt(mc);
    }

    private static void realHausholder(MathContext mc, BigDecimal[] x, BigDecimal a, BigDecimal[][] Q) {
        int index = Q.length - x.length;
        x[0] = x[0].subtract(a);
        BigDecimal norm = realNorm(mc, x);
        if (norm.compareTo(BigDecimal.ZERO) == 0) return;
        Arrays.setAll(x, i -> x[i].divide(norm, mc));
        for (int i = index; i < Q.length; i++) {
            for (int j = index; j < Q.length; j++) {
                Q[i][j] = Q[i][j].subtract(x[i - index].multiply(x[j - index], mc).multiply(BigDecimal.valueOf(2), mc), mc);
            }
        }
    }

    private static void complexHausholder(MathContext mc, BigComplex[] x, BigDecimal a, BigComplex[][] Q) {
        int index = Q.length - x.length;
        x[0] = x[0].subtract(a);
        BigDecimal norm = complexNorm(mc, x);
        if (norm.compareTo(BigDecimal.ZERO) == 0) return;
        Arrays.setAll(x, i -> x[i].divide(norm, mc));
        for (int i = index; i < Q.length; i++) {
            for (int j = index; j < Q.length; j++) {
                Q[i][j] = Q[i][j].subtract(x[i - index].multiply(x[j - index].conjugate(), mc).multiply(BigComplex.valueOf(2), mc), mc);
            }
        }
    }

    private static void realMatrixMul(MathContext mc, BigDecimal[][] A, BigDecimal[][] B, BigDecimal[][] Res) {
        BigDecimal[][] result = new BigDecimal[A.length][B[0].length];
        for (int i = 0; i < result.length; i++) {
            for (int j = 0; j < result[0].length; j++) {
                BigDecimal sum = BigDecimal.ZERO;
                for (int k = 0; k < B.length; k++) {
                    sum = sum.add(A[i][k].multiply(B[k][j], mc));
                }
                result[i][j] = sum;
            }
        }
        for (int i = 0; i < result.length; i++) {
            for (int j = 0; j < result[0].length; j++) {
                Res[i][j] = result[i][j];
            }
        }
    }

    private static void complexMatrixMul(MathContext mc, BigComplex[][] A, BigComplex[][] B, BigComplex[][] Res) {
        BigComplex[][] result = new BigComplex[A.length][B[0].length];
        for (int i = 0; i < result.length; i++) {
            for (int j = 0; j < result[0].length; j++) {
                BigComplex sum = BigComplex.ZERO;
                for (int k = 0; k < B.length; k++) {
                    sum = sum.add(A[i][k].multiply(B[k][j], mc));
                }
                result[i][j] = sum;
            }
        }
        for (int i = 0; i < result.length; i++) {
            for (int j = 0; j < result[0].length; j++) {
                Res[i][j] = result[i][j];
            }
        }
    }

    private static BigDecimal[][] realTranspose(BigDecimal[][] matrix) {
        BigDecimal[][] t = new BigDecimal[matrix[0].length][matrix.length];
        for (int i = 0; i < matrix.length; i++) {
            for (int j = 0; j < matrix[0].length; j++) {
                t[j][i] = matrix[i][j];
            }
        }
        return t;
    }

    private static BigComplex[][] complexTranspose(BigComplex[][] matrix) {
        BigComplex[][] t = new BigComplex[matrix[0].length][matrix.length];
        for (int i = 0; i < matrix.length; i++) {
            for (int j = 0; j < matrix[0].length; j++) {
                t[j][i] = matrix[i][j];
            }
        }
        return t;
    }

    private static void realQR(MathContext mc, BigDecimal[][] A, BigDecimal[][] Q, BigDecimal[][] R) {
        try {
            for (int i = 0; i < A.length; i++) {
                for (int j = 0; j < A[0].length; j++) {
                    R[i][j] = A[i][j];
                }
            }
            for (int i = 0; i < Q.length; i++) {
                Q[i][i] = BigDecimal.ONE;
            }
            for (int i = 0; i < R.length - 1; i++) {
                // Hausholder matrix for A_i
                BigDecimal[] x = new BigDecimal[R[0].length - i];
                for (int j = 0; j < R[0].length - i; j++) {
                    x[j] = R[i + j][i];
                }
                BigDecimal a = realNorm(mc, x);
                BigDecimal[][] QI = new BigDecimal[R.length][R[0].length];
                Arrays.stream(QI).forEach(q -> Arrays.fill(q, BigDecimal.ZERO));
                for (int q = 0; q < QI.length; q++) {
                    QI[q][q] = BigDecimal.ONE;
                }
                realHausholder(mc, x, a, QI);
                realMatrixMul(mc, Q, QI, Q);
                realMatrixMul(mc, QI, R, R);

            }
            realMatrixMul(mc, realTranspose(Q), A, R);
        } catch (ArithmeticException e) {
            throw new ArithmeticException("Singular matrix.");
        }
    }

    private static void complexQR(MathContext mc, BigComplex[][] A, BigComplex[][] Q, BigComplex[][] R) {
        try {
            for (int i = 0; i < A.length; i++) {
                for (int j = 0; j < A[0].length; j++) {
                    R[i][j] = A[i][j];
                }
            }
            for (int i = 0; i < Q.length; i++) {
                Q[i][i] = BigComplex.ONE;
            }
            for (int i = 0; i < R.length - 1; i++) {
                // Hausholder matrix for A_i
                BigComplex[] x = new BigComplex[R[0].length - i];
                for (int j = 0; j < R[0].length - i; j++) {
                    x[j] = R[i + j][i];
                }
                BigDecimal a = complexNorm(mc, x);
                BigComplex[][] QI = new BigComplex[R.length][R[0].length];
                Arrays.stream(QI).forEach(q -> Arrays.fill(q, BigComplex.ZERO));
                for (int q = 0; q < QI.length; q++) {
                    QI[q][q] = BigComplex.ONE;
                }
                complexHausholder(mc, x, a, QI);
                complexMatrixMul(mc, Q, QI, Q);
                complexMatrixMul(mc, QI, R, R);

            }
            complexMatrixMul(mc, complexTranspose(Q), A, R);
        } catch (ArithmeticException e) {
            throw new ArithmeticException("Singular matrix.");
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
            BigDecimal[][] Q = new BigDecimal[A.length][A.length];
            BigDecimal[][] R = new BigDecimal[A.length][A.length];
            for (int i = 0; i < A.length; i++) {
                Arrays.fill(Q[i], BigDecimal.ZERO);
                Arrays.fill(R[i], BigDecimal.ZERO);
            }
            realQR(env.getMathContext(), A, Q, R);
            return new Atom(List.of(
                    new Atom(Arrays.stream(Q).map(x -> new Atom(Arrays.stream(x).map(Atom::new).toList())).toList()),
                    new Atom(Arrays.stream(R).map(x -> new Atom(Arrays.stream(x).map(Atom::new).toList())).toList())
            ));
        } else {
            BigComplex[][] A = l1.stream().map(x -> x.stream().map(Atom::getComplex).toArray(BigComplex[]::new)).toArray(BigComplex[][]::new);
            BigComplex[][] Q = new BigComplex[A.length][A.length];
            BigComplex[][] R = new BigComplex[A.length][A.length];
            for (int i = 0; i < A.length; i++) {
                Arrays.fill(Q[i], BigComplex.ZERO);
                Arrays.fill(R[i], BigComplex.ZERO);
            }
            complexQR(env.getMathContext(), A, Q, R);
            return new Atom(List.of(new Atom(Arrays.stream(Q).map(x -> new Atom(Arrays.stream(x).map(Atom::new).toList())).toList()),
                    new Atom(Arrays.stream(R).map(x -> new Atom(Arrays.stream(x).map(Atom::new).toList())).toList())
            ));
        }
    }

    @Override
    public String name() {
        return "num:QR";
    }
}
