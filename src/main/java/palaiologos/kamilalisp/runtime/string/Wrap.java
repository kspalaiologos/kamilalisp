package palaiologos.kamilalisp.runtime.string;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.List;

public class Wrap extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        int width = args.get(0).getInteger().intValueExact();
        String str = args.get(1).getString();
        StringBuilder sb = new StringBuilder();
        int i = 0;
        while (i < str.length()) {
            if (i + width < str.length()) {
                sb.append(str, i, i + width);
                sb.append('\n');
                i += width;
            } else {
                sb.append(str, i, str.length());
                i = str.length();
            }
        }
        return new Atom(sb.toString());
    }

    @Override
    protected String name() {
        return "str:wrap";
    }
}
