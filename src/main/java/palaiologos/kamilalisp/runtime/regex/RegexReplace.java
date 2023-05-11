package palaiologos.kamilalisp.runtime.regex;

import palaiologos.kamilalisp.atom.*;

import java.math.BigInteger;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.IntStream;

public class RegexReplace extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 3);
        String regex = args.get(0).getString();
        String string = args.get(1).getString();
        String replacement = args.get(2).getString();
        Pattern pattern = PatternCache.get(regex);
        Matcher matcher = pattern.matcher(string);
        return new Atom(matcher.replaceAll(replacement));
    }

    @Override
    protected String name() {
        return "regex:replace";
    }
}
