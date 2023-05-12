package palaiologos.kamilalisp.runtime.math;

import ch.obermuhlner.math.big.BigComplex;
import ch.obermuhlner.math.big.BigDecimalMath;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.util.ArrayList;
import java.util.List;

public class Pi extends PrimitiveFunction implements Lambda {
    private static Atom pi(Environment env, Atom x) {
        if (x.getType() == Type.REAL || x.getType() == Type.INTEGER)
            return new Atom(BigDecimalMath.pi(env.getMathContext()).multiply(x.getReal()));
        else if (x.getType() == Type.COMPLEX)
            return new Atom(BigComplex.valueOf(BigDecimalMath.pi(env.getMathContext())).multiply(x.getComplex()));
        else if (x.getType() == Type.LIST) {
            ArrayList<Atom> list = new ArrayList<>(x.getList().size());
            for (Atom y : x.getList()) {
                Atom pi = pi(env, y);
                list.add(pi);
            }
            return new Atom(list);
        }
        else
            throw new TypeError("`pi' not defined for: " + x.getType());
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.isEmpty())
            return new Atom(BigDecimalMath.pi(env.getMathContext()));
        else if (args.size() == 1)
            return pi(env, args.get(0));
        else {
            ArrayList<Atom> list = new ArrayList<>(args.size());
            for (Atom x : args) {
                Atom pi = pi(env, x);
                list.add(pi);
            }
            return new Atom(list);
        }
    }

    @Override
    protected String name() {
        return "pi";
    }
}
