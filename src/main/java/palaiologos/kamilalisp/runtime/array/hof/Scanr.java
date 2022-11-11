package palaiologos.kamilalisp.runtime.array.hof;

import com.google.common.collect.Lists;
import palaiologos.kamilalisp.atom.*;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Stream;

public class Scanr extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 3);
        Callable reductor = args.get(0).getCallable();
        Atom identity = args.get(1);
        List<Atom> list = Lists.reverse(args.get(2).getList());
        if (list.isEmpty())
            return identity;
        // Reduce and keep intermediate results.
        ArrayList<Atom> result = new ArrayList<>();
        for (int i = 1; i < list.size(); i++) {
            Stream.concat(Stream.of(identity), Lists.reverse(list.subList(0, i)).stream()).reduce((acc, x) -> Evaluation.evaluate(env, reductor, List.of(x, acc))).ifPresent(result::add);
        }
        return new Atom(result);
    }

    @Override
    protected String name() {
        return "scanr";
    }
}
