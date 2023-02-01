package palaiologos.kamilalisp.runtime.array;

import com.google.common.primitives.Chars;
import org.apache.commons.lang3.StringUtils;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.util.*;
import java.util.stream.Collectors;

public class Powerset extends PrimitiveFunction implements Lambda {
    public static <T> Set<Set<T>> powerSet(Set<T> originalSet) {
        Set<Set<T>> sets = new HashSet<Set<T>>();
        if (originalSet.isEmpty()) {
            sets.add(new HashSet<T>());
            return sets;
        }
        List<T> list = new ArrayList<T>(originalSet);
        T head = list.get(0);
        Set<T> rest = new HashSet<T>(list.subList(1, list.size()));
        for (Set<T> set : powerSet(rest)) {
            Set<T> newSet = new HashSet<T>();
            newSet.add(head);
            newSet.addAll(set);
            sets.add(newSet);
            sets.add(set);
        }
        return sets;
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() != 1)
            throw new TypeError("Expected 1 argument to `powerset'.");
        List<Atom> list = args.get(0).getList();
        return new Atom(powerSet(new HashSet<>(list)).stream().map(x -> new Atom(new ArrayList<>(x))).toList());
    }

    @Override
    protected String name() {
        return "powerset";
    }
}
