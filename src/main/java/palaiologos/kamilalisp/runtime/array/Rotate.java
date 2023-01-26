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

        int n = args.get(0).getInteger().intValueExact();
        List<Atom> list = args.get(1).getList();

        if(list.isEmpty())
            return args.get(1);
        else
            n %= list.size();

        // rotate 2 (1 2 3 4 5) = (4 5 1 2 3)
        // rotate -2 (1 2 3 4 5) = (3 4 5 1 2)
        if(n > 0) {
            List<Atom> front = list.subList(0, n);
            List<Atom> back = list.subList(n, list.size());
            List<Atom> result = Lists.newArrayList(back);
            result.addAll(front);
            return new Atom(result);
        } else if(n == 0) {
            return args.get(1);
        } else {
            List<Atom> front = list.subList(0, list.size() + n);
            List<Atom> back = list.subList(list.size() + n, list.size());
            List<Atom> result = Lists.newArrayList(back);
            result.addAll(front);
            return new Atom(result);
        }
    }

    @Override
    protected String name() {
        return "rotate";
    }
}
