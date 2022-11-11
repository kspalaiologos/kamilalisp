package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.*;

import java.util.List;
import java.util.stream.Collectors;

public class Car extends PrimitiveFunction implements Lambda {
    private static Atom car(Atom a) {
        if (a.getType() == Type.LIST) {
            return a.getList().get(0);
        } else if (a.getType() == Type.STRING) {
            return new Atom(String.valueOf(a.getString().charAt(0)));
        } else {
            throw new UnsupportedOperationException("car not defined for: " + a.getType());
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.isEmpty()) {
            throw new RuntimeException("Expected one or more arguments to `car'.");
        }

        if (args.size() == 1) {
            return car(args.get(0));
        } else {
            return new Atom(args.stream().map(Car::car).collect(Collectors.toList()));
        }
    }

    @Override
    protected String name() {
        return "car";
    }
}
