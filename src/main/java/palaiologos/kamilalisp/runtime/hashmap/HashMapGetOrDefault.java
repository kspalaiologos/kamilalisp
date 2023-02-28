package palaiologos.kamilalisp.runtime.hashmap;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.List;

public class HashMapGetOrDefault extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() != 3)
            throw new RuntimeException("hashmap:get-or expects 3 arguments.");
        if (!args.get(0).isUserdata(HashMapUserData.class))
            throw new RuntimeException("hashmap:get-or expects a hashmap as an argument.");
        HashMapUserData data = args.get(0).getUserdata(HashMapUserData.class);
        Atom key = args.get(1);
        Atom def = args.get(2);
        return data.value().getOrDefault(key, def);
    }

    @Override
    protected String name() {
        return "hashmap:get-or";
    }
}
