package palaiologos.kamilalisp.runtime.array.hof;

import palaiologos.kamilalisp.atom.*;

import java.util.List;

public class DropWhile extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        Callable reductor = args.get(0).getCallable();
        List<Atom> list = args.get(1).getList();
        int idx = 0;
        while (idx < list.size() && Evaluation.evaluate(env, reductor, List.of(list.get(idx))).coerceBool()) {
            idx++;
        }
        return new Atom(list.subList(idx, list.size()));
    }

    @Override
    protected String name() {
        return "drop-while";
    }
}
