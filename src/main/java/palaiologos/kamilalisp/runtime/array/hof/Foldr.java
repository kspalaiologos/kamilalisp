package palaiologos.kamilalisp.runtime.array.hof;

import com.google.common.collect.Lists;
import palaiologos.kamilalisp.atom.*;

import java.util.List;

public class Foldr extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 3);
        Callable reductor = args.get(0).getCallable();
        Atom identity = args.get(1);
        List<Atom> list = args.get(2).getList();
        if (list.isEmpty())
            return identity;
        Atom acc = identity;
        for (Atom atom : Lists.reverse(list)) {
            acc = Evaluation.evaluate(env, reductor, List.of(atom, acc));
        }
        return acc;
    }

    @Override
    protected String name() {
        return "foldr";
    }
}
