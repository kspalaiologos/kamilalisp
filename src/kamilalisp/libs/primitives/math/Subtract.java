package kamilalisp.libs.primitives.math;

import ch.obermuhlner.math.big.BigComplex;
import kamilalisp.data.*;
import kamilalisp.data.Matrix;

import java.io.StringWriter;
import java.util.List;

public class Subtract implements Closure {
    public static Atom sub2(Atom a1, Atom a2) {
        return new Atom(new LbcSupplier<>(() -> {
            if (a1.getType() == Type.NUMBER && a2.getType() == Type.NUMBER) {
                return a1.getNumber().get().subtract(a2.getNumber().get());
            } else if (a1.getType() == Type.MATRIX && a2.getType() == Type.MATRIX) {
                if (a1.getMatrix().get().getRows() != a2.getMatrix().get().getRows() || a1.getMatrix().get().getCols() != a2.getMatrix().get().getCols())
                    throw new Error("Matrix dimensions must match");
                return a1.getMatrix().get().transmogrifyRank0((x, y) ->
                        new Atom(new LbcSupplier<>(() -> sub2(x, y).get().get())), a2.getMatrix().get());
            } else if ((a1.getType() == Type.MATRIX && a2.isNumeric()) || (a1.isNumeric() && a2.getType() == Type.MATRIX)) {
                Matrix mat;

                if (a1.getType() == Type.MATRIX) {
                    mat = a1.getMatrix().get();
                } else {
                    mat = a2.getMatrix().get();
                }

                if (a1.isNumeric()) {
                    return mat.transmogrifyRank0(x ->
                            new Atom(new LbcSupplier<>(() -> sub2(a1, x).get().get()))
                    );
                } else {
                    return mat.transmogrifyRank0(x ->
                            new Atom(new LbcSupplier<>(() -> sub2(x, a2).get().get()))
                    );
                }
            } else if (a1.getType() == Type.COMPLEX && a2.getType() == Type.COMPLEX) {
                return a1.getComplex().get().subtract(a2.getComplex().get());
            } else if(a1.getType() == Type.COMPLEX && a2.getType() == Type.NUMBER) {
                return a1.getComplex().get().subtract(a2.getNumber().get());
            } else if(a1.getType() == Type.NUMBER && a2.getType() == Type.COMPLEX) {
                return BigComplex.valueOf(a1.getNumber().get()).subtract(a2.getComplex().get());
            } else if (a1.getType() == Type.STRING_CONSTANT && a2.getType() == Type.STRING_CONSTANT) {
                final String lookup = a2.getStringConstant().get().get();
                return new StringConstant(a1.getStringConstant().get().get()
                        .chars().filter(x -> lookup.indexOf(x) != -1).collect(StringWriter::new, StringWriter::write,
                                (swl, swr) -> swl.write(swr.toString())).toString());
            } else if (a1.getType() == Type.NUMBER && a2.getType() == Type.STRING_CONSTANT) {
                return new StringConstant(a2.getStringConstant().get().get().substring(a1.getNumber().get().intValue()));
            } else if (a1.getType() == Type.STRING_CONSTANT && a2.getType() == Type.NUMBER) {
                String s = a1.getStringConstant().get().get();
                return new StringConstant(s.substring(0, s.length() - a2.getNumber().get().intValue()));
            } else {
                throw new Error("- unsupported on operands of type " + a1.getType().name() + " and " + a2.getType().name());
            }
        }));
    }

    public static Atom sub1(Atom a) {
        return new Atom(new LbcSupplier<>(() -> {
            a.guardType("Argument to monadic -", Type.NUMBER, Type.COMPLEX, Type.MATRIX);
            if (a.getType() == Type.NUMBER) {
                return a.getNumber().get().negate();
            } else if (a.getType() == Type.COMPLEX) {
                return a.getComplex().get().negate();
            } else if (a.getType() == Type.MATRIX) {
                return a.getMatrix().get().transmogrifyRank0(x ->
                        new Atom(new LbcSupplier<>(() -> sub1(x))));
            }
            throw new Error("Unreachable");
        }));
    }

    @Override
    public Atom apply(Executor env, List<Atom> arguments) {
        if(arguments.size() == 0 || arguments.size() > 2)
            throw new Error("Invalid - invocation.");
        else if(arguments.size() == 1)
            return sub1(arguments.get(0));
        else
            return sub2(arguments.get(0), arguments.get(1));
    }
}
