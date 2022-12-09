package palaiologos.kamilalisp.runtime.array.hof;

import palaiologos.kamilalisp.atom.*;

import java.util.List;

public class Converge extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        Callable reductor = args.get(0).getCallable();
        Atom seed = args.get(1);
        // run reductor on seed until the result does not change.
        Atom result = Evaluation.evaluate(env, reductor, List.of(seed));
        while (!result.equals(seed)) {
            seed = result;
            result = Evaluation.evaluate(env, reductor, List.of(seed));
        }
        return result;
    }

    @Override
    protected String name() {
        return "converge";
    }
}
