package palaiologos.kamilalisp.runtime.array.hof;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.util.List;

public class Filter extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        Callable reductor = args.get(0).getCallable();
        if(args.get(1).getType() == Type.LIST) {
            List<Atom> list = args.get(1).getList();
            return new Atom(list.stream().filter(x -> Evaluation.evaluate(env, reductor, List.of(x)).coerceBool()).toList());
        } else if(args.get(1).getType() == Type.STRING) {
            String string = args.get(1).getString();
            return new Atom(string.chars().filter(
                    x -> Evaluation.evaluate(env, reductor, List.of(new Atom(String.valueOf((char) x)))).coerceBool()
            ).mapToObj(x -> (char) x).collect(StringBuilder::new, StringBuilder::append, StringBuilder::append).toString());
        } else {
            throw new TypeError("Expected a list or a string as the second argument to `filter'.");
        }
    }

    @Override
    protected String name() {
        return "filter";
    }
}
