package palaiologos.kamilalisp.runtime.math;

import palaiologos.kamilalisp.atom.*;

import java.math.BigInteger;
import java.util.List;

public class FromDigits extends PrimitiveFunction implements Lambda {

    private static Atom toDigits(BigInteger base, List<Atom> arg) {
        if(arg.isEmpty())
            return new Atom(BigInteger.ZERO);

        for(Atom a : arg) {
            if(a.getType() != Type.INTEGER)
                throw new RuntimeException("Invalid argument type");
        }

        BigInteger result = BigInteger.ZERO;
        BigInteger multiplier = BigInteger.ONE;
        for(int i = arg.size() - 1; i >= 0; i--) {
            result = result.add(arg.get(i).getInteger().multiply(multiplier));
            multiplier = multiplier.multiply(base);
        }

        return new Atom(result);
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        BigInteger base = args.get(0).getInteger();
        return toDigits(base, args.get(1).getList());
    }

    @Override
    protected String name() {
        return "from-digits";
    }
}
