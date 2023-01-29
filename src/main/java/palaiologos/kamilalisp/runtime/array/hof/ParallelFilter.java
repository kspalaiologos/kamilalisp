package palaiologos.kamilalisp.runtime.array.hof;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.InterruptionError;

import java.util.List;

public class ParallelFilter extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        Callable reductor = args.get(0).getCallable();
        List<Atom> list = args.get(1).getList();
        return new Atom(list.stream().parallel().filter(x -> Evaluation.safeEvaluate(env, reductor, List.of(x), s -> {
            System.err.println(s);
            throw new InterruptionError();
        }).coerceBool()).toList());
    }

    @Override
    protected String name() {
        return "parallel-filter";
    }
}
