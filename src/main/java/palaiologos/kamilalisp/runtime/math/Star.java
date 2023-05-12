package palaiologos.kamilalisp.runtime.math;

import ch.obermuhlner.math.big.BigComplex;
import com.google.common.collect.Streams;
import org.apache.commons.lang3.StringUtils;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.ArrayError;
import palaiologos.kamilalisp.error.TypeError;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

public class Star extends PrimitiveFunction implements Lambda {
    public static Atom multiply2(Atom a, Atom b) {
        a.assertTypes(Type.INTEGER, Type.REAL, Type.COMPLEX, Type.STRING, Type.LIST);
        b.assertTypes(Type.INTEGER, Type.REAL, Type.COMPLEX, Type.STRING, Type.LIST);
        if (a.getType() == Type.COMPLEX && b.getType() == Type.COMPLEX) {
            return new Atom(a.getComplex().multiply(b.getComplex()));
        } else if (a.getType() == Type.INTEGER && b.getType() == Type.INTEGER) {
            return new Atom(a.getInteger().multiply(b.getInteger()));
        } else if ((a.getType() == Type.REAL || a.getType() == Type.INTEGER) && (b.getType() == Type.REAL || b.getType() == Type.INTEGER)) {
            return new Atom(a.getReal().multiply(b.getReal()));
        } else if ((a.getType() == Type.REAL || a.getType() == Type.INTEGER) && b.getType() == Type.COMPLEX) {
            return new Atom(BigComplex.valueOf(a.getReal()).multiply(b.getComplex()));
        } else if (a.getType() == Type.COMPLEX && (b.getType() == Type.REAL || b.getType() == Type.INTEGER)) {
            return new Atom(a.getComplex().multiply(b.getReal()));
        } else if (a.getType() == Type.STRING && b.getType() == Type.REAL) {
            return new Atom(StringUtils.repeat(a.getString(), b.getReal().intValue()));
        } else if (a.getType() == Type.LIST && b.getType() == Type.LIST) {
            List<Atom> A = a.getList();
            List<Atom> B = b.getList();
            if (A.size() != B.size())
                throw new ArrayError("Mismatched input shapes: Multiplying vectors of length " + A.size() + " and " + B.size() + ".");
            ArrayList<Atom> result = new ArrayList<>(A.size());
            for (int i = 0; i < A.size(); i++) {
                result.add(multiply2(A.get(i), B.get(i)));
            }
            return new Atom(result);
        } else if (a.getType() == Type.LIST && b.isNumeric()) {
            ArrayList<Atom> list = new ArrayList<>(a.getList().size());
            for (Atom x : a.getList()) {
                Atom atom = multiply2(x, b);
                list.add(atom);
            }
            return new Atom(list);
        } else if (a.isNumeric() && b.getType() == Type.LIST) {
            ArrayList<Atom> list = new ArrayList<>(b.getList().size());
            for (Atom x : b.getList()) {
                Atom atom = multiply2(a, x);
                list.add(atom);
            }
            return new Atom(list);
        } else {
            throw new TypeError("* not defined for: " + a.getType() + " and " + b.getType());
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() == 2) {
            return multiply2(args.get(0), args.get(1));
        } else if (args.size() <= 1) {
            throw new TypeError("Expected 2 or more arguments to `*'.");
        } else {
            boolean seen = false;
            Atom acc = null;
            for (Atom arg : args) {
                if (!seen) {
                    seen = true;
                    acc = arg;
                } else {
                    acc = multiply2(acc, arg);
                }
            }
            return acc;
        }
    }

    @Override
    protected String name() {
        return "*";
    }
}
