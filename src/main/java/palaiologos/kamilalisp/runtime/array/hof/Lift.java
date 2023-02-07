package palaiologos.kamilalisp.runtime.array.hof;

import palaiologos.kamilalisp.atom.*;

import java.util.List;

public class Lift extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() == 2) {
            Callable fn = args.get(0).getCallable();
            List<Atom> arg = args.get(1).getList();
            return Evaluation.evaluate(env, fn, arg);
        } else if (args.size() == 1) {
            Callable fn = args.get(0).getCallable();
            return new Atom(new LiftedFunction(fn));
        } else {
            throw new RuntimeException("Invalid number of arguments");
        }
    }

    @Override
    protected String name() {
        return "lift";
    }

    class LiftedFunction implements Lambda {
        private final Callable primitive;

        LiftedFunction(Callable primitive) {
            this.primitive = primitive;
        }

        @Override
        public String stringify() {
            return "lift " + primitive.stringify();
        }

        @Override
        public String frameString() {
            return primitive.frameString() + "/lift";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 1);
            Atom list = args.get(0);
            list.assertTypes(Type.LIST);
            return Evaluation.evaluate(env, primitive, list.getList());
        }

        @Override
        public int line() {
            return primitive.line();
        }

        @Override
        public int column() {
            return primitive.column();
        }
    }
}
