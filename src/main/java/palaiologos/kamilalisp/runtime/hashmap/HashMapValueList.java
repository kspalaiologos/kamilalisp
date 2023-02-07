package palaiologos.kamilalisp.runtime.hashmap;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.List;

public class HashMapValueList extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() != 1)
            throw new RuntimeException("hashmap:value-list expects 1 arguments.");
        if (!args.get(0).isUserdata(HashMapUserData.class))
            throw new RuntimeException("hashmap:value-list expects a hashmap as an argument.");
        HashMapUserData data = args.get(0).getUserdata(HashMapUserData.class);
        return new Atom(data.value().values().stream().toList());
    }

    @Override
    protected String name() {
        return "hashmap:value-list";
    }
}
