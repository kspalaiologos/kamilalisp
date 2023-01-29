package palaiologos.kamilalisp.runtime.hashmap;

import org.pcollections.HashTreePMap;
import palaiologos.kamilalisp.atom.*;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class HashMapGroup extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() != 1) {
            throw new RuntimeException("Wrong number of arguments to hashmap:group - expected 1, got " + args.size());
        }

        List<Atom> data;
        args.get(0).assertTypes(Type.LIST);
        data = args.get(0).getList();

        // Use groupingBy.
        HashMap<Atom, Atom> counts = new HashMap<>();
        for (int i = 0; i < data.size(); i++) {
            Atom key = data.get(i);
            if (counts.containsKey(key)) {
                counts.get(key).getList().add(new Atom(BigInteger.valueOf(i)));
            } else {
                List<Atom> list = new ArrayList<>();
                list.add(new Atom(BigInteger.valueOf(i)));
                counts.put(key, new Atom(list));
            }
        }

        return new Atom(new HashMapUserData(HashTreePMap.from(counts)));
    }

    @Override
    protected String name() {
        return "hashmap:group";
    }
}
