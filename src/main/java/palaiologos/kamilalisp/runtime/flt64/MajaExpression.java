package palaiologos.kamilalisp.runtime.flt64;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;
import palaiologos.kamilalisp.runtime.hashmap.HashMapUserData;
import rocks.palaiologos.maja.Complex;
import rocks.palaiologos.maja.Maja;
import rocks.palaiologos.maja.expression.Evaluator;
import rocks.palaiologos.maja.matrix.Matrix;

import java.math.BigInteger;
import java.util.AbstractList;
import java.util.ArrayList;
import java.util.List;

public class MajaExpression extends PrimitiveFunction implements Lambda {
    private static Atom parseResult(Object result) {
        if (result instanceof Double) {
            return Flt64AtomThunk.toAtom((Double) result);
        } else if (result instanceof Complex) {
            return Cmplx64AtomThunk.toAtom((Complex) result);
        } else if (result instanceof Long) {
            return new Atom(BigInteger.valueOf((Long) result));
        } else if (result instanceof Matrix<?> mat) {
            List<Atom> data = new ArrayList<>();
            for (List<?> row : mat.rows()) {
                List<Atom> rowData = new ArrayList<>();
                for (Object item : row)
                    rowData.add(parseResult(item));
                data.add(new Atom(rowData));
            }
            return new Atom(data);
        } else {
            throw new RuntimeException("Maja returned an unexpected type: " + result.getClass().getName());
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.size() == 2) {
            // Supply an environment _and_ an expression.
            HashMapUserData data = args.get(0).getUserdata(HashMapUserData.class);
            String expression = args.get(1).getString();
            rocks.palaiologos.maja.expression.Environment environment = new rocks.palaiologos.maja.expression.Environment();
            data.value().forEach((key, value) -> environment.set(key.getString(), value.getString()));
            Object result = Evaluator.evaluate(expression, environment);
            return parseResult(result);
        } else if(args.size() == 1) {
            // Supply either an environment so that we can return a thunk OR string.
            if (args.get(0).getType() == Type.STRING) {
                return parseResult(Evaluator.evaluate(args.get(0).getString(), new rocks.palaiologos.maja.expression.Environment()));
            } else if(args.get(0).isUserdata(HashMapUserData.class)) {
                HashMapUserData data = args.get(0).getUserdata(HashMapUserData.class);
                rocks.palaiologos.maja.expression.Environment environment = new rocks.palaiologos.maja.expression.Environment();
                data.value().forEach((key, value) -> environment.set(key.getString(), value.getString()));
                return new Atom(new MajaExpressionFunctor(environment));
            } else {
                throw new TypeError("Expected a string or a hashmap as an argument, got " + args.get(0).getType());
            }
        } else {
            // Error.
            throw new TypeError("Expected 1 or 2 arguments, got " + args.size());
        }
    }

    @Override
    protected String name() {
        return "flt64:maja";
    }

    private static class MajaExpressionFunctor extends PrimitiveFunction implements Lambda {
        private final rocks.palaiologos.maja.expression.Environment environment;

        public MajaExpressionFunctor(rocks.palaiologos.maja.expression.Environment env) {
            environment = env;
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 1);
            return parseResult(Evaluator.evaluate(args.get(0).getString(), environment));
        }

        @Override
        protected String name() {
            return "flt64:maja thunk";
        }
    }
}
