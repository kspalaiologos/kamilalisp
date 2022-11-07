package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.*;

import java.util.List;

public class Any extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        Callable reductor = args.get(0).getCallable();
        List<Atom> list = args.get(1).getList();
        return new Atom(list.stream().anyMatch(x -> Evaluation.evaluate(env, reductor, List.of(x)).coerceBool()));
    }

    @Override
    protected String name() {
        return "any";
    }
}
