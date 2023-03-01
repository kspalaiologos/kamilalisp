package palaiologos.kamilalisp.runtime.math.num;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.runtime.array.Rank;
import palaiologos.kamilalisp.runtime.math.Slash;
import palaiologos.kamilalisp.runtime.math.Star;

import java.util.List;

public class Inv extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        Atom a1 = args.get(0);
        if (Rank.computeRank(a1) != 2) {
            throw new RuntimeException("Expected a matrix of rank 2.");
        }

        List<List<Atom>> l1 = a1.getList().stream().map(Atom::getList).toList();
        Atom result = Det.det(env.getMathContext(), l1);
        return Star.multiply2(Slash.quot1(env, result), a1);
    }

    @Override
    protected String name() {
        return "num:invert";
    }
}
