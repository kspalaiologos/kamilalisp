package palaiologos.kamilalisp.runtime.array;

import com.google.common.collect.Lists;
import palaiologos.kamilalisp.atom.*;

import java.util.List;
import java.util.stream.Collectors;

public class Rotate extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() != 2) {
            throw new RuntimeException("Expected two arguments to `rotate'.");
        }

        int n = args.get(1).getInteger().intValueExact();
        List<Atom> list = args.get(0).getList();

        // rotate 2 (1 2 3 4 5) = (4 5 1 2 3)
        // rotate -2 (1 2 3 4 5) = (3 4 5 1 2)
        if(n > 0) {
            List<Atom> front = list.subList(0, n);
            List<Atom> back = list.subList(n, list.size());
            return new Atom(Lists.newArrayList(back).addAll(front));
        } else if(n == 0) {
            return args.get(0);
        } else {
            List<Atom> front = list.subList(0, list.size() + n);
            List<Atom> back = list.subList(list.size() + n, list.size());
            return new Atom(Lists.newArrayList(back).addAll(front));
        }
    }

    @Override
    protected String name() {
        return "rotate";
    }
}
