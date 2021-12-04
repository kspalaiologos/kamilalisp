package kamilalisp.libs.primitives.linalg;

import kamilalisp.data.*;
import kamilalisp.data.Matrix;

import java.math.BigDecimal;
import java.util.List;

public class Identity implements Closure {
    public static Matrix of(int size) {
        return Matrix.of((a, b) -> a == b ? new Atom(BigDecimal.ONE) : new Atom(BigDecimal.ZERO), size, size);
    }

    @Override
    public Atom apply(Executor env, List<Atom> arguments) {
        if(arguments.size() != 1)
            throw new Error("Invalid invocation to 'mat-id'.");
        return new Atom(new LbcSupplier<>(() -> {
            arguments.get(0).guardType("Argument to 'mat-id'", Type.NUMBER);
            int size = arguments.get(0).getNumber().get().intValue();
            return Identity.of(size);
        }));
    }
}
