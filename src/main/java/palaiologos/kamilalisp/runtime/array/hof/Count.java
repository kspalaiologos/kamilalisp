package palaiologos.kamilalisp.runtime.array.hof;

import palaiologos.kamilalisp.atom.*;

import java.math.BigInteger;
import java.util.List;

public class Count extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        Callable reductor = args.get(0).getCallable();
        if (args.get(1).getType() == Type.LIST) {
            List<Atom> list = args.get(1).getList();
            return new Atom(BigInteger.valueOf(list.stream().filter(x -> Evaluation.evaluate(env, reductor, List.of(x)).coerceBool()).count()));
        } else if (args.get(1).getType() == Type.STRING) {
            String str = args.get(1).getString();
            return new Atom(BigInteger.valueOf(str.chars().filter(x -> Evaluation.evaluate(env, reductor, List.of(new Atom(String.valueOf((char) x)))).coerceBool()).count()));
        } else {
            throw new UnsupportedOperationException("count not defined for: " + args.get(1).getType());
        }
    }

    @Override
    protected String name() {
        return "count";
    }
}
