package palaiologos.kamilalisp.runtime.regex;

import palaiologos.kamilalisp.atom.*;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class RegexMatches extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        String regex = args.get(0).getString();
        String string = args.get(1).getString();
        Pattern pattern = PatternCache.get(regex);
        Matcher matcher = pattern.matcher(string);
        return matcher.matches() ? Atom.TRUE : Atom.FALSE;
    }

    @Override
    protected String name() {
        return "regex:matches?";
    }
}
