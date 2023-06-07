package palaiologos.kamilalisp.runtime.math.prime;

import org.pcollections.HashTreePMap;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.runtime.hashmap.HashMapUserData;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class PrimeMap extends PrimitiveFunction implements Lambda {
    private static Atom factor(Atom a) {
        if (a.getType() == Type.INTEGER) {
            if (a.getInteger().compareTo(BigInteger.TWO) < 0)
                throw new ArithmeticException("prime:factor-map not defined for integers less than 2");
            var x = PollardRhoStateManager.factorMap(a.getInteger());
            HashMap<Atom, Atom> map = new HashMap<>();
            for (BigInteger bigInteger : x.keySet()) {
                Atom key = new Atom(bigInteger);
                Atom value = new Atom(x.get(bigInteger));
                map.put(key, value);
            }
            return new Atom(new HashMapUserData(HashTreePMap.from(map)));
        } else if (a.getType() == Type.LIST) {
            List<Atom> list = new ArrayList<>();
            for (Atom atom : a.getList()) {
                Atom factor = factor(atom);
                list.add(factor);
            }
            return new Atom(list);
        } else {
            throw new UnsupportedOperationException("prime:factor-map not defined for: " + a.getType());
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.isEmpty()) {
            throw new RuntimeException("prime:factor-map called with no arguments.");
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
        return "prime:factor-map";
    }
}
