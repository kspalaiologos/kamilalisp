package palaiologos.kamilalisp.runtime.math;

import ch.obermuhlner.math.big.BigComplex;
import ch.obermuhlner.math.big.BigComplexMath;
import ch.obermuhlner.math.big.BigDecimalMath;
import com.google.common.collect.Streams;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.ArrayError;
import palaiologos.kamilalisp.error.TypeError;

import java.math.BigDecimal;
import java.util.List;
import java.util.stream.Collectors;

public class DoubleStar extends PrimitiveFunction implements Lambda {
    public static Atom power2(Environment e, Atom a, Atom b) {
        a.assertTypes(Type.INTEGER, Type.REAL, Type.COMPLEX, Type.STRING, Type.LIST);
        b.assertTypes(Type.INTEGER, Type.REAL, Type.COMPLEX, Type.STRING, Type.LIST);
        if (a.getType() == Type.COMPLEX && b.getType() == Type.COMPLEX) {
            return new Atom(BigComplexMath.pow(a.getComplex(), b.getComplex(), e.getMathContext()));
        } else if (a.getType() == Type.REAL && b.getType() == Type.REAL) {
            return new Atom(BigDecimalMath.pow(a.getReal(), b.getReal(), e.getMathContext()));
        } else if (a.getType() == Type.REAL && b.getType() == Type.COMPLEX) {
            return new Atom(BigComplexMath.pow(BigComplex.valueOf(a.getReal()), b.getComplex(), e.getMathContext()));
        } else if (a.getType() == Type.COMPLEX && b.getType() == Type.REAL) {
            return new Atom(BigComplexMath.pow(a.getComplex(), b.getReal(), e.getMathContext()));
        } else if (a.getType() == Type.INTEGER && b.getType() == Type.INTEGER) {
            return new Atom(a.getInteger().pow(b.getInteger().intValue()));
        } else if (a.getType() == Type.INTEGER && b.getType() == Type.REAL) {
            return new Atom(BigDecimalMath.pow(new BigDecimal(a.getInteger()), b.getReal(), e.getMathContext()));
        } else if (a.getType() == Type.REAL && b.getType() == Type.INTEGER) {
            return new Atom(BigDecimalMath.pow(a.getReal(), new BigDecimal(b.getInteger()), e.getMathContext()));
        } else if (a.getType() == Type.INTEGER && b.getType() == Type.COMPLEX) {
            return new Atom(BigComplexMath.pow(BigComplex.valueOf(new BigDecimal(a.getInteger())), b.getComplex(), e.getMathContext()));
        } else if (a.getType() == Type.COMPLEX && b.getType() == Type.INTEGER) {
            return new Atom(BigComplexMath.pow(a.getComplex(), BigComplex.valueOf(new BigDecimal(b.getInteger())), e.getMathContext()));
        } else if (a.getType() == Type.LIST && b.getType() == Type.LIST) {
            List<Atom> A = a.getList();
            List<Atom> B = b.getList();
            if (A.size() != B.size())
                throw new ArrayError("Mismatched input shapes: Exponentiating vectors of length " + A.size() + " and " + B.size() + ".");
            return new Atom(Streams.zip(A.stream(), B.stream(), (x, y) -> power2(e, x, y)).collect(Collectors.toList()));
        } else if (a.getType() == Type.LIST && b.isNumeric()) {
            return new Atom(a.getList().stream().map(x -> power2(e, x, b)).collect(Collectors.toList()));
        } else if (a.isNumeric() && b.getType() == Type.LIST) {
            return new Atom(b.getList().stream().map(x -> power2(e, a, x)).collect(Collectors.toList()));
        } else {
            throw new TypeError("** not defined for: " + a.getType() + " and " + b.getType());
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() == 2) {
            return power2(env, args.get(0), args.get(1));
        } else if (args.size() <= 1) {
            throw new TypeError("Expected 2 or more arguments to `**'.");
        } else {
            return args.stream().reduce((x, y) -> power2(env, x, y)).get();
        }
    }

    @Override
    protected String name() {
        return "**";
    }
}
