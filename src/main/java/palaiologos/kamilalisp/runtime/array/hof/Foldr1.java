package palaiologos.kamilalisp.runtime.array.hof;

import com.google.common.collect.Lists;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.util.List;

public class Foldr1 extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        Callable reductor = args.get(0).getCallable();
        List<Atom> list = args.get(1).getList();
        if (list.size() <= 1)
            throw new TypeError("foldr1: list of size " + list.size() + " can not be folded.");
        return Lists.reverse(list).stream().reduce((acc, x) -> Evaluation.evaluate(env, reductor, List.of(x, acc))).get();
    }

    @Override
    protected String name() {
        return "foldr1";
    }
}
