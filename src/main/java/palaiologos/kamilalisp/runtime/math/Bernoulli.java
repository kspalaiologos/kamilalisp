package palaiologos.kamilalisp.runtime.math;

import ch.obermuhlner.math.big.BigRational;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.List;

public class Bernoulli extends PrimitiveFunction implements Lambda {
    private static Atom bernoulli(Environment e, Atom a) {
        return new Atom(BigRational.bernoulli(a.getInteger().intValueExact()).toBigDecimal(e.getMathContext()));
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() == 1)
            return bernoulli(env, args.get(0));
        else
            return new Atom(args.stream().map(x -> bernoulli(env, x)).toList());
    }

    @Override
    protected String name() {
        return "bernoulli";
    }
}
