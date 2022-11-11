package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.*;

import java.util.List;

public class None extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        Callable reductor = args.get(0).getCallable();
        if(args.get(1).getType() == Type.LIST) {
            List<Atom> list = args.get(1).getList();
            return new Atom(list.stream().noneMatch(x -> Evaluation.evaluate(env, reductor, List.of(x)).coerceBool()));
        } else if(args.get(1).getType() == Type.STRING) {
            String str = args.get(1).getString();
            return new Atom(str.chars().noneMatch(x -> Evaluation.evaluate(env, reductor, List.of(new Atom(String.valueOf((char) x)))).coerceBool()));
        } else {
            throw new UnsupportedOperationException("none not defined for: " + args.get(1).getType());
        }
    }

    @Override
    protected String name() {
        return "none";
    }
}
