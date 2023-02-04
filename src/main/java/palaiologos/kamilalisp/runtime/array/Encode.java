package palaiologos.kamilalisp.runtime.array;

import com.google.common.collect.Lists;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

public class Encode extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        BigInteger base = args.get(0).getInteger();
        BigInteger n = args.get(1).getInteger();
        List<Atom> encoding = new ArrayList<>();
        while (n.compareTo(BigInteger.ZERO) > 0) {
            encoding.add(new Atom(n.mod(base)));
            n = n.divide(base);
        }
        if(encoding.isEmpty())
            encoding.add(new Atom(BigInteger.ZERO));
        return new Atom(Lists.reverse(encoding));
    }

    @Override
    protected String name() {
        return "encode";
    }
}
