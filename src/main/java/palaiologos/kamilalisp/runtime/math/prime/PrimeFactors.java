package palaiologos.kamilalisp.runtime.math.prime;

import palaiologos.kamilalisp.atom.*;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

public class PrimeFactors extends PrimitiveFunction implements Lambda {
    private static Atom factor(Atom a) {
        if (a.getType() == Type.INTEGER) {
            if (a.getInteger().compareTo(BigInteger.TWO) < 0)
                throw new ArithmeticException("prime:factors not defined for integers less than 2");
            List<Atom> list = new ArrayList<>();
            var x = PollardRhoStateManager.factorList(a.getInteger());
            for (BigInteger bigInteger : x) {
                Atom atom = new Atom(bigInteger);
                list.add(atom);
            }
            return new Atom(list);
        } else if (a.getType() == Type.LIST) {
            List<Atom> list = new ArrayList<>();
            for (Atom atom : a.getList()) {
                Atom factor = factor(atom);
                list.add(factor);
            }
            return new Atom(list);
        } else {
            throw new UnsupportedOperationException("prime:factors not defined for: " + a.getType());
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.isEmpty()) {
            throw new RuntimeException("prime:factors called with no arguments.");
        }

        if (args.size() == 1) {
            return factor(args.get(0));
        }

        List<Atom> list = new ArrayList<>();
        for (Atom arg : args) {
            Atom factor = factor(arg);
            list.add(factor);
        }
        return new Atom(list);
    }

    @Override
    protected String name() {
        return "prime:factors";
    }
}
