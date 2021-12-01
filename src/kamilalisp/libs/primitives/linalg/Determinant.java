package kamilalisp.libs.primitives.linalg;

import ch.obermuhlner.math.big.BigComplex;
import kamilalisp.data.*;
import kamilalisp.matrix.Matrix;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class Determinant implements Closure {
    public static Atom det(Matrix m) {
        if(m.getRows() == 1) {
            return m.get(0, 0);
        } else if(m.getRows() == 2) {
            Atom a1 = m.get(0, 0);
            Atom a2 = m.get(1, 1);
            Atom a3 = m.get(0, 1);
            Atom a4 = m.get(1, 0);
            if(a1.getType() == Type.COMPLEX || a2.getType() == Type.COMPLEX || a3.getType() == Type.COMPLEX || a4.getType() == Type.COMPLEX) {
                BigComplex a; if(a1.getType() == Type.COMPLEX) a = a1.getComplex().get(); else a = BigComplex.valueOf(a1.getNumber().get());
                BigComplex b; if(a2.getType() == Type.COMPLEX) b = a2.getComplex().get(); else b = BigComplex.valueOf(a2.getNumber().get());
                BigComplex c; if(a3.getType() == Type.COMPLEX) c = a3.getComplex().get(); else c = BigComplex.valueOf(a3.getNumber().get());
                BigComplex d; if(a4.getType() == Type.COMPLEX) d = a4.getComplex().get(); else d = BigComplex.valueOf(a4.getNumber().get());
                return new Atom(a.multiply(b).subtract(c.multiply(d)));
            } else {
                return new Atom(a1.getNumber().get().multiply(a2.getNumber().get()).subtract(a3.getNumber().get().multiply(a4.getNumber().get())));
            }
        } else {
            BigComplex result = BigComplex.ZERO;
            int dim = m.getCols();

            for(int i = 0; i < dim; i++) {
                List<List<Atom>> temporary = new ArrayList<>();
                for(int q = 0; q < dim - 1; q++)
                    temporary.add(new ArrayList<>(Collections.nCopies(dim - 1, new Atom(BigDecimal.ZERO))));

                for (int j = 1; j < dim; j++) {
                    for (int k = 0; k < dim; k++) {
                        if (k < i) {
                            temporary.get(j - 1).set(k, m.get(j, k));
                        } else if (k > i) {
                            temporary.get(j - 1).set(k - 1, m.get(j, k));
                        }
                    }
                }

                Atom q = m.get(0, i);
                Atom p = det(Matrix.from(temporary));

                if(p.getType() == Type.COMPLEX || q.getType() == Type.COMPLEX) {
                    BigComplex a; if(q.getType() == Type.COMPLEX) a = q.getComplex().get(); else a = BigComplex.valueOf(q.getNumber().get());
                    BigComplex b; if(p.getType() == Type.COMPLEX) b = p.getComplex().get(); else b = BigComplex.valueOf(p.getNumber().get());
                    result = result.add(a.multiply(b).multiply(BigDecimal.ONE.negate().pow(i)));
                } else {
                    result = result.add(q.getNumber().get().multiply(p.getNumber().get()).multiply(BigDecimal.ONE.negate().pow(i)));
                }
            }

            if(result.im.compareTo(BigDecimal.ZERO) == 0)
                return new Atom(result.re);
            else
                return new Atom(result);
        }
    }

    @Override
    public Atom apply(Executor env, List<Atom> arguments) {
        if(arguments.size() != 1 && arguments.size() != 3)
            throw new Error("'det' takes exactly one or three arguments.");
        return new Atom(new LbcSupplier<>(() -> {
            arguments.get(0).guardType("Argument to 'det'", Type.MATRIX);
            Matrix m = arguments.get(0).getMatrix().get();
            if(!m.isNumeric())
                throw new Error("'det' expects a numeric matrix.");
            if(m.getRows() != m.getCols())
                throw new Error("'det' expects a square matrix.");
            return det(m).get().get();
        }));
    }
}
