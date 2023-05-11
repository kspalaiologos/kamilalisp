package palaiologos.kamilalisp.runtime.array.hof;

import palaiologos.kamilalisp.atom.*;

import java.util.List;

public class None extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.size() == 2) {
            Callable reductor = args.get(0).getCallable();
            if (args.get(1).getType() == Type.LIST) {
                List<Atom> list = args.get(1).getList();
                for (Atom x : list)
                    if (Evaluation.evaluate(env, reductor, List.of(x)).coerceBool())
                        return Atom.FALSE;
                return Atom.TRUE;
            } else if (args.get(1).getType() == Type.STRING) {
                String str = args.get(1).getString();
                int len = str.length();
                for (int i = 0; i < len; i++)
                    if (Evaluation.evaluate(env, reductor, List.of(Atom.fromChar(str.charAt(i)))).coerceBool())
                        return Atom.FALSE;
                return Atom.TRUE;
            } else {
                throw new UnsupportedOperationException("none not defined for: " + args.get(1).getType());
            }
        } else if(args.size() == 1) {
            List<Atom> list = args.get(0).getList();
            for (Atom atom : list)
                if (atom.coerceBool())
                    return Atom.FALSE;
            return Atom.TRUE;
        } else {
            throw new UnsupportedOperationException("none not defined for: " + args.size() + " arguments");
        }
    }

    @Override
    protected String name() {
        return "none";
    }
}
