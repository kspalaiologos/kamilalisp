package palaiologos.kamilalisp.runtime.hashmap;

import org.pcollections.HashTreePMap;
import palaiologos.kamilalisp.atom.*;

import java.util.HashMap;
import java.util.List;

public class HashMapFromList extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.size() != 1 && args.size() != 2)
            throw new RuntimeException("hashmap:from-list expects 1 or 2 arguments.");
        if(args.size() == 1) {
            args.get(0).assertTypes(Type.LIST);
            List<Atom> list = args.get(0).getList();
            HashMap<Atom, Atom> map = new HashMap<>();
            for (int i = 0; i < list.size(); i++)
                map.put(list.get(i).getList().get(0), list.get(i).getList().get(1));
            return new Atom(new HashMapUserData(HashTreePMap.from(map)));
        } else {
            args.get(0).assertTypes(Type.LIST);
            args.get(1).assertTypes(Type.LIST);
            List<Atom> keys = args.get(0).getList();
            List<Atom> values = args.get(1).getList();
            if(keys.size() != values.size())
                throw new RuntimeException("hashmap:from-list expects keys and values to be of the same size.");
            HashMap<Atom, Atom> map = new HashMap<>();
            for (int i = 0; i < keys.size(); i++)
                map.put(keys.get(i), values.get(i));
            return new Atom(new HashMapUserData(HashTreePMap.from(map)));
        }
    }

    @Override
    protected String name() {
        return "hashmap:from-list";
    }
}
