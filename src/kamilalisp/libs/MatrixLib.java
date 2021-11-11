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

        env.push("mat-sub", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 5)
                    throw new Error("Invalid invocation to 'mat-sub'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("First argument to 'mat-sub'", Type.MATRIX);
                    arguments.get(1).guardType("Second argument to 'mat-sub'", Type.NUMBER);
                    arguments.get(2).guardType("Third argument to 'mat-sub'", Type.NUMBER);
                    arguments.get(3).guardType("Fourth argument to 'mat-sub'", Type.NUMBER);
                    arguments.get(4).guardType("Fifth argument to 'mat-sub'", Type.NUMBER);
                    Matrix m = arguments.get(0).getMatrix().get();
                    int r0 = arguments.get(1).getNumber().get().intValue();
                    int c0 = arguments.get(2).getNumber().get().intValue();
                    int r1 = arguments.get(3).getNumber().get().intValue();
                    int c1 = arguments.get(4).getNumber().get().intValue();
                    if(r1 < r0 || c1 < c0)
                        throw new Error("'mat-sub': submatrix end row/col larger than start row/col.");
                    return Matrix.of((row, col) -> m.get(r0 + row, c0 + col), r1 - r0 + 1, c1 - c0 + 1);
                }));
            }
        }));

        env.push("mat-blit", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 4 && arguments.size() != 5)
                    throw new Error("Invalid invocation to 'mat-blit'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("First argument to 'mat-blit'", Type.MATRIX);
                    arguments.get(1).guardType("Second argument to 'mat-blit'", Type.MATRIX);
                    Matrix m1 = arguments.get(0).getMatrix().get();
                    Matrix m2 = arguments.get(1).getMatrix().get();
                    int r0, c0;
                    Callable processor;
                    if(arguments.size() == 4) {
                        arguments.get(2).guardType("Third argument to 'mat-blit'", Type.NUMBER);
                        arguments.get(3).guardType("Fourth argument to 'mat-blit'", Type.NUMBER);
                        r0 = arguments.get(2).getNumber().get().intValue();
                        c0 = arguments.get(3).getNumber().get().intValue();
                        processor = new Closure() {
                            @Override
                            public Atom apply(Executor env, List<Atom> arguments) {
                                return arguments.get(1);
                            }
                        };
                    } else {
                        arguments.get(2).guardType("Third argument to 'mat-blit'", Type.CLOSURE, Type.MACRO);
                        arguments.get(3).guardType("Fourth argument to 'mat-blit'", Type.NUMBER);
                        arguments.get(4).guardType("Fifth argument to 'mat-blit'", Type.NUMBER);
                        r0 = arguments.get(3).getNumber().get().intValue();
                        c0 = arguments.get(4).getNumber().get().intValue();
                        processor = arguments.get(2).getCallable().get();
                    }
                    return Matrix.of((row, col) -> {
                        if(row >= r0 && row < r0 + m2.getRows() && col >= c0 && col < c0 + m2.getCols())
                            return processor.apply(env, List.of(
                                    new Atom(new LbcSupplier<>(() -> m1.get(row - r0, col - c0).get().get())),
                                    new Atom(new LbcSupplier<>(() -> m2.get(row - r0, col - c0).get().get()))));
                        else
                            return m1.get(row, col);
                    }, m1.getRows(), m1.getCols());
                }));
            }
        }));
    }
}
