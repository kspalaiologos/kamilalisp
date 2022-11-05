package palaiologos.kamilalisp.runtime.array;

import com.google.common.collect.Lists;
import palaiologos.kamilalisp.atom.*;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

public class Reverse extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.isEmpty()) {
            throw new RuntimeException("Expected one or more arguments to `reverse'.");
        }

        if(args.size() == 1) {
            args.get(0).assertTypes(Type.LIST);
            if(args.get(0).getList().size() <= 1)
                return args.get(0);
            return new Atom(Lists.reverse(args.get(0).getList()));
        } else {
            args.forEach(a -> a.assertTypes(Type.LIST));
            return new Atom(args.stream().map(l -> {
                if(l.getList().size() <= 1)
                    return l;
                return new Atom(Lists.reverse(l.getList()));
            }).collect(Collectors.toList()));
        }
    }

    @Override
    protected String name() {
        return "reverse";
    }
}
