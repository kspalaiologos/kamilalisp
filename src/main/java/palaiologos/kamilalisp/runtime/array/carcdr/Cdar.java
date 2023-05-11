package palaiologos.kamilalisp.runtime.array.carcdr;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.ArrayList;
import java.util.List;

public class Cdar extends PrimitiveFunction implements Lambda {
    @Override
    public String name() {
        return "cdar";
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() == 1) {
            return Cdr.INSTANCE.apply(env, List.of(Car.INSTANCE.apply(env, args)));
        } else {
            ArrayList<Atom> list = new ArrayList<>();
            for (Atom a : args) {
                Atom apply = Cdr.INSTANCE.apply(env, List.of(Car.INSTANCE.apply(env, List.of(a))));
                list.add(apply);
            }
            return new Atom(list);
        }
    }
}
