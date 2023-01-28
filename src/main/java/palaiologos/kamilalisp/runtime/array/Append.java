package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.util.List;
import java.util.stream.Stream;

public class Append extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        // 0. Check if there are any arguments.
        if(args.isEmpty())
            return Atom.NULL;
        // 1. Assert that all types are either string or list.
        if(args.stream().anyMatch(a -> a.getType() != Type.STRING && a.getType() != Type.LIST))
            throw new TypeError("Expected all arguments to be either strings or lists.");
        // 2. Check if all types are the same.
        if(args.stream().map(Atom::getType).distinct().count() != 1)
            throw new TypeError("Expected all arguments to be of the same type.");
        if(args.get(0).getType() == Type.STRING)
            return new Atom(args.stream().map(Atom::getString).reduce("", String::concat));
        else
            return new Atom(args.stream().flatMap(a -> a.getList().stream()).toList());
    }

    @Override
    protected String name() {
        return "append";
    }
}
