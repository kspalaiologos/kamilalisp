package palaiologos.kamilalisp.runtime.math;

import ch.obermuhlner.math.big.BigComplex;
import com.google.common.collect.Streams;
import org.apache.commons.lang3.StringUtils;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.ArrayError;
import palaiologos.kamilalisp.error.TypeError;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

public class Slash extends PrimitiveFunction implements Lambda {
    public static Atom quot2(Environment e, Atom a, Atom b) {
        a.assertTypes(Type.INTEGER, Type.REAL, Type.COMPLEX, Type.STRING, Type.LIST);
        b.assertTypes(Type.INTEGER, Type.REAL, Type.COMPLEX, Type.STRING, Type.LIST);
        if (a.getType() == Type.COMPLEX && b.getType() == Type.COMPLEX) {
            return new Atom(a.getComplex().divide(b.getComplex(), e.getMathContext()));
        } else if ((a.getType() == Type.REAL || a.getType() == Type.INTEGER) && (b.getType() == Type.REAL || b.getType() == Type.INTEGER)) {
            return new Atom(a.getReal().divide(b.getReal(), e.getMathContext()));
        } else if ((a.getType() == Type.REAL || a.getType() == Type.INTEGER) && b.getType() == Type.COMPLEX) {
            return new Atom(BigComplex.valueOf(a.getReal()).divide(b.getComplex(), e.getMathContext()));
        } else if (a.getType() == Type.COMPLEX && (b.getType() == Type.REAL || b.getType() == Type.INTEGER)) {
            return new Atom(a.getComplex().divide(b.getReal(), e.getMathContext()));
        } else if (a.getType() == Type.STRING && b.getType() == Type.STRING) {
            ArrayList<Atom> list = new ArrayList<>();
            for (String s : StringUtils.splitByWholeSeparator(a.getString(), b.getString())) {
                Atom atom = new Atom(s);
                list.add(atom);
            }
            return new Atom(list);
        } else if (a.getType() == Type.LIST && b.getType() == Type.LIST) {
            List<Atom> A = a.getList();
            List<Atom> B = b.getList();
            if (A.size() != B.size())
                throw new ArrayError("Mismatched input shapes: Dividing vectors of length " + A.size() + " and " + B.size() + ".");
            return new Atom(Streams.zip(A.stream(), B.stream(), (x, y) -> quot2(e, x, y)).collect(Collectors.toList()));
        } else if (a.getType() == Type.LIST && b.isNumeric()) {
            ArrayList<Atom> list = new ArrayList<>(a.getList().size());
            for (Atom x : a.getList()) {
                Atom atom = quot2(e, x, b);
                list.add(atom);
            }
            return new Atom(list);
        } else if (a.isNumeric() && b.getType() == Type.LIST) {
            ArrayList<Atom> list = new ArrayList<>(b.getList().size());
            for (Atom x : b.getList()) {
                Atom atom = quot2(e, a, x);
                list.add(atom);
            }
            return new Atom(list);
        } else {
            throw new TypeError("/ not defined for: " + a.getType() + " and " + b.getType());
        }
    }

    public static Atom quot1(Environment e, Atom a) {
        a.assertTypes(Type.INTEGER, Type.REAL, Type.COMPLEX, Type.LIST);
        if (a.getType() == Type.COMPLEX) {
            return new Atom(a.getComplex().reciprocal(e.getMathContext()));
        } else if (a.getType() == Type.REAL || a.getType() == Type.INTEGER) {
            return new Atom(BigDecimal.ONE.divide(a.getReal(), e.getMathContext()));
        } else if (a.getType() == Type.LIST) {
            ArrayList<Atom> list = new ArrayList<>(a.getList().size());
            for (Atom x : a.getList()) {
                Atom atom = quot1(e, x);
                list.add(atom);
            }
            return new Atom(list);
        } else {
            throw new TypeError("/ not defined for: " + a.getType());
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() == 1) {
            return quot1(env, args.get(0));
        } else if (args.size() == 2) {
            return quot2(env, args.get(0), args.get(1));
        } else if (args.isEmpty()) {
            throw new TypeError("Expected 1 or more arguments to `/'.");
        } else {
            boolean seen = false;
            Atom acc = null;
            for (Atom arg : args) {
                if (!seen) {
                    seen = true;
                    acc = arg;
                } else {
                    acc = quot2(env, acc, arg);
                }
            }
            return acc;
        }
    }

    @Override
    protected String name() {
        return "/";
    }
}
