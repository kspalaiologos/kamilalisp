package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;
import palaiologos.kamilalisp.error.TypeError;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class Powerset extends PrimitiveFunction implements Lambda {
    private static <T> Set<Set<T>> powerSet(Set<T> originalSet) {
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
        List<Atom> result = new ArrayList<>();
        for (Set<Atom> x : powerSet(new HashSet<>(list))) {
            Atom atom = new Atom(new ArrayList<>(x));
            result.add(atom);
        }
        return new Atom(result);
    }

    @Override
    protected String name() {
        return "powerset";
    }
}
