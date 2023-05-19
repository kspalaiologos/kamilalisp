package palaiologos.kamilalisp.runtime.array.hof;

import palaiologos.kamilalisp.atom.*;

import java.math.BigInteger;
import java.util.List;

public class Count extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.size() == 2) {
            Callable reductor = args.get(0).getCallable();
            return doCount(env, reductor, args.get(1));
        } else if(args.size() == 1) {
            Callable reductor = args.get(0).getCallable();
            return new Atom(new CountThunk(reductor));
        } else {
            throw new RuntimeException("count expects 1 (partial application) or 2 (full application) arguments");
        }
    }

    private static Atom doCount(Environment env, Callable reductor, Atom arg1) {
        if (arg1.getType() == Type.LIST) {
            List<Atom> list = arg1.getList();
            long count = 0L;
            for (Atom x : list) {
                if (Evaluation.evaluate(env, reductor, List.of(x)).coerceBool()) {
                    count++;
                }
            }
            return new Atom(BigInteger.valueOf(count));
        } else if (arg1.getType() == Type.STRING) {
            String str = arg1.getString();
            int len = str.length();
            long count = 0L;
            for(int i = 0; i < len; i++) {
                if(Evaluation.evaluate(env, reductor, List.of(Atom.fromChar(str.charAt(i)))).coerceBool()) {
                    count++;
                }
            }
            return new Atom(BigInteger.valueOf(count));
        } else {
            throw new UnsupportedOperationException("count not defined for: " + arg1.getType());
        }
    }

    private static class CountThunk extends PrimitiveFunction implements Lambda {
        private final Callable reductor;

        private CountThunk(Callable reductor) {
            this.reductor = reductor;
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 1);
            return doCount(env, reductor, args.get(0));
        }

        @Override
        protected String name() {
            return "count (thunk: " + reductor + ")";
        }
    }

    @Override
    protected String name() {
        return "count";
    }
}
