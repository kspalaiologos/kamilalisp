package kamilalisp.libs;

import ch.obermuhlner.math.big.BigComplex;
import ch.obermuhlner.math.big.BigComplexMath;
import com.google.common.collect.Iterables;
import com.google.common.collect.Lists;
import com.google.common.collect.Streams;
import kamilalisp.data.*;
import kamilalisp.libs.primitives.Add;
import kamilalisp.libs.primitives.Product;
import kamilalisp.matrix.Matrix;
import kamilalisp.matrix.MatrixImpl;

import java.math.BigDecimal;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

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

        env.push("frobenius-prod", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2 && arguments.size() != 5)
                    throw new Error("Invalid invocation to 'frobenius-prod'.");
                return new Atom(new LbcSupplier<>(() -> {
                    if(arguments.size() == 2) {
                        arguments.get(0).guardType("First argument to 'frobenius-prod'", Type.MATRIX);
                        arguments.get(1).guardType("Second argument to 'frobenius-prod'", Type.MATRIX);
                        Matrix m1 = arguments.get(0).getMatrix().get();
                        Matrix m2 = arguments.get(1).getMatrix().get();
                        if (m1.getRows() != m2.getRows() || m1.getCols() != m2.getCols())
                            throw new Error("'frobenius-prod': matrices must have same dimensions.");
                        List<Atom> m1r = m1.ravel().stream().map(x -> {
                            if(x.getType() == Type.COMPLEX)
                                return new Atom(new LbcSupplier<>(() -> x.getComplex().get().conjugate()));
                            else if(x.getType() == Type.NUMBER)
                                return x;
                            else
                                throw new Error("'frobenius-prod': invalid type in matrix.");
                        }).collect(Collectors.toList()), m2r = m2.ravel();
                        return Streams.zip(m1r.stream(), m2r.stream(), Product::mul2).reduce(Add::add2).orElse(new Atom(BigDecimal.ZERO)).get().get();
                    } else {
                        arguments.get(0).guardType("First argument to 'frobenius-prod'", Type.MATRIX);
                        arguments.get(1).guardType("Second argument to 'frobenius-prod'", Type.MATRIX);
                        arguments.get(2).guardType("Third argument to 'frobenius-prod'", Type.CLOSURE, Type.MACRO);
                        arguments.get(3).guardType("Fourth argument to 'frobenius-prod'", Type.CLOSURE, Type.MACRO);
                        arguments.get(4).guardType("Fifth argument to 'frobenius-prod'", Type.CLOSURE, Type.MACRO);
                        Matrix m1 = arguments.get(0).getMatrix().get();
                        Matrix m2 = arguments.get(1).getMatrix().get();
                        Callable c = arguments.get(2).getCallable().get();
                        Callable d = arguments.get(3).getCallable().get();
                        Callable e = arguments.get(4).getCallable().get();
                        if (m1.getRows() != m2.getRows() || m1.getCols() != m2.getCols())
                            throw new Error("'frobenius-prod': matrices must have same dimensions.");
                        List<Atom> m1r = m1.ravel().stream().map(x -> e.apply(env, List.of(x))).collect(Collectors.toList()), m2r = m2.ravel();
                        return Streams.zip(m1r.stream(), m2r.stream(), (a, b) -> c.apply(env, List.of(a, b)))
                                .reduce((a, b) -> d.apply(env, List.of(a, b))).orElse(new Atom(BigDecimal.ZERO)).get().get();
                    }
                }));
            }
        }));

        env.push("mat-trace", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1 && arguments.size() != 2)
                    throw new Error("Invalid invocation to 'mat-trace'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("First argument to 'mat-trace'", Type.MATRIX);
                    Matrix m = arguments.get(0).getMatrix().get();
                    Callable c;
                    if(arguments.size() == 2) {
                        arguments.get(1).guardType("Second argument to 'mat-trace'", Type.CLOSURE, Type.MACRO);
                        c = arguments.get(1).getCallable().get();
                    } else {
                        c = new Add();
                    }
                    Atom acc = m.get(0, 0);
                    for(int i = 1; i < Math.min(m.getRows(), m.getCols()); i++)
                        acc = c.apply(env, List.of(acc, m.get(i, i)));
                    return acc.get().get();
                }));
            }
        }));

        env.push("take", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2 && arguments.size() != 3)
                    throw new Error("Invalid invocation to 'take'.");
                return new Atom(new LbcSupplier<>(() -> {
                    int rowDim = -1, colDim = -1;
                    Atom x;
                    if(arguments.size() == 2) {
                        arguments.get(0).guardType("First argument to 'take'", Type.NUMBER);
                        colDim = arguments.get(0).getNumber().get().intValue();
                        x = arguments.get(1);
                    } else {
                        arguments.get(0).guardType("First argument to 'take'", Type.NUMBER);
                        arguments.get(1).guardType("Second argument to 'take'", Type.NUMBER);
                        colDim = arguments.get(0).getNumber().get().intValue();
                        rowDim = arguments.get(1).getNumber().get().intValue();
                        x = arguments.get(2);
                    }
                    if(x.getType() == Type.MATRIX) {
                        if(rowDim == -1) {
                            // turn a matrix into a list of size N
                            return x.getMatrix().get().ravel().subList(0, colDim);
                        } else {
                            // simply reshape a matrix.
                            return x.getMatrix().get().reshape(rowDim, colDim, false);
                        }
                    } else if(x.getType() == Type.LIST) {
                        if(rowDim == -1) {
                            // trim/extend a vector with 0 (numeric) or NIL (other).
                            List<Atom> l = x.getList().get();
                            if(colDim >= 0) {
                                if (colDim < l.size())
                                    return l.subList(0, colDim);
                                else {
                                    if (l.stream().anyMatch(a -> a.getType() != Type.COMPLEX && a.getType() != Type.NUMBER))
                                        return Stream.concat(l.stream(), Stream.generate(() -> Atom.NULL)).limit(colDim).collect(Collectors.toList());
                                    else
                                        return Stream.concat(l.stream(), Stream.generate(() -> new Atom(BigDecimal.ZERO))).limit(colDim).collect(Collectors.toList());
                                }
                            } else {
                                if(-colDim > l.size())
                                    throw new Error("Can't take " + colDim + " elements from a " + l.size() + " element list.");
                                return Lists.reverse(Lists.reverse(l).stream().limit(-colDim).collect(Collectors.toList()));
                            }
                        } else {
                            // reshape a list into a matrix using matrix reshape.
                            List<Atom> l = x.getList().get();
                            if(l.stream().anyMatch(a -> a.getType() != Type.COMPLEX && a.getType() != Type.NUMBER))
                                l = Stream.concat(l.stream(), Stream.generate(() -> Atom.NULL)).limit(colDim * rowDim).collect(Collectors.toList());
                            else
                                l = Stream.concat(l.stream(), Stream.generate(() -> new Atom(BigDecimal.ZERO))).limit(colDim * rowDim).collect(Collectors.toList());
                            return Matrix.from(l, rowDim, colDim);
                        }
                    } else {
                        if(rowDim == -1) {
                            // (a a a a) - a times colDim (Type.LIST)
                            return Collections.nCopies(colDim, x);
                        } else {
                            // [a a a a] - coldim x rowdim (Type.MATRIX)
                            // [a a a a]
                            return Matrix.of((a, b) -> x, rowDim, colDim);
                        }
                    }
                }));
            }
        }));

        env.push("reshape", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2 && arguments.size() != 3)
                    throw new Error("Invalid invocation to 'reshape'.");
                return new Atom(new LbcSupplier<>(() -> {
                    int rowDim = -1, colDim = -1;
                    Atom x;
                    if(arguments.size() == 2) {
                        arguments.get(0).guardType("First argument to 'reshape'", Type.NUMBER);
                        colDim = arguments.get(0).getNumber().get().intValue();
                        x = arguments.get(1);
                    } else {
                        arguments.get(0).guardType("First argument to 'reshape'", Type.NUMBER);
                        arguments.get(1).guardType("Second argument to 'reshape'", Type.NUMBER);
                        colDim = arguments.get(0).getNumber().get().intValue();
                        rowDim = arguments.get(1).getNumber().get().intValue();
                        x = arguments.get(2);
                    }
                    if(x.getType() == Type.MATRIX) {
                        if(rowDim == -1) {
                            // turn a matrix into a list of size N
                            return x.getMatrix().get().ravel().subList(0, colDim);
                        } else {
                            // simply reshape a matrix.
                            return x.getMatrix().get().reshape(rowDim, colDim, true);
                        }
                    } else if(x.getType() == Type.LIST) {
                        if(rowDim == -1) {
                            // trim/extend a vector with 0 (numeric) or NIL (other).
                            List<Atom> l = x.getList().get();
                            if(colDim < l.size())
                                return l.subList(0, colDim);
                            else {
                                return Streams.stream(Iterables.cycle(l)).limit(colDim).collect(Collectors.toList());
                            }
                        } else {
                            // reshape a list into a matrix using matrix reshape.
                            List<Atom> l = x.getList().get();
                            return Matrix.from(Streams.stream(Iterables.cycle(l)).limit(colDim * rowDim).collect(Collectors.toList()), rowDim, colDim);
                        }
                    } else {
                        if(rowDim == -1) {
                            // (a a a a) - a times colDim (Type.LIST)
                            return Collections.nCopies(colDim, x);
                        } else {
                            // [a a a a] - coldim x rowdim (Type.MATRIX)
                            // [a a a a]
                            return Matrix.of((a, b) -> x, rowDim, colDim);
                        }
                    }
                }));
            }
        }));
    }
}
