package palaiologos.kamilalisp.runtime.hashmap;

import org.pcollections.HashPMap;
import palaiologos.kamilalisp.atom.*;

import java.util.List;

public class HashMapMerge extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() != 2 && args.size() != 3)
            throw new RuntimeException("hashmap:merge expects 2 or 3 arguments.");
        if (args.size() == 2) {
            if (!args.get(0).isUserdata(HashMapUserData.class) || !args.get(1).isUserdata(HashMapUserData.class))
                throw new RuntimeException("hashmap:merge expects a hashmap as an argument.");
            HashMapUserData data = args.get(0).getUserdata(HashMapUserData.class);
            HashMapUserData data2 = args.get(1).getUserdata(HashMapUserData.class);
            return new Atom(new HashMapUserData(data.value().plusAll(data2.value())));
        } else {
            if (!args.get(0).isUserdata(HashMapUserData.class) || !args.get(1).isUserdata(HashMapUserData.class) || args.get(2).getType() != Type.CALLABLE)
                throw new RuntimeException("hashmap:merge expects a hashmap and a lambda as arguments.");
            HashPMap<Atom, Atom> data = args.get(0).getUserdata(HashMapUserData.class).value();
            HashMapUserData data2 = args.get(1).getUserdata(HashMapUserData.class);
            Callable lambda = args.get(2).getCallable();
            for (Atom key : data2.value().keySet()) {
                if (data.containsKey(key)) {
                    data = data.plus(key, lambda.apply(env, List.of(key, data.get(key), data2.value().get(key))));
                } else {
                    data = data.plus(key, data2.value().get(key));
                }
            }
            return new Atom(new HashMapUserData(data));
        }
    }

    @Override
    protected String name() {
        return "hashmap:merge";
    }
}
