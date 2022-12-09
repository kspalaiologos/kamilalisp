package palaiologos.kamilalisp.runtime.string;

import palaiologos.kamilalisp.atom.*;

import java.math.BigInteger;
import java.util.List;

public class Ucs extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        Atom arg = args.get(0);
        switch(arg.getType()) {
            case LIST:
                StringBuilder sb = new StringBuilder();
                for (Atom a : arg.getList()) {
                    sb.appendCodePoint(a.getInteger().intValue());
                }
                return new Atom(sb.toString());
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
