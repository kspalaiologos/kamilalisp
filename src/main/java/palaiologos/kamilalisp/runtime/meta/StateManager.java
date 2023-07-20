package palaiologos.kamilalisp.runtime.meta;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.runtime.array.Cons;

import java.util.List;

public class StateManager extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        Callable callable = args.get(0).getCallable();
        Atom state = args.get(1);
        return new Atom(new State(callable, state, env));
    }

    @Override
    protected String name() {
        return "meta:state-manager";
    }

    private static class State extends PrimitiveFunction implements Lambda {
        private final Callable callable;
        private final Environment env;
        private Atom state;

        public State(Callable callable, Atom state, Environment env) {
            this.callable = callable;
            this.env = env;
            this.state = state;
        }


        @Override
        public Atom apply(Environment env, List<Atom> args) {
            List<Atom> result = Evaluation.evaluate(env, callable, Cons.doCons(state, args)).getList();
            state = result.get(0);
            return result.get(1);
        }

        @Override
        protected String name() {
            return "meta:state-manager.instance";
        }
    }
}
