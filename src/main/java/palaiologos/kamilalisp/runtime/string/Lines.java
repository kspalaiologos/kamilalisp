package palaiologos.kamilalisp.runtime.string;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.util.List;
import java.util.stream.Collectors;

public class Lines extends PrimitiveFunction implements Lambda {
    public static Atom lines1(Atom a) {
        a.assertTypes(Type.STRING, Type.LIST);
        if (a.getType() == Type.STRING) {
            return new Atom(a.getString().lines().map(Atom::new).collect(Collectors.toList()));
        } else if (a.getType() == Type.LIST) {
            return new Atom(a.getList().stream().map(Lines::lines1).collect(Collectors.toList()));
        } else {
            throw new TypeError("`str:lines' not defined for: " + a.getType());
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() == 1) {
            return lines1(args.get(0));
        } else if (args.size() == 0) {
            throw new TypeError("Expected 1 or more arguments to `str:lines'.");
        } else {
            return new Atom(args.stream().map(Lines::lines1).toList());
        }
    }

    @Override
    protected String name() {
        return "str:lines";
    }
}
