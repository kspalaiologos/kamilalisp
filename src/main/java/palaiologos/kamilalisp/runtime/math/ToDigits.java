package palaiologos.kamilalisp.runtime.math;

import com.google.common.collect.Lists;
import palaiologos.kamilalisp.atom.*;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

public class ToDigits extends PrimitiveFunction implements Lambda {

    private static Atom toDigits(BigInteger base, Atom arg) {
        if (arg.getType() == Type.LIST) {
            ArrayList<Atom> list = new ArrayList<>();
            for (Atom x : arg.getList()) {
                Atom atom = toDigits(base, x);
                list.add(atom);
            }
            return new Atom(list);
        }
        else if (arg.getType() == Type.INTEGER) {
            ArrayList<Atom> result = new ArrayList<>();
            BigInteger x = arg.getInteger();
            while (x.compareTo(BigInteger.ZERO) > 0) {
                result.add(new Atom(x.mod(base)));
                x = x.divide(base);
            }
            return new Atom(Lists.reverse(result));
        } else
            throw new RuntimeException("Invalid argument type");
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        BigInteger base = args.get(0).getInteger();
        return toDigits(base, args.get(1));
    }

    @Override
    protected String name() {
        return "to-digits";
    }
}
