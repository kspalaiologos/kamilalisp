package kamilalisp.libs;

import kamilalisp.data.*;
import kamilalisp.matrix.Matrix;

import java.util.List;
import java.util.stream.Collectors;

public class MatrixLib {
    public static void install(Environment env) {
        env.push("mat-mix", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'mat-mix'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("First argument to 'mat-mix'", Type.LIST);
                    List<List<Atom>> rawData = arguments.get(0).getList().get().stream().map(x -> {
                        x.guardType("Element in argument to 'mat-mix'", Type.LIST);
                        return x.getList().get();
                    }).collect(Collectors.toList());
                    return Matrix.from(rawData);
                }));
            }
        }));

        env.push("transpose", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'transpose'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("First argument to 'transpose'", Type.MATRIX);
                    return arguments.get(0).getMatrix().get().transpose();
                }));
            }
        }));
    }
}
