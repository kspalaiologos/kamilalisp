package palaiologos.kamilalisp.runtime.IO;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.math.BigInteger;
import java.util.List;

public class DecodeBE extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        List<Integer> bytes = args.get(0).getList().stream().map(x -> x.getInteger().intValueExact()).toList();
        BigInteger result = BigInteger.ZERO;
        for (int i = 0; i < bytes.size(); i++) {
            result = result.or(BigInteger.valueOf(bytes.get(i)).shiftLeft((bytes.size() - i - 1) * 8));
        }
        return new Atom(result);
    }

    @Override
    protected String name() {
        return "io:decode-be";
    }
}
