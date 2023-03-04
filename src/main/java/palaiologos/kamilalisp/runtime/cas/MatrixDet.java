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

public class MatrixDet extends PrimitiveFunction implements Lambda {
    private static final Atom times = new Atom("*", true);

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

        Atom[][] A = l1.stream().map(x -> x.toArray(Atom[]::new)).toArray(Atom[][]::new);
        Atom[][] L = new Atom[A.length][A.length];
        Atom[][] U = new Atom[A.length][A.length];
        for (int i = 0; i < A.length; i++) {
            for (int j = 0; j < A.length; j++) {
                L[i][j] = new Atom(BigDecimal.ZERO);
                U[i][j] = new Atom(BigDecimal.ZERO);
            }
        }

        LinkedHashSet<String> vars = new LinkedHashSet<>();
        MatrixLUDecomposition.casLU(env, A, L, U, vars, false);

        // det(A) = det(L) * det(U)
        // det(L) = product of diagonal elements of L
        // det(U) = product of diagonal elements of U
        List<Atom> detData = new ArrayList<>();
        detData.add(times);
        for (int i = 0; i < A.length; i++) {
            detData.add(L[i][i].getUserdata(MathExpression.class).getData());
            detData.add(U[i][i].getUserdata(MathExpression.class).getData());
        }
        return new Atom(new MathExpression(env, vars, new Atom(detData)).simplify(env));
    }

    @Override
    public String name() {
        return "cas:matrix:det";
    }

}
