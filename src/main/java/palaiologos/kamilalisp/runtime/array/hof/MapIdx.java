package palaiologos.kamilalisp.runtime.array.hof;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

public class MapIdx extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        Callable reductor = args.get(0).getCallable();
        if (args.get(1).getType() == Type.LIST) {
            List<Atom> list = args.get(1).getList();
            List<Atom> dest = new ArrayList<>();
            for (int i = 0; i < list.size(); i++) {
                dest.add(Evaluation.evaluate(env, reductor, List.of(new Atom(BigInteger.valueOf(i)), list.get(i))));
            }
            return new Atom(dest);
        } else if (args.get(1).getType() == Type.STRING) {
            String str = args.get(1).getString();
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < str.length(); i++) {
                sb.append(Evaluation.evaluate(env, reductor, List.of(new Atom(BigInteger.valueOf(i)), new Atom(String.valueOf(str.charAt(i))))).getString());
            }
            return new Atom(sb.toString());
        } else {
            throw new TypeError("Expected a list or a string as the second argument to `map-idx'.");
        }
    }

    @Override
    protected String name() {
        return "map-idx";
    }
}
