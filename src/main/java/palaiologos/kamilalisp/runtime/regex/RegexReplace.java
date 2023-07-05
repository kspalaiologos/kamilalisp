package palaiologos.kamilalisp.runtime.regex;

import org.pcollections.HashTreePMap;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;
import palaiologos.kamilalisp.runtime.hashmap.HashMapUserData;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.IntStream;

public class RegexReplace extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 3);
        if(args.get(2).getType().equals(Type.CALLABLE)) {
            String regex = args.get(0).getString();
            String string = args.get(1).getString();
            Callable functor = args.get(2).getCallable();
            Pattern pattern = PatternCache.get(regex);
            Matcher matcher = pattern.matcher(string);

            Atom offset = new Atom("offset", false);
            Atom length = new Atom("length", false);
            Atom match = new Atom("match", false);
            Atom groups = new Atom("groups", false);

            return new Atom(matcher.replaceFirst(matchResult -> {
                HashMap<Atom, Atom> bindings = new HashMap<>();
                bindings.put(offset, new Atom(BigInteger.valueOf(matchResult.start())));
                bindings.put(length, new Atom(BigInteger.valueOf(matchResult.end() - matchResult.start())));
                List<Atom> matchGroups = new ArrayList<>();
                for (int i = 0; i < matchResult.groupCount(); i++) {
                    HashMap<Atom, Atom> group = new HashMap<>();
                    group.put(offset, new Atom(BigInteger.valueOf(matchResult.start(i))));
                    group.put(length, new Atom(BigInteger.valueOf(matchResult.end(i) - matchResult.start(i))));
                    group.put(match, new Atom(matchResult.group(i)));
                    matchGroups.add(new Atom(new HashMapUserData(HashTreePMap.from(group))));
                }
                bindings.put(match, new Atom(matchResult.group()));
                bindings.put(groups, new Atom(matchGroups));
                return Evaluation.evaluate(env, functor, List.of(new Atom(new HashMapUserData(HashTreePMap.from(bindings))))).getString();
            }));
        } else if(args.get(2).getType() == Type.STRING) {
            String regex = args.get(0).getString();
            String string = args.get(1).getString();
            String replacement = args.get(2).getString();
            Pattern pattern = PatternCache.get(regex);
            Matcher matcher = pattern.matcher(string);
            return new Atom(matcher.replaceFirst(replacement));
        } else {
            throw new TypeError("Third argument must be a string or a function");
        }
    }

    @Override
    protected String name() {
        return "regex:replace-first";
    }
}
