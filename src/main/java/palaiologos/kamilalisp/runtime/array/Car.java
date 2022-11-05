package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.*;

import java.util.List;
import java.util.stream.Collectors;

public class Car extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.isEmpty()) {
            throw new RuntimeException("Expected one or more arguments to `car'.");
        }

        if(args.size() == 1) {
            args.get(0).assertTypes(Type.LIST);
            return args.get(0).getList().get(0);
        } else {
            args.forEach(a -> a.assertTypes(Type.LIST));
            return new Atom(args.stream().map(Atom::getList).map(l -> l.get(0)).collect(Collectors.toList()));
        }
    }

    @Override
    protected String name() {
        return "car";
    }
}
