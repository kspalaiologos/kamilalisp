package palaiologos.kamilalisp.runtime.math.bit;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

public class BitUnpack extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() < 2)
            throw new RuntimeException("Expected at least 2 arguments.");
        BigInteger number = args.get(0).getInteger();
        if (args.size() == 2) {
            BigInteger start = args.get(1).getList().get(0).getInteger();
            BigInteger end = args.get(1).getList().get(1).getInteger();
            return new Atom(number.shiftRight(start.intValue()).and(BigInteger.ONE.shiftLeft(end.intValue() - start.intValue()).subtract(BigInteger.ONE)));
        } else {
            List<Atom> results = new ArrayList<>();
            for (int i = 1; i < args.size(); i++) {
                BigInteger start = args.get(i).getList().get(0).getInteger();
                BigInteger end = args.get(i).getList().get(1).getInteger();
                results.add(new Atom(number.shiftRight(start.intValue()).and(BigInteger.ONE.shiftLeft(end.intValue() - start.intValue()).subtract(BigInteger.ONE))));
            }
            return new Atom(results);
        }
    }

    @Override
    protected String name() {
        return "bit:unpack";
    }
}
