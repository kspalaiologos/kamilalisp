package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.*;

import java.util.ArrayList;
import java.util.List;

public class Sort extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() == 1) {
            List<Atom> list = new ArrayList<>(args.get(0).getList());
            list.sort(Atom::compareTo);
            return new Atom(list);
        } else if (args.size() == 2) {
            List<Atom> list = new ArrayList<>(args.get(1).getList());
            Callable reductor = args.get(0).getCallable();
            list.sort((x, y) -> Evaluation.evaluate(env, reductor, List.of(x, y)).getInteger().intValueExact());
            return new Atom(list);
        } else {
            throw new RuntimeException("Wrong number of arguments to sort-asc: expected 1 or 2, got " + args.size());
        }
    }

    @Override
    protected String name() {
        return "sort-asc";
    }
}
