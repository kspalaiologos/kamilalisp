package palaiologos.kamilalisp.runtime.array.carcdr;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.List;

public class Caar extends PrimitiveFunction implements Lambda {
    @Override
    public String name() {
        return "caar";
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.size() == 1) {
            return Car.INSTANCE.apply(env, List.of(Car.INSTANCE.apply(env, args)));
        } else {
            return new Atom(args.stream().map(a -> Car.INSTANCE.apply(env, List.of(Car.INSTANCE.apply(env, List.of(a))))).toList());
        }
    }
}
