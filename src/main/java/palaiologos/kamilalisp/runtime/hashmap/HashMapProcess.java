package palaiologos.kamilalisp.runtime.hashmap;

import org.pcollections.HashTreePMap;
import palaiologos.kamilalisp.atom.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class HashMapProcess extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() != 2)
            throw new RuntimeException("hashmap:process expects 2 arguments.");
        if (!args.get(0).isUserdata(HashMapUserData.class))
            throw new RuntimeException("hashmap:process expects a hashmap as an argument.");
        HashMap<Atom, Atom> m = new HashMap<>();
        ArrayList<Atom> list = new ArrayList<>();
        for (Map.Entry<Atom, Atom> x : args.get(0).getUserdata(HashMapUserData.class).value().entrySet()) {
            list.add(new Atom(List.of(x.getKey(), x.getValue())));
        }
        for (Atom atom : Evaluation.evaluate(env, args.get(1).getCallable(), List.of(new Atom(list))).getList()) {
            m.put(atom.getList().get(0), atom.getList().get(1));
        }
        return new Atom(new HashMapUserData(HashTreePMap.from(m)));
    }

    @Override
    protected String name() {
        return "hashmap:process";
    }
}
