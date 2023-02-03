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
    public class LU implements java.io.Serializable {
        private BigDecimal[][] LU;
        private int m, n, pivsign;
        private int[] piv;

        public LU (MathContext mc, BigDecimal[][] A) {
            // Copy A to LU
            LU = new BigDecimal[A.length][];
            for(int i = 0; i < A.length; i++) {
                LU[i] = Arrays.copyOf(A[i], A[i].length);
            }
            m = A.length;
            n = A[0].length;
            piv = new int[m];
            for (int i = 0; i < m; i++) {
                piv[i] = i;
            }
            pivsign = 1;
            BigDecimal[] LUrowi;
            BigDecimal[] LUcolj = new BigDecimal[m];
            for (int j = 0; j < n; j++) {
                for (int i = 0; i < m; i++) {
                    LUcolj[i] = LU[i][j];
                }

                for (int i = 0; i < m; i++) {
                    LUrowi = LU[i];

                    int kmax = Math.min(i,j);
                    BigDecimal s = BigDecimal.ZERO;
                    for (int k = 0; k < kmax; k++) {
                        s = s.add(LUrowi[k].multiply(LUcolj[k]));
                    }

                    LUrowi[j] = LUcolj[i] = LUcolj[i].subtract(s);
                }

                int p = j;
                for (int i = j+1; i < m; i++) {
                    if (LUcolj[i].abs().compareTo(LUcolj[p].abs()) > 0) {
                        p = i;
                    }
                }
                if (p != j) {
                    for (int k = 0; k < n; k++) {
                        BigDecimal t = LU[p][k]; LU[p][k] = LU[j][k]; LU[j][k] = t;
                    }
                    int k = piv[p]; piv[p] = piv[j]; piv[j] = k;
                    pivsign = -pivsign;
                }

                if (j < m && LU[j][j].compareTo(BigDecimal.ZERO) != 0) {
                    for (int i = j+1; i < m; i++) {
                        LU[i][j] = LU[i][j].divide(LU[j][j], mc);
                    }
                }
            }
        }

        public boolean isNonsingular () {
            for (int j = 0; j < n; j++) {
                if (LU[j][j].compareTo(BigDecimal.ZERO) == 0)
                    return false;
            }
            return true;
        }

        public BigDecimal[][] getL () {
            BigDecimal[][] L = new BigDecimal[m][m];
            for (int i = 0; i < m; i++) {
                for (int j = 0; j < n; j++) {
                    if (i > j) {
                        L[i][j] = LU[i][j];
                    } else if (i == j) {
                        L[i][j] = BigDecimal.ONE;
                    } else {
                        L[i][j] = BigDecimal.ZERO;
                    }
                }
            }
            return L;
        }

        public BigDecimal[][] getU () {
            BigDecimal[][] U = new BigDecimal[n][n];
            for (int i = 0; i < n; i++) {
                for (int j = 0; j < n; j++) {
                    if (i <= j) {
                        U[i][j] = LU[i][j];
                    } else {
                        U[i][j] = BigDecimal.ZERO;
                    }
                }
            }
            return U;
        }

        public BigDecimal det () {
            if (m != n) {
                throw new IllegalArgumentException("Matrix must be square.");
            }
            BigDecimal d = new BigDecimal(pivsign);
            for (int j = 0; j < n; j++) {
                d = d.multiply(LU[j][j]);
            }
            return d;
        }

        public BigDecimal[][] getP () {
            BigDecimal[][] P = new BigDecimal[m][m];
            for(int i = 0; i < m; i++) {
                for(int j = 0; j < m; j++)
                    P[i][j] = BigDecimal.ZERO;
                P[i][piv[i]] = BigDecimal.ONE;
            }
            return P;
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        Atom a1 = args.get(0);
        if(Rank.computeRank(a1) != 2) {
            throw new RuntimeException("Expected a matrix of rank 2.");
        }
        List<List<Atom>> l1 = a1.getList().stream().map(Atom::getList).toList();
        if(l1.stream().allMatch(x -> x.stream().allMatch(y -> y.getType() == Type.INTEGER || y.getType() == Type.REAL))) {
            // Real case.
            BigDecimal[][] A = l1.stream().map(x -> x.stream().map(Atom::getReal).toArray(BigDecimal[]::new)).toArray(BigDecimal[][]::new);
            LU lu = new LU(env.getMathContext(), A);
            if(!lu.isNonsingular()) {
                return Atom.NULL;
            } else {
                if(A.length == A[0].length) {
                    List<Atom> l = List.of(
                            new Atom(Arrays.stream(lu.getL()).map(x -> new Atom(Arrays.stream(x).map(Atom::new).toList())).toList()),
                            new Atom(Arrays.stream(lu.getU()).map(x -> new Atom(Arrays.stream(x).map(Atom::new).toList())).toList()),
                            new Atom(Arrays.stream(lu.getP()).map(x -> new Atom(Arrays.stream(x).map(Atom::new).toList())).toList()),
                            new Atom(lu.det())
                    );
                    return new Atom(l);
                } else {
                    List<Atom> l = List.of(
                            new Atom(Arrays.stream(lu.getL()).map(x -> new Atom(Arrays.stream(x).map(Atom::new).toList())).toList()),
                            new Atom(Arrays.stream(lu.getU()).map(x -> new Atom(Arrays.stream(x).map(Atom::new).toList())).toList()),
                            new Atom(Arrays.stream(lu.getP()).map(x -> new Atom(Arrays.stream(x).map(Atom::new).toList())).toList())
                    );
                    return new Atom(l);
                }
            }
        } else {
            // Complex case.
            throw new RuntimeException("Complex case not implemented yet.");
        }
    }

    @Override
    protected String name() {
        return "matrix:LU";
    }
}
