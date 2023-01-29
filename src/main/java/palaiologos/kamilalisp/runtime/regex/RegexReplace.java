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
        Atom replacement = args.get(2);
        Pattern pattern = PatternCache.get(regex);
        Matcher matcher = pattern.matcher(string);
        if (replacement.getType() == Type.CALLABLE) {
            String s = matcher.replaceAll(matchResult -> {
                List<Atom> groups = IntStream.range(0, matchResult.groupCount() + 1)
                        .mapToObj(matchResult::group)
                        .map(Atom::new)
                        .toList();
                List<Atom> begins = IntStream.range(0, matchResult.groupCount() + 1)
                        .mapToObj(matchResult::start)
                        .map(x -> new Atom(BigInteger.valueOf(x)))
                        .toList();
                List<Atom> ends = IntStream.range(0, matchResult.groupCount() + 1)
                        .mapToObj(matchResult::end)
                        .map(x -> new Atom(BigInteger.valueOf(x)))
                        .toList();
                List<Atom> args1 = List.of(new Atom(groups), new Atom(begins), new Atom(ends));
                return Evaluation.evaluate(env, replacement.getCallable(), args1).getString();
            });
            return new Atom(s);
        } else if (replacement.getType() == Type.STRING) {
            return new Atom(matcher.replaceAll(replacement.getString()));
        } else {
            throw new RuntimeException("Invalid replacement type: " + replacement.getType());
        }
    }

    @Override
    protected String name() {
        return "regex:replace";
    }
}
