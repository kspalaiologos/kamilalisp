package kamilalisp.libs.primitives.list;

import kamilalisp.data.*;

import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

public class Sort implements Closure {
    public static List<Atom> sort(List<Atom> x) {
        return x.stream().sorted(new AtomComparator()).collect(Collectors.toList());
    }

    public static List<Atom> sort(List<Atom> l, Callable c, Executor env) {
        return l.stream().sorted(new Comparator<Atom>() {
            @Override
            public int compare(Atom o1, Atom o2) {
                Atom r = c.apply(env, List.of(o1, o2));
                r.guardType("'sort' comparator", Type.NUMBER);
                return r.getNumber().get().intValue();
            }
        }).collect(Collectors.toList());
    }

    @Override
    public Atom apply(Executor env, List<Atom> arguments) {
        if(arguments.size() < 1)
            throw new Error("Invalid invocation to 'sort'.");
        return new Atom(new LbcSupplier<>(() -> {
            if(arguments.size() == 1 && arguments.get(0).getType() == Type.LIST) {
                return sort(arguments.get(0).getList().get());
            } else if(arguments.size() == 2 && arguments.get(0).isCallable() && arguments.get(1).getType() == Type.LIST) {
                Callable c = arguments.get(0).getCallable().get();
                List<Atom> l = arguments.get(1).getList().get();
                return sort(l, c, env);
            } else
                throw new Error("'sort' expects (closure, list) arguments or a list");
        }));
    }
}
