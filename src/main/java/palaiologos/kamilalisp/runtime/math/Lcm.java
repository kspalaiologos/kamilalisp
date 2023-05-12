package palaiologos.kamilalisp.runtime.math;

import ch.obermuhlner.math.big.BigComplex;
import com.google.common.collect.Streams;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.ArrayError;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class Lcm extends PrimitiveFunction implements Lambda {
    private static Atom min2(Environment e, Atom a, Atom b) {
        a.assertTypes(Type.INTEGER, Type.REAL, Type.COMPLEX, Type.LIST);
        b.assertTypes(Type.INTEGER, Type.REAL, Type.COMPLEX, Type.LIST);
        if (a.getType() == Type.LIST && b.getType() == Type.LIST) {
            int min = Math.min(a.getList().size(), b.getList().size());
            ArrayList<Atom> list = new ArrayList<>(min);
            for (int i = 0; i < min; i++) {
                Atom atom = min2(e, a.getList().get(i), b.getList().get(i));
                list.add(atom);
            }
            return new Atom(list);
        } else if (a.getType() == Type.INTEGER && b.getType() == Type.INTEGER) {
            Atom gcd = Gcd.gcd2(e, a, b);
            if (b.getInteger().compareTo(BigInteger.ZERO) == 0)
                return new Atom(BigInteger.ZERO);
            return new Atom(a.getInteger().multiply(b.getInteger().divide(gcd.getInteger())));
        } else if ((a.getType() == Type.REAL || a.getType() == Type.INTEGER) && (b.getType() == Type.REAL || b.getType() == Type.INTEGER)) {
            Atom gcd = Gcd.gcd2(e, a, b);
            if (gcd.getReal().compareTo(BigDecimal.ZERO) == 0)
                return new Atom(BigDecimal.ZERO);
            return new Atom(a.getReal().multiply(b.getReal().divide(gcd.getReal(), e.getMathContext())));
        } else if (a.getType() == Type.LIST && b.isNumeric()) {
            ArrayList<Atom> list = new ArrayList<>(a.getList().size());
            for (Atom x : a.getList()) {
                Atom atom = min2(e, x, b);
                list.add(atom);
            }
            return new Atom(list);
        } else if (a.isNumeric() && b.getType() == Type.LIST) {
            ArrayList<Atom> list = new ArrayList<>(b.getList().size());
            for (Atom x : b.getList()) {
                Atom atom = min2(e, a, x);
                list.add(atom);
            }
            return new Atom(list);
        } else {
            Atom gcd = Gcd.gcd2(e, a, b);
            BigComplex result;
            if (gcd.getType() == Type.COMPLEX && gcd.getReal().compareTo(BigDecimal.ZERO) == 0)
                return new Atom(BigComplex.valueOf(BigDecimal.ZERO, BigDecimal.ZERO));
            else if (gcd.getComplex().equals(BigComplex.valueOf(BigDecimal.ZERO, BigDecimal.ZERO)))
                return new Atom(BigComplex.valueOf(BigDecimal.ZERO, BigDecimal.ZERO));
            if (gcd.getType() == Type.COMPLEX)
                result = a.getComplex().multiply(b.getComplex().divide(gcd.getComplex(), e.getMathContext()));
            else
                result = a.getComplex().multiply(b.getComplex().divide(gcd.getReal(), e.getMathContext()));
            if (result.isReal())
                return new Atom(result.re);
            else
                return new Atom(result);
        }
    }

    @Override
    protected String name() {
        return "lcm";
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() == 1 && args.get(0).getType() == Type.LIST) {
            boolean seen = false;
            Atom acc = null;
            for (Atom atom : args.get(0).getList()) {
                if (!seen) {
                    seen = true;
                    acc = atom;
                } else {
                    acc = min2(env, acc, atom);
                }
            }
            return (seen ? Optional.of(acc) : Optional.<Atom>empty()).orElseThrow(() -> new ArrayError("can't fold a list with lcm."));
        }
        else if (args.size() <= 1)
            throw new RuntimeException("lcm called with too few arguments.");

        boolean seen = false;
        Atom acc = null;
        for (Atom arg : args) {
            if (!seen) {
                seen = true;
                acc = arg;
            } else {
                acc = min2(env, acc, arg);
            }
        }
        return acc;
    }
}
