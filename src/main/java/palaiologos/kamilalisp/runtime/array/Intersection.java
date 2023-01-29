package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

public class Intersection extends PrimitiveFunction implements Lambda {
    @Override
    public String name() {
        return "intersection";
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() > 0) {
            HashSet<Atom> set = new HashSet<>(args.get(0).getList());
            for (int i = 1; i < args.size(); i++)
                set.retainAll(args.get(i).getList());
            return new Atom(new ArrayList<>(set));
        } else {
            return Atom.NULL;
        }
    }
}
