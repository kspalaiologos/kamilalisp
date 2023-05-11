package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class Append extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        // 0. Check if there are any arguments.
        if (args.isEmpty())
            return Atom.NULL;
        // 1. Assert that all types are either string or list.
        for (Atom arg : args) {
            if (arg.getType() != Type.STRING && arg.getType() != Type.LIST) {
                throw new TypeError("Expected all arguments to be either strings or lists.");
            }
        }
        // 2. Check if all types are the same.
        long count = 0L;
        Set<Type> uniqueValues = new HashSet<>();
        for (Atom arg : args) {
            Type type = arg.getType();
            if (uniqueValues.add(type)) {
                count++;
            }
        }
        if (count != 1)
            throw new TypeError("Expected all arguments to be of the same type.");
        if (args.get(0).getType() == Type.STRING) {
            StringBuilder acc = new StringBuilder();
            for (Atom arg : args) {
                String string = arg.getString();
                acc.append(string);
            }
            return new Atom(acc.toString());
        }
        else {
            ArrayList<Atom> list = new ArrayList<>();
            for (Atom a : args) {
                list.addAll(a.getList());
            }
            return new Atom(list);
        }
    }

    @Override
    protected String name() {
        return "append";
    }
}
