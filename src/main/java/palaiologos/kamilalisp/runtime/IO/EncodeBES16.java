package palaiologos.kamilalisp.runtime.IO;

import com.google.common.primitives.Shorts;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

public class EncodeBES16 extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        long number = args.get(0).getInteger().longValue();
        byte[] data = Shorts.toByteArray((short) number);
        List<Atom> bytes = new ArrayList<>();
        for (byte x : data) {
            bytes.add(new Atom(BigInteger.valueOf(x)));
        }
        return new Atom(bytes);
    }

    @Override
    protected String name() {
        return "io:encode-be-s16";
    }
}
