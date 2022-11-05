package palaiologos.kamilalisp.runtime.array;

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
        if(list.isEmpty())
            return identity;
        return Lists.reverse(list).stream().reduce(identity, (acc, x) -> Evaluation.evaluate(env, reductor, List.of(x, acc)));
    }

    @Override
    protected String name() {
        return "foldr";
    }
}
