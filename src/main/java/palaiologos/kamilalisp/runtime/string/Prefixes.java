package palaiologos.kamilalisp.runtime.string;

import ch.obermuhlner.math.big.BigComplexMath;
import ch.obermuhlner.math.big.BigDecimalMath;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class Prefixes extends PrimitiveFunction implements Lambda {
    @Override
    protected String name() {
        return "prefixes";
    }

    private static Atom ln(Environment e, Atom a) {
        switch (a.getType()) {
            case LIST: {
                List<Atom> result = new ArrayList<>();
                List<Atom> orig = a.getList();
                for (int i = 0; i < orig.size(); i++) {
                    result.add(new Atom(orig.subList(0, i + 1)));
                }
                return new Atom(result);
            }
            case STRING: {
                String s = a.getString();
                List<Atom> result = new ArrayList<>();
                for (int i = 0; i < s.length(); i++) {
                    result.add(new Atom(s.substring(0, i + 1)));
                }
                return new Atom(result);
            }
            default:
                throw new UnsupportedOperationException("prefixes not defined for: " + a.getType());
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.isEmpty()) {
            throw new RuntimeException("prefixes called with no arguments.");
        }

        if (args.size() == 1) {
            return ln(env, args.get(0));
        }

        return new Atom(args.stream().map(x -> ln(env, x)).toList());
    }
}
