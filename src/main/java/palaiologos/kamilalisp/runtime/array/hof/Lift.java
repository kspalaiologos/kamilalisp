package palaiologos.kamilalisp.runtime.array.hof;

import palaiologos.kamilalisp.atom.*;

import java.util.List;

public class Lift extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        Callable fn = args.get(0).getCallable();
        List<Atom> arg = args.get(1).getList();
        return Evaluation.evaluate(env, fn, arg);
    }

    @Override
    protected String name() {
        return "lift";
    }
}
