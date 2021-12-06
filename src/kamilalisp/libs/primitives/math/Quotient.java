package kamilalisp.libs.primitives.math;

import ch.obermuhlner.math.big.BigComplex;
import com.google.common.base.Splitter;
import com.google.common.collect.Lists;
import kamilalisp.data.*;
import kamilalisp.libs.MathLib;
import kamilalisp.libs.math.Constant;
import kamilalisp.libs.primitives.linalg.Adjoint;
import kamilalisp.libs.primitives.linalg.Determinant;
import kamilalisp.data.Matrix;

import java.math.BigDecimal;
import java.util.List;
import java.util.stream.Collectors;

public class Quotient implements Closure {
    public static Atom div2(Environment env, Atom a1, Atom a2) {
        if(a1.getType() == Type.NUMBER && a2.getType() == Type.NUMBER) {
            return new Atom(a1.getNumber().get().divide(a2.getNumber().get(), Constant.getFr(env)));
        } else if(a1.getType() == Type.STRING_CONSTANT && a2.getType() == Type.NUMBER) {
            String s = a1.getStringConstant().get().get();
            return new Atom(Lists.newLinkedList(
                            Splitter
                                    .fixedLength(s.length() / a2.getNumber().get().intValue())
                                    .split(s)
                    ).stream()
                    .map(x -> new Atom(new StringConstant(x)))
                    .collect(Collectors.toList()));
        } else if(a1.getType() == Type.COMPLEX && a2.getType() == Type.COMPLEX) {
            return new Atom(a1.getComplex().get().divide(a2.getComplex().get(), Constant.getFr(env)));
        } else if(a1.getType() == Type.LIST && a2.getType() == Type.NUMBER) {
            List<Atom> s = a1.getList().get();
            return new Atom(Lists.partition(s, s.size() / a2.getNumber().get().intValue()).stream().map(x -> new Atom(x)).collect(Collectors.toList()));
        } else if((a1.getType() == Type.COMPLEX && a2.getType() == Type.NUMBER) || (a2.getType() == Type.COMPLEX && a1.getType() == Type.NUMBER)) {
            BigComplex a = MathLib.asComplex(a1), b = MathLib.asComplex(a2);
            return new Atom(a.divide(b, Constant.getFr(env)));
        } else if(a1.getType() == Type.MATRIX && a2.getType() == Type.MATRIX) {
            Matrix m1 = a1.getMatrix().get();
            Matrix m2 = a2.getMatrix().get();
            if(m1.getRows() != m2.getRows() || m1.getCols() != m2.getCols() || m1.getCols() != m1.getRows() || m1.getCols() != m1.getRows())
                throw new Error("Can't divide matrices of different sizes.");
            return Product.mul2(a1, div1(env, a2));
        } else {
            throw new Error("/ unsupported on operands of type " + a1.getType().name() + " and " + a2.getType().name());
        }
    }

    public static Atom div1(Environment env, Atom a) {
        a.guardType("Argument to monadic /", Type.NUMBER, Type.COMPLEX, Type.MATRIX);
        if(a.getType() == Type.NUMBER) {
            return new Atom(BigDecimal.ONE.divide(a.getNumber().get(), Constant.getFr(env)));
        } else if(a.getType() == Type.COMPLEX) {
            return new Atom(a.getComplex().get().reciprocal(Constant.getFr(env)));
        } else if(a.getType() == Type.MATRIX) {
            Atom n = Determinant.det(a.getMatrix().get());
            if((n.getType() == Type.NUMBER && n.getNumber().get().compareTo(BigDecimal.ZERO) == 0)
                    || (n.getType() == Type.COMPLEX && n.getComplex().get().equals(BigComplex.ZERO)))
                throw new Error("Can't find the inverse; det(a) = 0.");
            Matrix adj = Adjoint.adj(a.getMatrix().get());
            return new Atom(adj.transmogrifyRank0(x -> div2(env, x, n)));
        } else
            throw new Error("unreachable.");
    }

    @Override
    public Atom apply(Executor env, List<Atom> arguments) {
        if(arguments.size() == 0 || arguments.size() > 2)
            throw new Error("Invalid / invocation.");
        if(arguments.size() == 1)
            return new Atom(new LbcSupplier<>(() -> div1(env.env, arguments.get(0)).get().get()));
        return new Atom(new LbcSupplier<>(() -> div2(env.env, arguments.get(0), arguments.get(1)).get().get()));
    }
}
