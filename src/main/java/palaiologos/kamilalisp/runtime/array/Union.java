package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

public class Union extends PrimitiveFunction implements Lambda {
    @Override
    public String name() {
        return "union";
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        HashSet<Atom> set = new HashSet<>();
        for (Atom arg : args)
            set.addAll(arg.getList());
        return new Atom(new ArrayList<>(set));
    }
}
