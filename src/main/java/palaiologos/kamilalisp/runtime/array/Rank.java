package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.*;

import java.math.BigInteger;
import java.util.List;

public class Rank extends PrimitiveFunction implements Lambda {
    public static int computeRank(Atom atom) {
        if (atom.getType() == Type.LIST) {
            // Compute the ranks of all elements in the list. Take the minimum one.
            return 1 + atom.getList().stream().map(Rank::computeRank).min(Integer::compareTo).orElse(0);
        } else {
            return 0;
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        return new Atom(BigInteger.valueOf(computeRank(args.get(0))));
    }

    @Override
    protected String name() {
        return "rank";
    }
}
