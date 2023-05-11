package palaiologos.kamilalisp.runtime.array.hof;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.util.ArrayList;
import java.util.List;

public class Filter extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        Callable reductor = args.get(0).getCallable();
        if (args.get(1).getType() == Type.LIST) {
            List<Atom> list = args.get(1).getList();
            ArrayList<Atom> result = new ArrayList<>();
            for (Atom x : list)
                if (Evaluation.evaluate(env, reductor, List.of(x)).coerceBool())
                    result.add(x);
            return new Atom(result);
        } else if (args.get(1).getType() == Type.STRING) {
            String string = args.get(1).getString();
            int len = string.length();
            StringBuilder result = new StringBuilder();
            for(int i = 0; i < len; i++)
                if(Evaluation.evaluate(env, reductor, List.of(Atom.fromChar(string.charAt(i)))).coerceBool())
                    result.append(string.charAt(i));
            return new Atom(result.toString());
        } else {
            throw new TypeError("Expected a list or a string as the second argument to `filter'.");
        }
    }

    @Override
    protected String name() {
        return "filter";
    }
}
