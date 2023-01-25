package palaiologos.kamilalisp.runtime.hashmap;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.List;

public class HashMapContainsKey extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.size() != 2)
            throw new RuntimeException("hashmap:contains-key? expects 2 arguments.");
        if(!args.get(0).isUserdata(HashMapUserData.class))
            throw new RuntimeException("hashmap:contains-key? expects a hashmap as an argument.");
        HashMapUserData data = args.get(0).getUserdata(HashMapUserData.class);
        Atom key = args.get(1);
        return data.value.containsKey(key) ? Atom.TRUE : Atom.FALSE;
    }

    @Override
    protected String name() {
        return "hashmap:contains-key?";
    }
}
