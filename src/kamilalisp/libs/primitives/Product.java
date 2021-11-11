package kamilalisp.libs.primitives;

import ch.obermuhlner.math.big.BigComplex;
import com.google.common.collect.Streams;
import kamilalisp.data.*;
import kamilalisp.matrix.Matrix;

import java.math.BigDecimal;
import java.math.MathContext;
import java.util.List;
import java.util.stream.Collectors;

public class Product implements Closure {
    private static BigDecimal norm(BigComplex x) {
        return x.re.pow(2).add(x.im.pow(2)).sqrt(MathContext.DECIMAL128);
    }

    private Atom mul2(Atom a1, Atom a2) {
        return new Atom(new LbcSupplier<>(() -> {
            if(a1.getType() == Type.NUMBER && a2.getType() == Type.NUMBER) {
                return a1.getNumber().get().multiply(a2.getNumber().get());
            } else if(a1.getType() == Type.COMPLEX && a2.getType() == Type.COMPLEX) {
                return a1.getComplex().get().multiply(a2.getComplex().get());
            } else if(a1.getType() == Type.MATRIX && a2.getType() == Type.MATRIX) {
                Matrix a = a1.getMatrix().get();
                Matrix b = a2.getMatrix().get();
                if(a.getRows() != b.getCols())
                    throw new Error("Invalid matrix multiplication: " + a.getRows() + "x" + a.getCols() + " and " + b.getRows() + "x" + b.getCols() + ".");
                List<List<Atom>> lRows = a.rows().collect(Collectors.toList());
                List<List<Atom>> lCols = b.cols().collect(Collectors.toList());
                return Matrix.of((row, col) -> Streams.zip(lRows.get(row).stream(), lCols.get(col).stream(), (x, y) -> mul2(x, y)).reduce(Add::add2).get(), a.getRows(), b.getCols());
            } else if(a1.getType() == Type.NUMBER && a2.getType() == Type.STRING_CONSTANT) {
                return new StringConstant(a2.getStringConstant().get().get().repeat(a1.getNumber().get().intValue()));
            } else if(a1.getType() == Type.STRING_CONSTANT && a2.getType() == Type.NUMBER) {
                return new StringConstant(a1.getStringConstant().get().get().repeat(a2.getNumber().get().intValue()));
            } else {
                throw new Error("* unsupported on operands of type " + a1.getType().name() + " and " + a2.getType().name());
            }
        }));
    }

    public Atom mul1(Atom a) {
        return new Atom(new LbcSupplier<>(() -> {
            a.guardType("Argument to monadic *", Type.NUMBER, Type.COMPLEX, Type.MATRIX);
            if(a.getType() == Type.NUMBER) {
                return new BigDecimal(a.getNumber().get().compareTo(BigDecimal.ZERO));
            } else if(a.getType() == Type.COMPLEX) {
                return norm(a.getComplex().get()).compareTo(BigDecimal.ZERO);
            } else if(a.getType() == Type.MATRIX) {
                return a.getMatrix().get().transmogrifyRank0(x -> new Atom(new LbcSupplier<>(() -> mul1(x))));
            } else
                throw new Error("unreachable.");
        }));
    }

    @Override
    public Atom apply(Executor env, List<Atom> arguments) {
        if(arguments.size() == 0 || arguments.size() > 2)
            throw new Error("Invalid * invocation.");
        if(arguments.size() == 1)
            return mul1(arguments.get(0));
        else
            return mul2(arguments.get(0), arguments.get(1));
    }
}
