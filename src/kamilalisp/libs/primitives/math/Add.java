package kamilalisp.libs.primitives.math;

import ch.obermuhlner.math.big.BigComplex;
import ch.obermuhlner.math.big.BigComplexMath;
import kamilalisp.data.*;
import kamilalisp.data.Matrix;

import java.util.List;

public class Add implements Closure {
    public static Atom add2(Atom a1, Atom a2) {
        return new Atom(new LbcSupplier<>(() -> {
            if (a1.getType() == Type.NUMBER && a2.getType() == Type.NUMBER) {
                return a1.getNumber().get().add(a2.getNumber().get());
            } else if (a1.getType() == Type.MATRIX && a2.getType() == Type.MATRIX) {
                if (a1.getMatrix().get().getRows() != a2.getMatrix().get().getRows() || a1.getMatrix().get().getCols() != a2.getMatrix().get().getCols())
                    throw new Error("Matrix dimensions must match");
                return a1.getMatrix().get().transmogrifyRank0((x, y) ->
                        new Atom(new LbcSupplier<>(() -> add2(x, y).get().get())), a2.getMatrix().get());
            } else if(a1.getType() == Type.COMPLEX && a2.getType() == Type.NUMBER) {
                return a1.getComplex().get().add(a2.getNumber().get());
            } else if(a1.getType() == Type.NUMBER && a2.getType() == Type.COMPLEX) {
                return BigComplex.valueOf(a1.getNumber().get()).add(a2.getComplex().get());
            } else if ((a1.getType() == Type.MATRIX && a2.isNumeric()) || (a1.isNumeric() && a2.getType() == Type.MATRIX)) {
                Atom number;
                Matrix mat;

                if (a1.getType() == Type.MATRIX) {
                    mat = a1.getMatrix().get();
                } else {
                    mat = a2.getMatrix().get();
                }

                if (a1.isNumeric()) {
                    number = a1;
                } else {
                    number = a2;
                }

                return mat.transmogrifyRank0(x ->
                        new Atom(new LbcSupplier<>(() -> add2(x, number).get().get()))
                );
            } else if (a1.getType() == Type.COMPLEX && a2.getType() == Type.COMPLEX) {
                return a1.getComplex().get().add(a2.getComplex().get());
            } else if (a1.getType() == Type.STRING_CONSTANT && a2.getType() == Type.STRING_CONSTANT) {
                return new StringConstant(a1.getStringConstant().get().get() + a2.getStringConstant().get().get());
            } else if (a1.getType() == Type.NUMBER && a2.getType() == Type.STRING_CONSTANT) {
                return new StringConstant(a1.getNumber().get().toPlainString() + a2.getStringConstant().get().get());
            } else if (a1.getType() == Type.STRING_CONSTANT && a2.getType() == Type.NUMBER) {
                return new StringConstant(a1.getStringConstant().get().get() + a2.getNumber().get().toPlainString());
            } else if (a1.getType() == Type.STRING_CONSTANT && a2.getType() == Type.COMPLEX) {
                return new StringConstant(a1.getStringConstant().get().get() + a2);
            } else {
                throw new Error("+ unsupported on operands of type " + a1.getType().name() + " and " + a2.getType().name());
            }
        }));
    }

    public static Atom add1(Atom a) {
        return new Atom(new LbcSupplier<>(() -> {
            if (a.getType() == Type.COMPLEX) {
                return BigComplexMath.conjugate(a.getComplex().get());
            } else if (a.getType() == Type.MATRIX) {
                return a.getMatrix().get().transmogrifyRank0(x ->
                        new Atom(new LbcSupplier<>(() -> {
                            if (x.getType() == Type.COMPLEX) {
                                return BigComplexMath.conjugate(x.getComplex().get());
                            } else {
                                return x.get().get();
                            }
                        }))
                );
            } else {
                return a.get().get();
            }
        }));
    }

    @Override
    public Atom apply(Executor env, List<Atom> arguments) {
        if(arguments.size() == 0 || arguments.size() > 2)
            throw new Error("Invalid + invocation.");
        else if(arguments.size() == 1) {
            return add1(arguments.get(0));
        } else
            return add2(arguments.get(0), arguments.get(1));
    }
}
