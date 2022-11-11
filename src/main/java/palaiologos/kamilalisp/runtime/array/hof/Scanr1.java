package palaiologos.kamilalisp.runtime.array.hof;

import com.google.common.collect.Lists;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Stream;

public class Scanr1 extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        Callable reductor = args.get(0).getCallable();
        List<Atom> list = args.get(1).getList();
        if(list.size() <= 1)
            throw new TypeError("scanr1: list of size " + list.size() + " can not be scanned.");
        // Reduce and keep intermediate results.
        ArrayList<Atom> result = new ArrayList<>();
        for(int i = 1; i < list.size(); i++) {
            Lists.reverse(list.subList(0, i)).stream().reduce((acc, x) -> Evaluation.evaluate(env, reductor, List.of(x, acc))).ifPresent(result::add);
        }
        return new Atom(result);
    }

    @Override
    protected String name() {
        return "scanr1";
    }
}
