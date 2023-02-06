package palaiologos.kamilalisp.runtime.string;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Ucs extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        // ucs: takes/yields a list of integers.
        // contrary to ucb which works on byte arrays.
        assertArity(args, 1);
        Atom arg = args.get(0);
        switch (arg.getType()) {
            case LIST:
                return new Atom(arg.getList().stream().map(x -> x.getInteger().intValueExact()).collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append).toString());
            case STRING:
                return new Atom(arg.getString().codePoints().mapToObj(x -> new Atom(BigInteger.valueOf(x))).toList());
            default:
                throw new UnsupportedOperationException("ucs not defined for: " + arg.getType());
        }
    }

    @Override
    protected String name() {
        return "ucs";
    }
}
