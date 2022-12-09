package palaiologos.kamilalisp.runtime.regex;

import palaiologos.kamilalisp.atom.*;

import java.math.BigInteger;
import java.util.Arrays;
import java.util.List;
import java.util.function.Function;
import java.util.regex.MatchResult;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.IntStream;

public class RegexSplit extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 3);
        String regex = args.get(0).getString();
        String string = args.get(1).getString();
        return new Atom(Arrays.stream(string.split(regex)).map(Atom::new).toList());
    }

    @Override
    protected String name() {
        return "regex:split";
    }
}
