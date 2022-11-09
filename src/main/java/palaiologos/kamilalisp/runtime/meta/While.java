package palaiologos.kamilalisp.runtime.meta;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.math.BigInteger;
import java.util.List;

public class While extends PrimitiveFunction implements Lambda {

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.size() == 2) {
            Atom value = args.get(0);
            Callable body = args.get(1).getCallable();

            boolean doContinue;
            do {
                Atom result = Evaluation.evaluate(env, body, List.of(value));
                result.assertTypes(Type.LIST);
                List<Atom> list = result.getList();
                doContinue = list.get(0).coerceBool();
                value = list.get(1);
            } while(doContinue);

            return value;
        } else if(args.size() == 3) {
            Atom value = args.get(0);
            if(args.get(1).getType() == Type.CALLABLE) {
                Callable condition = args.get(1).getCallable();
                Callable body = args.get(2).getCallable();

                while (Evaluation.evaluate(env, condition, List.of(value)).coerceBool()) {
                    value = Evaluation.evaluate(env, body, List.of(value));
                }
            } else if(args.get(1).getType() == Type.INTEGER) {
                BigInteger count = args.get(1).getInteger();
                Callable body = args.get(2).getCallable();

                while ((count = count.subtract(BigInteger.ONE)).compareTo(BigInteger.ZERO) >= 0) {
                    value = Evaluation.evaluate(env, body, List.of(value));
                }
            } else {
                throw new TypeError("Expected a callable or an integer as the second argument to `while'.");
            }

            return value;
        } else {
            throw new TypeError("Expected 2 or 3 arguments to `while'.");
        }
    }

    @Override
    protected String name() {
        return "while";
    }
}
