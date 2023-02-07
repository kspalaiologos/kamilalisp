package palaiologos.kamilalisp.runtime.math.bit;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.math.BigInteger;
import java.util.List;

public class BitPack extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() < 2)
            throw new RuntimeException("Expected at least 2 arguments.");
        if (args.size() == 2) {
            BigInteger start = args.get(1).getList().get(0).getInteger();
            BigInteger end = args.get(1).getList().get(1).getInteger();
            BigInteger value = args.get(1).getList().get(2).getInteger();
            BigInteger noBits = end.subtract(start);
            value = value.and(BigInteger.ONE.shiftLeft(noBits.intValue()).subtract(BigInteger.ONE));
            return new Atom(value.shiftLeft(start.intValue()));
        } else {
            BigInteger result = BigInteger.ZERO;
            for (int i = 0; i < args.size(); i++) {
                BigInteger start = args.get(i).getList().get(0).getInteger();
                BigInteger end = args.get(i).getList().get(1).getInteger();
                BigInteger value = args.get(i).getList().get(2).getInteger();
                BigInteger noBits = end.subtract(start);
                value = value.and(BigInteger.ONE.shiftLeft(noBits.intValue()).subtract(BigInteger.ONE));
                result = result.or(value.shiftLeft(start.intValue()));
            }
            return new Atom(result);
        }
    }

    @Override
    protected String name() {
        return "bit:pack";
    }
}
