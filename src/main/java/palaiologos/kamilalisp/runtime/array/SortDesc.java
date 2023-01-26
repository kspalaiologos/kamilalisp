package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.*;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

public class SortDesc extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() == 1) {
            List<Atom> list = new ArrayList<>();
            list.addAll(args.get(0).getList());
            list.sort(Comparator.reverseOrder());
            return new Atom(list);
        } else if (args.size() == 2) {
            List<Atom> list = new ArrayList<>();
            list.addAll(args.get(0).getList());
            Callable reductor = args.get(1).getCallable();
            list.sort((x, y) -> -Evaluation.evaluate(env, reductor, List.of(x, y)).getInteger().intValueExact());
            return new Atom(list);
        } else {
            throw new RuntimeException("Wrong number of arguments to sort-desc: expected 1 or 2, got " + args.size());
        }
    }

    @Override
    protected String name() {
        return "sort-desc";
    }
}
