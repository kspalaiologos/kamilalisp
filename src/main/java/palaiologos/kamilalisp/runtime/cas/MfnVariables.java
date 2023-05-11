package palaiologos.kamilalisp.runtime.cas;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.ArrayList;
import java.util.List;

public class MfnVariables extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        MathExpression f = args.get(0).getUserdata(MathExpression.class);
        ArrayList<Atom> list = new ArrayList<>();
        for (String x : f.getArgs()) {
            Atom atom = new Atom(x, true);
            list.add(atom);
        }
        return new Atom(list);
    }

    @Override
    protected String name() {
        return "cas:fn:vars";
    }
}
