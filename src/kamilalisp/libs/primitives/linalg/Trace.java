package kamilalisp.libs.primitives.linalg;

import kamilalisp.data.*;
import kamilalisp.libs.primitives.math.Add;
import kamilalisp.data.Matrix;

import java.util.List;

public class Trace implements Closure {
    public static Atom trace(Matrix m, Callable c, Executor env) {
        Atom acc = m.get(0, 0);
        for(int i = 1; i < Math.min(m.getRows(), m.getCols()); i++)
            acc = c.apply(env, List.of(acc, m.get(i, i)));
        return acc;
    }

    public static Atom trace(Matrix m, Executor env) {
        return trace(m, new Add(), env);
    }

    @Override
    public Atom apply(Executor env, List<Atom> arguments) {
        if(arguments.size() != 1 && arguments.size() != 2)
            throw new Error("Invalid invocation to 'mat-trace'.");
        return new Atom(new LbcSupplier<>(() -> {
            arguments.get(0).guardType("First argument to 'mat-trace'", Type.MATRIX);
            Matrix m = arguments.get(0).getMatrix().get();
            if(arguments.size() == 2) {
                arguments.get(1).guardType("Second argument to 'mat-trace'", Type.CLOSURE, Type.MACRO);
                return trace(m, arguments.get(1).getCallable().get(), env).get().get();
            } else {
                return trace(m, env).get().get();
            }
        }));
    }
}
