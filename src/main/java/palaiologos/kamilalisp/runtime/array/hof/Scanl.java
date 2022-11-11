package palaiologos.kamilalisp.runtime.array.hof;

import palaiologos.kamilalisp.atom.*;

import java.util.ArrayList;
import java.util.List;

public class Scanl extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 3);
        Callable reductor = args.get(0).getCallable();
        Atom identity = args.get(1);
        List<Atom> list = args.get(2).getList();
        if(list.isEmpty())
            return identity;
        // Reduce and keep intermediate results.
        List<Atom> result = new ArrayList<>();
        result.add(identity);
        Atom accumulator = identity;
        for(Atom x : list) {
            accumulator = Evaluation.evaluate(env, reductor, List.of(accumulator, x));
            result.add(accumulator);
        }
        return new Atom(result);
    }

    @Override
    protected String name() {
        return "scanl";
    }
}
