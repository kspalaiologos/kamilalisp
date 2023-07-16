package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.*;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Group extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() != 1 && args.size() != 2) {
            throw new RuntimeException("Wrong number of arguments to group - expected 1 or 2, got " + args.size());
        }

        List<Atom> data;
        Callable functor = null;
        if(args.size() == 1) {
            args.get(0).assertTypes(Type.LIST);
            data = args.get(0).getList();
        } else {
            args.get(0).assertTypes(Type.CALLABLE);
            args.get(1).assertTypes(Type.LIST);
            functor = args.get(0).getCallable();
            data = args.get(1).getList();
        }

        HashMap<Atom, ArrayList<Atom>> counts = new HashMap<>();
        for (int i = 0; i < data.size(); i++) {
            Atom key = data.get(i);
            if (counts.containsKey(key)) {
                counts.get(key).add(new Atom(BigInteger.valueOf(i)));
            } else {
                ArrayList<Atom> list = new ArrayList<>();
                list.add(new Atom(BigInteger.valueOf(i)));
                counts.put(key, list);
            }
        }

        if(functor == null) {
            ArrayList<Atom> list = new ArrayList<>();
            for (Map.Entry<Atom, ArrayList<Atom>> x : counts.entrySet()) {
                Atom atom = new Atom(List.of(x.getKey(), new Atom(x.getValue())));
                list.add(atom);
            }
            return new Atom(list);
        } else {
            ArrayList<Atom> list = new ArrayList<>();
            for (Map.Entry<Atom, ArrayList<Atom>> x : counts.entrySet())
                list.add(Evaluation.evaluate(env, functor, List.of(x.getKey(), new Atom(x.getValue()))));
            return new Atom(list);
        }
    }

    @Override
    protected String name() {
        return "group";
    }
}
