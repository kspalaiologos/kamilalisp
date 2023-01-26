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
            return new Atom(List.of(identity));
        // Reduce and keep intermediate results.
        ArrayList<Atom> result = new ArrayList<>();
        result.add(identity);
        for (int i = 0; i < list.size(); i++) {
            Atom accumulator = result.get(i);
            Atom x = list.get(i);
            result.add(Evaluation.evaluate(env, reductor, List.of(accumulator, x)));
        }
        return new Atom(Lists.reverse(result));
    }

    @Override
    protected String name() {
        return "scanr";
    }
}
