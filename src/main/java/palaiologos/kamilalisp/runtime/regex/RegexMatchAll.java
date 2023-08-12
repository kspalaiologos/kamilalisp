package palaiologos.kamilalisp.runtime.regex;

import org.pcollections.HashTreePMap;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.runtime.hashmap.HashMapUserData;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class RegexMatchAll extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 3);
        String regex = args.get(0).getString();
        String string = args.get(1).getString();
        Callable functor = args.get(2).getCallable();
        Pattern pattern = PatternCache.get(regex);
        Matcher matcher = pattern.matcher(string);

        List<Atom> result = new ArrayList<>();
        Atom offset = new Atom("offset", false);
        Atom length = new Atom("length", false);
        Atom match = new Atom("match", false);
        Atom groups = new Atom("groups", false);
        while(matcher.find()) {
            HashMap<Atom, Atom> bindings = new HashMap<>();
            bindings.put(offset, new Atom(BigInteger.valueOf(matcher.start())));
            bindings.put(length, new Atom(BigInteger.valueOf(matcher.end() - matcher.start())));
            List<Atom> matchGroups = new ArrayList<>();
            for(int i = 0; i < matcher.groupCount() + 1; i++) {
                HashMap<Atom, Atom> group = new HashMap<>();
                group.put(offset, new Atom(BigInteger.valueOf(matcher.start(i))));
                group.put(length, new Atom(BigInteger.valueOf(matcher.end(i) - matcher.start(i))));
                group.put(match, new Atom(matcher.group(i)));
                matchGroups.add(new Atom(new HashMapUserData(HashTreePMap.from(group))));
            }
            bindings.put(match, new Atom(matcher.group()));
            bindings.put(groups, new Atom(matchGroups));
            result.add(Evaluation.evaluate(env, functor, List.of(new Atom(new HashMapUserData(HashTreePMap.from(bindings))))));
        }
        return new Atom(result);
    }

    @Override
    protected String name() {
        return "regex:match-all";
    }
}
