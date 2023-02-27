package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.*;

import java.math.BigInteger;
import java.util.List;

public class Rank extends PrimitiveFunction implements Lambda {
    public static boolean isScalar(Atom w) {
        if(w.getType() != Type.LIST)
            return true;
        if(w.getList().isEmpty())
            return false;
        return w.getList().get(0).getType() == Type.CALLABLE && w.getList().get(0).getCallable() instanceof ReactiveFunction && w.getList().size() == 1;
    }

    public static int computeRank(Atom w) {
        if (isScalar(w))
            return 0;
        else if (w.getList().stream().allMatch(Rank::isScalar))
            return 1;
        boolean first = true;
        boolean uneven = false;
        int sub = 0;
        for (Atom v : w.getList()) {
            int cd = computeRank(v);
            if (cd < 0) {
                uneven = true;
                cd = -cd;
            }
            if (first) {
                first = false;
                sub = cd;
            } else if (sub != cd) {
                sub = Math.max(sub, cd);
                uneven = true;
            }
        }
        sub++;
        return uneven ? -sub : sub;
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
