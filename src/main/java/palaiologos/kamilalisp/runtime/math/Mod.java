package palaiologos.kamilalisp.runtime.math;

import ch.obermuhlner.math.big.BigComplex;
import com.google.common.collect.Streams;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.ArrayError;
import palaiologos.kamilalisp.error.TypeError;

import java.math.RoundingMode;
import java.util.List;
import java.util.stream.Collectors;

public class Mod extends PrimitiveFunction implements Lambda {
    private static BigComplex mod(Environment e, BigComplex A, BigComplex B) {
        BigComplex rho = A.divide(B, e.getMathContext());
        rho = BigComplex.valueOf(rho.re.setScale(0, RoundingMode.CEILING), rho.im.setScale(0, RoundingMode.CEILING));
        rho = rho.negate();
        return A.add(B.multiply(rho));
    }

    private static Atom quot2(Environment e, Atom a, Atom b) {
        a.assertTypes(Type.INTEGER, Type.REAL, Type.COMPLEX, Type.LIST);
        b.assertTypes(Type.INTEGER, Type.REAL, Type.COMPLEX, Type.LIST);
        if (a.getType() == Type.COMPLEX && b.getType() == Type.COMPLEX) {
            return new Atom(mod(e, a.getComplex(), b.getComplex()));
        } else if (a.getType() == Type.REAL && b.getType() == Type.REAL) {
            return new Atom(a.getReal().remainder(b.getReal(), e.getMathContext()));
        } else if (a.getType() == Type.REAL && b.getType() == Type.COMPLEX) {
            return new Atom(mod(e, BigComplex.valueOf(a.getReal()), b.getComplex()));
        } else if (a.getType() == Type.COMPLEX && b.getType() == Type.REAL) {
            return new Atom(mod(e, a.getComplex(), BigComplex.valueOf(b.getReal())));
        } else if (a.getType() == Type.INTEGER && b.getType() == Type.INTEGER) {
            return new Atom(a.getInteger().remainder(b.getInteger()));
        } else if (a.getType() == Type.INTEGER && b.getType() == Type.REAL) {
            return new Atom(a.getReal().remainder(b.getReal(), e.getMathContext()));
        } else if (a.getType() == Type.REAL && b.getType() == Type.INTEGER) {
            return new Atom(a.getReal().remainder(b.getReal(), e.getMathContext()));
        } else if (a.getType() == Type.INTEGER && b.getType() == Type.COMPLEX) {
            return new Atom(mod(e, a.getComplex(), b.getComplex()));
        } else if (a.getType() == Type.COMPLEX && b.getType() == Type.INTEGER) {
            return new Atom(mod(e, a.getComplex(), b.getComplex()));
        } else if (a.getType() == Type.LIST && b.getType() == Type.LIST) {
            List<Atom> A = a.getList();
            List<Atom> B = b.getList();
            if (A.size() != B.size())
                throw new ArrayError("Mismatched input shapes: Dividing vectors of length " + A.size() + " and " + B.size() + ".");
            return new Atom(Streams.zip(A.stream(), B.stream(), (x, y) -> quot2(e, x, y)).collect(Collectors.toList()));
        } else if (a.getType() == Type.LIST && b.isNumeric()) {
            return new Atom(a.getList().stream().map(x -> quot2(e, x, b)).collect(Collectors.toList()));
        } else if (a.isNumeric() && b.getType() == Type.LIST) {
            return new Atom(b.getList().stream().map(x -> quot2(e, a, x)).collect(Collectors.toList()));
        } else {
            throw new TypeError("mod not defined for: " + a.getType() + " and " + b.getType());
        }
    }

    private static Atom quot1(Environment e, Atom a) {
        a.assertTypes(Type.REAL, Type.COMPLEX, Type.LIST);
        if (a.getType() == Type.COMPLEX) {
            return new Atom(a.getComplex().abs(e.getMathContext()));
        } else if (a.getType() == Type.REAL) {
            return new Atom(a.getReal().abs(e.getMathContext()));
        } else if (a.getType() == Type.LIST) {
            return new Atom(a.getList().stream().map(x -> quot1(e, x)).collect(Collectors.toList()));
        } else {
            throw new TypeError("mod not defined for: " + a.getType());
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() == 1) {
            return quot1(env, args.get(0));
        } else if (args.size() == 2) {
            return quot2(env, args.get(0), args.get(1));
        } else if (args.isEmpty()) {
            throw new TypeError("Expected 1 or more arguments to `mod'.");
        } else {
            return args.stream().reduce((x, y) -> quot2(env, x, y)).get();
        }
    }

    @Override
    protected String name() {
        return "mod";
    }
}
