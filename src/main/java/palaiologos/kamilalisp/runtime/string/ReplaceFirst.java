package palaiologos.kamilalisp.runtime.string;

import org.apache.commons.lang3.StringUtils;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.List;

public class ReplaceFirst extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 3);
        String string = args.get(1).getString();
        String src = args.get(0).getString();
        String dest = args.get(2).getString();
        return new Atom(StringUtils.replaceOnce(string, src, dest));
    }

    @Override
    protected String name() {
        return "str:replace-first";
    }
}
