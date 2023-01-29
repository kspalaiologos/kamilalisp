package palaiologos.kamilalisp.runtime.hashmap;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.List;

public class HashMapWithout extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() != 3)
            throw new RuntimeException("hashmap:without expects 2 arguments.");
        if (!args.get(0).isUserdata(HashMapUserData.class) || !args.get(1).isUserdata(HashMapUserData.class))
            throw new RuntimeException("hashmap:without expects a hashmap as an argument.");
        HashMapUserData data = args.get(0).getUserdata(HashMapUserData.class);
        HashMapUserData data2 = args.get(1).getUserdata(HashMapUserData.class);
        return new Atom(new HashMapUserData(data.value.minusAll(data2.value.keySet())));
    }

    @Override
    protected String name() {
        return "hashmap:without";
    }
}
