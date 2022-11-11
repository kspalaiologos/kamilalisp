package palaiologos.kamilalisp.runtime.array.hof;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.util.ArrayList;
import java.util.List;

public class Scanl1 extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        Callable reductor = args.get(0).getCallable();
        List<Atom> list = args.get(1).getList();
        if (list.size() <= 1)
            throw new TypeError("scanl1: list of size " + list.size() + " can not be scanned.");
        // Reduce and keep intermediate results.
        List<Atom> result = new ArrayList<>();
        result.add(list.get(0));
        Atom accumulator = list.get(0);
        for (int i = 1; i < list.size(); i++) {
            accumulator = Evaluation.evaluate(env, reductor, List.of(accumulator, list.get(i)));
            result.add(accumulator);
        }
        return new Atom(result);
    }

    @Override
    protected String name() {
        return "scanl1";
    }
}
