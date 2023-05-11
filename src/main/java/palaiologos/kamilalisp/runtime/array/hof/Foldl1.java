package palaiologos.kamilalisp.runtime.array.hof;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.util.List;

public class Foldl1 extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        Callable reductor = args.get(0).getCallable();
        List<Atom> list = args.get(1).getList();
        if (list.size() < 1)
            throw new TypeError("foldl1: list of size 0 can not be folded.");
        Atom acc = list.get(0);
        for (int i = 1; i < list.size(); i++)
            acc = Evaluation.evaluate(env, reductor, List.of(acc, list.get(i)));
        return acc;
    }

    @Override
    protected String name() {
        return "foldl1";
    }
}
