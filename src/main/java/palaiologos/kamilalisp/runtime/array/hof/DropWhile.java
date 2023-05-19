package palaiologos.kamilalisp.runtime.array.hof;

import palaiologos.kamilalisp.atom.*;

import java.util.List;

public class DropWhile extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.size() == 2) {
            Callable reductor = args.get(0).getCallable();
            return doDropWhile(env, reductor, args.get(1));
        } else if(args.size() == 1) {
            Callable reductor = args.get(0).getCallable();
            return new Atom(new DropWhileThunk(reductor));
        } else {
            throw new UnsupportedOperationException("drop-while not defined for: " + args.size() + " arguments");
        }
    }

    private static class DropWhileThunk extends PrimitiveFunction implements Lambda {
        private final Callable reductor;

        private DropWhileThunk(Callable reductor) {
            this.reductor = reductor;
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 1);
            return doDropWhile(env, reductor, args.get(0));
        }

        @Override
        protected String name() {
            return "drop-while (thunk " + reductor + ")";
        }
    }

    private static Atom doDropWhile(Environment env, Callable c, Atom arg1) {
        if (arg1.getType() == Type.LIST) {
            List<Atom> list = arg1.getList();
            int idx = 0;
            while (idx < list.size() && Evaluation.evaluate(env, c, List.of(list.get(idx))).coerceBool()) {
                idx++;
            }
            return new Atom(list.subList(idx, list.size()));
        } else if (arg1.getType() == Type.STRING) {
            String str = arg1.getString();
            int len = str.length();
            int idx = 0;
            while (idx < len && Evaluation.evaluate(env, c, List.of(Atom.fromChar(str.charAt(idx)))).coerceBool()) {
                idx++;
            }
            return new Atom(str.substring(idx));
        } else {
            throw new UnsupportedOperationException("drop-while not defined for: " + arg1.getType());
        }
    }

    @Override
    protected String name() {
        return "drop-while";
    }
}
