package palaiologos.kamilalisp.runtime.matrix;

import ch.obermuhlner.math.big.BigComplex;
import ch.obermuhlner.math.big.BigComplexMath;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.runtime.array.Rank;

import java.math.BigDecimal;
import java.math.MathContext;
import java.util.Arrays;
import java.util.List;

public class QRDecomposition extends PrimitiveFunction implements Lambda {
    public class RealQR {
        private BigDecimal[][] QR;
        private int m, n;
        private BigDecimal[] Rdiag;

        public RealQR (MathContext mc, BigDecimal[][] A) {
            QR = new BigDecimal[A.length][];
            for(int i = 0; i < A.length; i++) {
                QR[i] = Arrays.copyOf(A[i], A[i].length);
            }
            m = A.length;
            n = A[0].length;
            Rdiag = new BigDecimal[n];
            for(int i = 0; i < n; i++) {
                Rdiag[i] = BigDecimal.ZERO;
            }

            for (int k = 0; k < n; k++) {
                BigDecimal nrm = BigDecimal.ZERO;
                for (int i = k; i < m; i++) {
                    nrm = (nrm.multiply(nrm).add(QR[i][k].multiply(QR[i][k]))).sqrt(mc);
                }

                if (nrm.compareTo(BigDecimal.ZERO) != 0) {
                    if (QR[k][k].compareTo(BigDecimal.ZERO) < 0) {
                        nrm = nrm.negate();
                    }
                    for (int i = k; i < m; i++) {
                        QR[i][k] = QR[i][k].divide(nrm, mc);
                    }
                    QR[k][k] = QR[k][k].add(BigDecimal.ONE);

                    // Apply transformation to remaining columns.
                    for (int j = k+1; j < n; j++) {
                        BigDecimal s = BigDecimal.ZERO;
                        for (int i = k; i < m; i++) {
                            s = s.add(QR[i][k].multiply(QR[i][j]));
                        }
                        s = s.negate().divide(QR[k][k], mc);
                        for (int i = k; i < m; i++) {
                            QR[i][j] = s.multiply(QR[i][k]).add(QR[i][j]);
                        }
                    }
                }
                Rdiag[k] = nrm.negate();
            }
        }

        public BigDecimal[][] getH () {
            BigDecimal[][] H = new BigDecimal[m][n];
            for (int i = 0; i < m; i++) {
                for (int j = 0; j < n; j++) {
                    if (i >= j) {
                        H[i][j] = QR[i][j];
                    } else {
                        H[i][j] = BigDecimal.ZERO;
                    }
                }
            }
            return H;
        }

        public BigDecimal[][] getR () {
            BigDecimal[][] R = new BigDecimal[n][n];
            for (int i = 0; i < n; i++) {
                for (int j = 0; j < n; j++) {
                    if (i < j) {
                        R[i][j] = QR[i][j];
                    } else if (i == j) {
                        R[i][j] = Rdiag[i];
                    } else {
                        R[i][j] = BigDecimal.ZERO;
                    }
                }
            }
            return R;
        }

        public BigDecimal[][] getQ (MathContext mc) {
            BigDecimal[][] Q = new BigDecimal[m][n];
            for(int i = 0; i < m; i++) {
                for(int j = 0; j < n; j++) {
                    Q[i][j] = BigDecimal.ZERO;
                }
            }
            for (int k = n-1; k >= 0; k--) {
                for (int i = 0; i < m; i++) {
                    Q[i][k] = BigDecimal.ZERO;
                }
                Q[k][k] = BigDecimal.ONE;
                for (int j = k; j < n; j++) {
                    if (QR[k][k].compareTo(BigDecimal.ZERO) != 0) {
                        BigDecimal s = BigDecimal.ZERO;
                        for (int i = k; i < m; i++) {
                            s = s.add(QR[i][k].multiply(Q[i][j]));
                        }
                        s = s.negate().divide(QR[k][k], mc);
                        for (int i = k; i < m; i++) {
                            Q[i][j] = Q[i][j].add(s.multiply(QR[i][k]));
                        }
                    }
                }
            }
            return Q;
        }
    }

    public class ComplexQR {
        private BigComplex[][] QR;
        private int m, n;
        private BigComplex[] Rdiag;

        public ComplexQR (MathContext mc, BigComplex[][] A) {
            QR = new BigComplex[A.length][];
            for(int i = 0; i < A.length; i++) {
                QR[i] = Arrays.copyOf(A[i], A[i].length);
            }
            m = A.length;
            n = A[0].length;
            Rdiag = new BigComplex[n];
            for(int i = 0; i < n; i++) {
                Rdiag[i] = BigComplex.ZERO;
            }

            for (int k = 0; k < n; k++) {
                BigComplex nrm = BigComplex.ZERO;
                for (int i = k; i < m; i++) {
                    nrm = BigComplexMath.sqrt(nrm.multiply(nrm).add(QR[i][k].multiply(QR[i][k])), mc);
                }

                if (!nrm.equals(BigComplex.ZERO)) {
                    /// XXX: Is that correct?
                    if (QR[k][k].abs(mc).signum() < 0) {
                        nrm = nrm.negate();
                    }
                    for (int i = k; i < m; i++) {
                        QR[i][k] = QR[i][k].divide(nrm, mc);
                    }
                    QR[k][k] = QR[k][k].add(BigComplex.ONE);

                    // Apply transformation to remaining columns.
                    for (int j = k+1; j < n; j++) {
                        BigComplex s = BigComplex.ZERO;
                        for (int i = k; i < m; i++) {
                            s = s.add(QR[i][k].multiply(QR[i][j]));
                        }
                        s = s.negate().divide(QR[k][k], mc);
                        for (int i = k; i < m; i++) {
                            QR[i][j] = s.multiply(QR[i][k]).add(QR[i][j]);
                        }
                    }
                }
                Rdiag[k] = nrm.negate();
            }
        }

        public BigComplex[][] getH () {
            BigComplex[][] H = new BigComplex[m][n];
            for (int i = 0; i < m; i++) {
                for (int j = 0; j < n; j++) {
                    if (i >= j) {
                        H[i][j] = QR[i][j];
                    } else {
                        H[i][j] = BigComplex.ZERO;
                    }
                }
            }
            return H;
        }

        public BigComplex[][] getR () {
            BigComplex[][] R = new BigComplex[n][n];
            for (int i = 0; i < n; i++) {
                for (int j = 0; j < n; j++) {
                    if (i < j) {
                        R[i][j] = QR[i][j];
                    } else if (i == j) {
                        R[i][j] = Rdiag[i];
                    } else {
                        R[i][j] = BigComplex.ZERO;
                    }
                }
            }
            return R;
        }

        public BigComplex[][] getQ (MathContext mc) {
            BigComplex[][] Q = new BigComplex[m][n];
            for(int i = 0; i < m; i++) {
                for(int j = 0; j < n; j++) {
                    Q[i][j] = BigComplex.ZERO;
                }
            }
            for (int k = n-1; k >= 0; k--) {
                for (int i = 0; i < m; i++) {
                    Q[i][k] = BigComplex.ZERO;
                }
                Q[k][k] = BigComplex.ONE;
                for (int j = k; j < n; j++) {
                    if (!QR[k][k].equals(BigComplex.ZERO)) {
                        BigComplex s = BigComplex.ZERO;
                        for (int i = k; i < m; i++) {
                            s = s.add(QR[i][k].multiply(Q[i][j]));
                        }
                        s = s.negate().divide(QR[k][k], mc);
                        for (int i = k; i < m; i++) {
                            Q[i][j] = Q[i][j].add(s.multiply(QR[i][k]));
                        }
                    }
                }
            }
            return Q;
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
            RealQR qr = new RealQR(env.getMathContext(), A);
            return new Atom(List.of(
                    new Atom(Arrays.stream(qr.getQ(env.getMathContext())).map(x -> new Atom(Arrays.stream(x).map(Atom::new).toList())).toList()),
                    new Atom(Arrays.stream(qr.getR()).map(x -> new Atom(Arrays.stream(x).map(Atom::new).toList())).toList()),
                    new Atom(Arrays.stream(qr.getH()).map(x -> new Atom(Arrays.stream(x).map(Atom::new).toList())).toList())
            ));
        } else {
            // Complex case.
            BigComplex[][] A = l1.stream().map(x -> x.stream().map(Atom::getComplex).toArray(BigComplex[]::new)).toArray(BigComplex[][]::new);
            ComplexQR qr = new ComplexQR(env.getMathContext(), A);
            return new Atom(List.of(
                    new Atom(Arrays.stream(qr.getQ(env.getMathContext())).map(x -> new Atom(Arrays.stream(x).map(Atom::new).toList())).toList()),
                    new Atom(Arrays.stream(qr.getR()).map(x -> new Atom(Arrays.stream(x).map(Atom::new).toList())).toList()),
                    new Atom(Arrays.stream(qr.getH()).map(x -> new Atom(Arrays.stream(x).map(Atom::new).toList())).toList())
            ));
        }
    }

    @Override
    protected String name() {
        return "matrix:QR";
    }
}