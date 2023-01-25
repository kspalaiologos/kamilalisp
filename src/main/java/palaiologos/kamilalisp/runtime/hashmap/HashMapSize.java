package palaiologos.kamilalisp.runtime.hashmap;

import org.pcollections.HashTreePMap;
import palaiologos.kamilalisp.atom.*;

import java.math.BigInteger;
import java.util.List;

public class HashMapSize extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.size() != 1)
            throw new RuntimeException("hashmap:size expects 1 arguments.");
        if(!args.get(0).isUserdata(HashMapUserData.class))
            throw new RuntimeException("hashmap:size expects a hashmap as an argument.");
        HashMapUserData data = args.get(0).getUserdata(HashMapUserData.class);
        return new Atom(BigInteger.valueOf(data.value.size()));
    }

    @Override
    protected String name() {
        return "hashmap:size";
    }
}
