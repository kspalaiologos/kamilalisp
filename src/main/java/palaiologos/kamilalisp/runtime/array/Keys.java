package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.*;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.stream.IntStream;

public class Keys extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.size() != 1) {
            throw new RuntimeException("Wrong number of arguments to list:keys: expected 1, got " + args.size());
        }

        List<Atom> data;
        args.get(0).assertTypes(Type.LIST);
        data = args.get(0).getList();

        // Use groupingBy.
        HashMap<Atom, List<Atom>> counts = new HashMap<>();
        for(int i = 0; i < data.size(); i++) {
            Atom key = data.get(i);
            if(counts.containsKey(key)) {
                counts.get(key).add(new Atom(BigInteger.valueOf(i)));
            } else {
                List<Atom> list = new ArrayList<>();
                list.add(new Atom(BigInteger.valueOf(i)));
                counts.put(key, list);
            }
        }

        return new Atom(counts.entrySet().stream().map(x -> new Atom(List.of(x.getKey(), new Atom(x.getValue())))).toList());
    }

    @Override
    protected String name() {
        return "list:keys";
    }
}
