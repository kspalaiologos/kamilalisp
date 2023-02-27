package palaiologos.kamilalisp.runtime.cas;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.List;

public class MfnVariables extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        MathExpression f = args.get(0).getUserdata(MathExpression.class);
        return new Atom(f.getArgs().stream().map(x -> new Atom(x, true)).toList());
    }

    @Override
    protected String name() {
        return "cas:fn:vars";
    }
}
