package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.*;

import java.util.ArrayList;
import java.util.List;

public class Bipartition extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        if(args.get(1).getType() == Type.LIST) {
            Callable condition = args.get(0).getCallable();
            List<Atom> list = args.get(1).getList();
            List<Atom> left = new ArrayList<>();
            List<Atom> right = new ArrayList<>();

            for (Atom atom : list) {
                if (Evaluation.evaluate(env, condition, List.of(atom)).coerceBool()) {
                    left.add(atom);
                } else {
                    right.add(atom);
                }
            }

            return new Atom(List.of(new Atom(left), new Atom(right)));
        } else if(args.get(1).getType() == Type.STRING) {
            Callable condition = args.get(0).getCallable();
            String string = args.get(1).getString();
            StringBuilder left = new StringBuilder();
            StringBuilder right = new StringBuilder();

            for (int i = 0; i < string.length(); i++) {
                if (Evaluation.evaluate(env, condition, List.of(Atom.fromChar(string.charAt(i)))).coerceBool()) {
                    left.append(string.charAt(i));
                } else {
                    right.append(string.charAt(i));
                }
            }

            return new Atom(List.of(new Atom(left.toString()), new Atom(right.toString())));
        } else {
            throw new RuntimeException("Invalid type. Expected a list or string.");
        }
    }

    @Override
    protected String name() {
        return "bipartition";
    }
}
