package palaiologos.kamilalisp.runtime.array;

import com.google.common.collect.Lists;
import palaiologos.kamilalisp.atom.*;

import java.util.List;
import java.util.stream.Collectors;

public class Reverse extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.isEmpty()) {
            throw new RuntimeException("Expected one or more arguments to `reverse'.");
        }

        if (args.size() == 1) {
            args.get(0).assertTypes(Type.LIST, Type.STRING);
            if ((args.get(0).getType() == Type.LIST && args.get(0).getList().size() <= 1)
                    || (args.get(0).getType() == Type.STRING && args.get(0).getString().length() <= 1))
                return args.get(0);
            if (args.get(0).getType() == Type.LIST)
                return new Atom(Lists.reverse(args.get(0).getList()));
            else
                return new Atom(new StringBuilder(args.get(0).getString()).reverse().toString());
        } else {
            args.forEach(a -> a.assertTypes(Type.LIST, Type.STRING));
            return new Atom(args.stream().map(l -> {
                if ((l.getType() == Type.LIST && l.getList().size() <= 1)
                        || (l.getType() == Type.STRING && l.getString().length() <= 1))
                    return l;
                if (l.getType() == Type.LIST)
                    return new Atom(Lists.reverse(l.getList()));
                else
                    return new Atom(new StringBuilder(l.getString()).reverse().toString());
            }).collect(Collectors.toList()));
        }
    }

    @Override
    protected String name() {
        return "reverse";
    }
}
