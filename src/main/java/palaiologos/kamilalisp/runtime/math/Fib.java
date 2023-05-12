package palaiologos.kamilalisp.runtime.math;

import ch.obermuhlner.math.big.BigComplex;
import ch.obermuhlner.math.big.BigComplexMath;
import ch.obermuhlner.math.big.BigDecimalMath;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class Fib extends PrimitiveFunction implements Lambda {
    private static Atom fib1(Environment e, Atom a) {
        a.assertTypes(Type.INTEGER, Type.REAL, Type.COMPLEX, Type.LIST);
        BigDecimal sqrt5 = new BigDecimal("5").sqrt(e.getMathContext());
        BigDecimal golden1 = BigDecimal.ONE.add(sqrt5).divide(BigDecimal.valueOf(2), e.getMathContext());
        BigDecimal golden2 = BigDecimal.ONE.subtract(sqrt5).divide(BigDecimal.valueOf(2), e.getMathContext());
        if (a.getType() == Type.COMPLEX) {
            return new Atom(BigComplexMath.pow(BigComplex.valueOf(golden1), a.getComplex(), e.getMathContext())
                    .subtract(BigComplexMath.pow(BigComplex.valueOf(golden2), a.getComplex(), e.getMathContext()))
                    .divide(BigComplex.valueOf(sqrt5), e.getMathContext()));
        } else if (a.getType() == Type.REAL) {
            return new Atom(BigDecimalMath.pow(golden1, a.getReal(), e.getMathContext())
                    .subtract(BigDecimalMath.pow(golden2, a.getReal(), e.getMathContext()))
                    .divide(sqrt5, e.getMathContext()));
        } else if (a.getType() == Type.INTEGER) {
            return new Atom(BigDecimalMath.pow(golden1, a.getReal(), e.getMathContext())
                    .subtract(BigDecimalMath.pow(golden2, a.getReal(), e.getMathContext()))
                    .divide(sqrt5, e.getMathContext()).toBigInteger());
        } else if (a.getType() == Type.LIST) {
            ArrayList<Atom> list = new ArrayList<>(a.getList().size());
            for (Atom x : a.getList()) {
                Atom atom = fib1(e, x);
                list.add(atom);
            }
            return new Atom(list);
        } else {
            throw new TypeError("`fib' not defined for: " + a.getType());
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() == 1) {
            return fib1(env, args.get(0));
        } else if (args.isEmpty()) {
            throw new TypeError("Expected 1 or more arguments to `fib'.");
        } else {
            ArrayList<Atom> list = new ArrayList<>(args.size());
            for (Atom x : args) {
                Atom atom = fib1(env, x);
                list.add(atom);
            }
            return new Atom(list);
        }
    }

    @Override
    protected String name() {
        return "fib";
    }
}
