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
            long count = 0L;
            for (Atom x : list) {
                if (Evaluation.evaluate(env, reductor, List.of(x)).coerceBool()) {
                    count++;
                }
            }
            return new Atom(BigInteger.valueOf(count));
        } else if (args.get(1).getType() == Type.STRING) {
            String str = args.get(1).getString();
            int len = str.length();
            long count = 0L;
            for(int i = 0; i < len; i++) {
                if(Evaluation.evaluate(env, reductor, List.of(Atom.fromChar(str.charAt(i)))).coerceBool()) {
                    count++;
                }
            }
            return new Atom(BigInteger.valueOf(count));
        } else {
            throw new UnsupportedOperationException("count not defined for: " + args.get(1).getType());
        }
    }

    @Override
    protected String name() {
        return "count";
    }
}
