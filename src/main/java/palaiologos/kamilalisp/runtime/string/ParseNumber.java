package palaiologos.kamilalisp.runtime.string;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.util.List;

public class ParseNumber extends PrimitiveFunction implements Lambda {
    private static Atom parse(Atom a) {
        a.assertTypes(Type.STRING);
        String str = a.getString();
        return Parser.parseNumber(str);
    }

    protected String name() {
        return "parse-number";
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() == 1) {
            return parse(args.get(0));
        } else if (args.isEmpty()) {
            throw new TypeError("Expected 1 or more arguments to `parse-number'.");
        } else {
            return new Atom(args.stream().map(ParseNumber::parse).toList());
        }
    }
}
