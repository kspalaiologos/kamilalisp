package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.*;

import java.math.BigInteger;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

public class Bsearch extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        Atom a;
        List<Atom> list;
        Comparator<Atom> comparator;
        if(args.size() == 2) {
            a = args.get(0);
            list = args.get(1).getList();
            comparator = Comparator.naturalOrder();
        } else if(args.size() == 3) {
            a = args.get(0);
            list = args.get(1).getList();
            Callable lComparator = args.get(2).getCallable();
            comparator = (o1, o2) -> Evaluation.evaluate(env, lComparator, List.of(o1, o2)).getInteger().intValueExact();
        } else {
            throw new RuntimeException("Expected 2 or 3 arguments, got " + args.size());
        }
        return new Atom(BigInteger.valueOf(Collections.binarySearch(list, a, comparator)));
    }

    @Override
    protected String name() {
        return "bsearch";
    }
}
