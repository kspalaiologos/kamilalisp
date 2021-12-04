package kamilalisp.libs.primitives.linalg;

import kamilalisp.data.*;
import kamilalisp.libs.primitives.math.Product;
import kamilalisp.data.Matrix;

import java.math.BigDecimal;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public class Adjoint implements Closure {
    public static Matrix getCofactor(Matrix m, int p, int q) {
        if(m.getRows() != m.getCols())
            throw new Error("'mat-adjoint': 'getCofactor' expects a square matrix.");
        if(m.getRows() < 2)
            throw new Error("'mat-adjoint': 'getCofactor' expects at least a 2x2 matrix.");

        int n = m.getRows();
        Atom[][] matData = new Atom[n - 1][n - 1];

        int i = 0, j = 0;
        for (int row = 0; row < n; row++) {
            for (int col = 0; col < n; col++) {
                if (row != p && col != q) {
                    matData[i][j++] = m.get(row, col);

                    if (j == n - 1) {
                        j = 0;
                        i++;
                    }
                }
            }
        }

        return Matrix.from(Arrays.stream(matData).flatMap(Arrays::stream).collect(Collectors.toList()), n - 1, n - 1);
    }

    public static Matrix adj(Matrix m) {
        if(!m.isNumeric())
            throw new Error("'mat-adjoint' expects a numeric matrix.");
        if(m.getRows() != m.getCols())
            throw new Error("'mat-adjoint' expects a square matrix.");
        return Matrix.of((row, col) -> {
            Matrix cfm = getCofactor(m, row, col);
            int sign = (row + col) % 2 == 0 ? 1 : -1;
            return Product.mul2(Determinant.det(cfm), new Atom(new BigDecimal(sign)));
        }, m.getRows(), m.getCols()).transpose();
    }

    @Override
    public Atom apply(Executor env, List<Atom> arguments) {
        if(arguments.size() != 1)
            throw new Error("Invalid invocation to 'mat-adjoint'.");
        return new Atom(new LbcSupplier<>(() -> {
            arguments.get(0).guardType("First argument to 'mat-adjoint'", Type.MATRIX);
            return adj(arguments.get(0).getMatrix().get());
        }));
    }
}
