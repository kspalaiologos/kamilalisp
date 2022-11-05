package palaiologos.kamilalisp.runtime.math;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.List;

public class Neq extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.size() <= 1)
            throw new RuntimeException("/=: expected at least 2 arguments, got " + args.size() + ".");

        for(int i = 1; i < args.size(); i++) {
            if (args.get(i).equals(args.get(i - 1)))
                return new Atom(false);
        }

        return new Atom(true);
    }

    @Override
    protected String name() {
        return "/=";
    }
}
