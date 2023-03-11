package palaiologos.kamilalisp.runtime.hashmap;

import org.pcollections.HashTreePMap;
import palaiologos.kamilalisp.atom.*;

import java.util.HashMap;
import java.util.List;

public class HashMapProcess extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() != 2)
            throw new RuntimeException("hashmap:process expects 2 arguments.");
        if (!args.get(0).isUserdata(HashMapUserData.class))
            throw new RuntimeException("hashmap:process expects a hashmap as an argument.");
        return new Atom(new HashMapUserData(HashTreePMap.from(
                Evaluation.evaluate(env, args.get(1).getCallable(), List.of(
                        new Atom(args.get(0).getUserdata(HashMapUserData.class).value()
                                .entrySet().stream().map(x -> new Atom(List.of(x.getKey(), x.getValue())))
                                .toList()))).getList().stream()
                        .collect(HashMap<Atom, Atom>::new, (m, x) ->
                                m.put(x.getList().get(0), x.getList().get(1)), HashMap::putAll))));
    }

    @Override
    protected String name() {
        return "hashmap:process";
    }
}
