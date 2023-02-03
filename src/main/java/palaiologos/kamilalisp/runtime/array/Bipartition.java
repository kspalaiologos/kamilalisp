package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.*;

import java.util.ArrayList;
import java.util.List;

public class Bipartition extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        Callable condition = args.get(0).getCallable();
        List<Atom> list = args.get(1).getList();
        List<Atom> left = new ArrayList<>();
        List<Atom> right = new ArrayList<>();

        for (Atom atom : list) {
            if (Evaluation.evaluate(env, condition, List.of(atom)).coerceBool()) {
                left.add(atom);
            } else {
                right.add(atom);
            }
        }

        return new Atom(List.of(new Atom(left), new Atom(right)));
    }

    @Override
    protected String name() {
        return "list:bipartition";
    }
}
