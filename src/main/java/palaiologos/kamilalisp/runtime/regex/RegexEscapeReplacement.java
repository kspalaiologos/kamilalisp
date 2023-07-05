package palaiologos.kamilalisp.runtime.regex;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class RegexEscapeReplacement extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        String s = args.get(0).getString();
        return new Atom(Matcher.quoteReplacement(s));
    }

    @Override
    protected String name() {
        return "regex:escape-replacement";
    }
}
