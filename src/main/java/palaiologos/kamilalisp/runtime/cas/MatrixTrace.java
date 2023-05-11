package palaiologos.kamilalisp.runtime.cas;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;
import palaiologos.kamilalisp.runtime.array.Rank;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.stream.IntStream;
import java.util.stream.Stream;

public class MatrixTrace extends PrimitiveFunction implements Lambda {

    private static final Atom plus = new Atom("+", true);

    private static Atom trace(Environment env, Atom matrix) {
        if (Rank.computeRank(matrix) != 2) {
            throw new RuntimeException("Expected a matrix of rank 2.");
        }

        List<List<Atom>> m = new ArrayList<>();
        for (Atom atom : matrix.getList()) {
            List<Atom> list = atom.getList();
            m.add(list);
        }

        int diagonalLen = Math.min(m.size(), m.get(0).size());
        if (diagonalLen == 0) {
            return new Atom(BigInteger.ZERO);
        }

        LinkedHashSet<String> vars = new LinkedHashSet<>();

        return new Atom(new MathExpression(env, vars,
                new Atom(Stream.concat(Stream.of(plus), IntStream.range(0, diagonalLen)
                                .mapToObj(i -> m.get(i).get(i))
                                .map(x -> {
                                    if (x.isUserdata(MathExpression.class)) {
                                        vars.addAll(x.getUserdata(MathExpression.class).getArgs());
                                        return x.getUserdata(MathExpression.class).getData();
                                    } else {
                                        return x;
                                    }
                                }))
                        .toList())));
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        return trace(env, args.get(0));
    }

    @Override
    public String name() {
        return "cas:matrix:trace";
    }
}
