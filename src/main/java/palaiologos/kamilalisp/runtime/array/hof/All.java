package palaiologos.kamilalisp.runtime.array.hof;

import palaiologos.kamilalisp.atom.*;

import java.util.List;

public class All extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.size() == 2) {
            Callable reductor = args.get(0).getCallable();
            return doAll(env, reductor, args.get(1));
        } else if(args.size() == 1 && args.get(0).getType() == Type.LIST) {
            List<Atom> list = args.get(0).getList();
            for (Atom atom : list) {
                if (!atom.coerceBool()) {
                    return Atom.FALSE;
                }
            }
            return Atom.TRUE;
        } else if(args.size() == 1 && args.get(0).getType() == Type.CALLABLE) {
            Callable reductor = args.get(0).getCallable();
            return new Atom(new AllThunk(reductor));
        } else if(args.size() == 1) {
            throw new UnsupportedOperationException("single argument all not defined for type " + args.get(0).getType());
        } else {
            throw new UnsupportedOperationException("all not defined for: " + args.size() + " arguments");
        }
    }

    private static Atom doAll(Environment env, Callable c, Atom arg1) {
        if (arg1.getType() == Type.LIST) {
            List<Atom> list = arg1.getList();
            for (Atom x : list) {
                if (!Evaluation.evaluate(env, c, List.of(x)).coerceBool()) {
                    return Atom.FALSE;
                }
            }
            return Atom.TRUE;
        } else if (arg1.getType() == Type.STRING) {
            String str = arg1.getString();
            int len = str.length();
            for(int i = 0; i < len; i++) {
                if(!Evaluation.evaluate(env, c, List.of(Atom.fromChar(str.charAt(i)))).coerceBool()) {
                    return Atom.FALSE;
                }
            }
            return Atom.TRUE;
        } else {
            throw new UnsupportedOperationException("all not defined for: " + arg1.getType());
        }
    }

    private static class AllThunk extends PrimitiveFunction implements Lambda {
        private final Callable reductor;

        private AllThunk(Callable reductor) {
            this.reductor = reductor;
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 1);
            return doAll(env, reductor, args.get(0));
        }

        @Override
        protected String name() {
            return "all (thunk: " + reductor + ")";
        }
    }

    @Override
    protected String name() {
        return "all";
    }
}
