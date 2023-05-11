package palaiologos.kamilalisp.runtime.array.hof;

import palaiologos.kamilalisp.atom.*;

import java.util.List;

public class Foldl extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 3);
        Callable reductor = args.get(0).getCallable();
        Atom identity = args.get(1);
        List<Atom> list = args.get(2).getList();
        if (list.isEmpty())
            return identity;
        Atom acc = identity;
        for (Atom atom : list)
            acc = Evaluation.evaluate(env, reductor, List.of(acc, atom));
        return acc;
    }

    @Override
    protected String name() {
        return "foldl";
    }
}
