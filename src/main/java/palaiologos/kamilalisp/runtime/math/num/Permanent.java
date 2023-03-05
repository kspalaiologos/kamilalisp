package palaiologos.kamilalisp.runtime.math.num;

import ch.obermuhlner.math.big.BigComplex;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.runtime.array.Rank;

import java.math.BigDecimal;
import java.util.List;

public class Permanent extends PrimitiveFunction implements Lambda {
    public static BigDecimal[][] minor(BigDecimal[][] a, int x, int y) {
        int length = a.length - 1;
        BigDecimal[][] result = new BigDecimal[length][length];
        for (int i = 0; i < length; i++)
            for (int j = 0; j < length; j++)
                if (i < x && j < y)
                    result[i][j] = a[i][j];
                else if (i >= x && j < y)
                    result[i][j] = a[i + 1][j];
                else if (i < x && j >= y)
                    result[i][j] = a[i][j + 1];
                else
                    result[i][j] = a[i + 1][j + 1];
        return result;
    }

    public static BigDecimal perm(BigDecimal[][] a) {
        if (a.length == 1) {
            return a[0][0];
        } else {
            BigDecimal sum = BigDecimal.ZERO;
            for (int i = 0; i < a.length; i++)
                sum = sum.add(a[0][i].multiply(perm(minor(a, 0, i))));
            return sum;
        }
    }

    public static BigComplex[][] minor(BigComplex[][] a, int x, int y) {
        int length = a.length - 1;
        BigComplex[][] result = new BigComplex[length][length];
        for (int i = 0; i < length; i++)
            for (int j = 0; j < length; j++)
                if (i < x && j < y)
                    result[i][j] = a[i][j];
                else if (i >= x && j < y)
                    result[i][j] = a[i + 1][j];
                else if (i < x && j >= y)
                    result[i][j] = a[i][j + 1];
                else
                    result[i][j] = a[i + 1][j + 1];
        return result;
    }

    public static BigComplex perm(BigComplex[][] a) {
        if (a.length == 1) {
            return a[0][0];
        } else {
            BigComplex sum = BigComplex.ZERO;
            for (int i = 0; i < a.length; i++)
                sum = sum.add(a[0][i].multiply(perm(minor(a, 0, i))));
            return sum;
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

        if (l1.isEmpty())
            throw new RuntimeException("Expected a non-empty matrix.");

        if (l1.stream().allMatch(x -> x.stream().allMatch(y -> y.getType() == Type.INTEGER || y.getType() == Type.REAL))) {
            BigDecimal[][] A = l1.stream().map(x -> x.stream().map(Atom::getReal).toArray(BigDecimal[]::new)).toArray(BigDecimal[][]::new);
            return new Atom(perm(A));
        } else {
            BigComplex[][] A = l1.stream().map(x -> x.stream().map(Atom::getComplex).toArray(BigComplex[]::new)).toArray(BigComplex[][]::new);
            return new Atom(perm(A));
        }
    }

    @Override
    protected String name() {
        return "num:permanent";
    }
}
