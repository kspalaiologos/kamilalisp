package palaiologos.kamilalisp.runtime.hashmap;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.List;

public class HashMapAsList extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() != 1)
            throw new RuntimeException("hashmap:as-list expects 1 arguments.");
        if (!args.get(0).isUserdata(HashMapUserData.class))
            throw new RuntimeException("hashmap:as-list expects a hashmap as an argument.");
        HashMapUserData data = args.get(0).getUserdata(HashMapUserData.class);
        List<Atom> list = data.value().entrySet().stream().map(entry -> new Atom(List.of(entry.getKey(), entry.getValue()))).toList();
        return new Atom(list);
    }

    @Override
    protected String name() {
        return "hashmap:as-list";
    }
}
