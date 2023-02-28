package palaiologos.kamilalisp.runtime.IO;

import com.google.common.collect.Lists;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

public class EncodeBE extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        BigInteger number = args.get(0).getInteger();
        List<Atom> bytes = new ArrayList<>();
        while (number.compareTo(BigInteger.ZERO) > 0) {
            bytes.add(new Atom(number.and(BigInteger.valueOf(0xFF))));
            number = number.shiftRight(8);
        }
        return new Atom(Lists.reverse(bytes));
    }

    @Override
    protected String name() {
        return "io:encode-be";
    }
}
