package palaiologos.kamilalisp.runtime.array.hof;

import com.google.common.collect.Lists;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.util.ArrayList;
import java.util.List;

public class Scanr1 extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        Callable reductor = args.get(0).getCallable();
        List<Atom> list = Lists.reverse(args.get(1).getList());
        if (list.size() <= 1)
            throw new TypeError("scanr1: list of size " + list.size() + " can not be scanned.");
        // Reduce and keep intermediate results.
        ArrayList<Atom> result = new ArrayList<>();
        result.add(list.get(0));
        result.add(Evaluation.evaluate(env, reductor, List.of(list.get(1), list.get(0))));
        for (int i = 0; i < list.size() - 2; i++) {
            Atom accumulator = result.get(i + 1);
            Atom x = list.get(i + 2);
            result.add(Evaluation.evaluate(env, reductor, List.of(x, accumulator)));
        }
        return new Atom(Lists.reverse(result));
    }

    @Override
    protected String name() {
        return "scanr1";
    }
}
