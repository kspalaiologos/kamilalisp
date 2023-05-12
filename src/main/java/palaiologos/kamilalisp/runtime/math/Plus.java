package palaiologos.kamilalisp.runtime.math;

import ch.obermuhlner.math.big.BigComplex;
import com.google.common.collect.Streams;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.ArrayError;
import palaiologos.kamilalisp.error.TypeError;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

public class Plus extends PrimitiveFunction implements Lambda {
    private static Atom add2(Atom a, Atom b) {
        a.assertTypes(Type.INTEGER, Type.REAL, Type.COMPLEX, Type.STRING, Type.LIST);
        b.assertTypes(Type.INTEGER, Type.REAL, Type.COMPLEX, Type.STRING, Type.LIST);
        if (a.getType() == Type.COMPLEX && b.getType() == Type.COMPLEX) {
            return new Atom(a.getComplex().add(b.getComplex()));
        } else if (a.getType() == Type.INTEGER && b.getType() == Type.INTEGER) {
            return new Atom(a.getInteger().add(b.getInteger()));
        } else if (a.getType() == Type.REAL && b.getType() == Type.REAL) {
            return new Atom(a.getReal().add(b.getReal()));
        } else if (a.getType() == Type.REAL && b.getType() == Type.COMPLEX) {
            return new Atom(BigComplex.valueOf(a.getReal()).add(b.getComplex()));
        } else if (a.getType() == Type.COMPLEX && b.getType() == Type.REAL) {
            return new Atom(a.getComplex().add(b.getReal()));
        } else if (a.getType() == Type.INTEGER && b.getType() == Type.REAL) {
            return new Atom(a.getReal().add(b.getReal()));
        } else if (a.getType() == Type.REAL && b.getType() == Type.INTEGER) {
            return new Atom(a.getReal().add(b.getReal()));
        } else if (a.getType() == Type.INTEGER && b.getType() == Type.COMPLEX) {
            return new Atom(a.getComplex().add(b.getComplex()));
        } else if (a.getType() == Type.COMPLEX && b.getType() == Type.INTEGER) {
            return new Atom(a.getComplex().add(b.getComplex()));
        } else if (a.getType() == Type.STRING && b.getType() == Type.STRING) {
            return new Atom(a.getString() + b.getString());
        } else if (a.getType() == Type.STRING && (b.getType() == Type.REAL || b.getType() == Type.COMPLEX || b.getType() == Type.INTEGER)) {
            return new Atom(a.getString() + b);
        } else if ((a.getType() == Type.REAL || a.getType() == Type.COMPLEX || b.getType() == Type.INTEGER) && b.getType() == Type.STRING) {
            return new Atom(a + b.getString());
        } else if (a.getType() == Type.LIST && b.getType() == Type.LIST) {
            List<Atom> A = a.getList();
            List<Atom> B = b.getList();
            if (A.size() != B.size())
                throw new ArrayError("Mismatched input shapes: Adding vectors of length " + A.size() + " and " + B.size() + ".");
            ArrayList<Atom> list = new ArrayList<>(A.size());
            for (int i = 0; i < A.size(); i++) {
                Atom atom = add2(A.get(i), B.get(i));
                list.add(atom);
            }
            return new Atom(list);
        } else if (a.getType() == Type.LIST && b.isNumeric()) {
            ArrayList<Atom> list = new ArrayList<>(a.getList().size());
            for (Atom x : a.getList()) {
                Atom atom = add2(x, b);
                list.add(atom);
            }
            return new Atom(list);
        } else if (a.isNumeric() && b.getType() == Type.LIST) {
            ArrayList<Atom> list = new ArrayList<>(b.getList().size());
            for (Atom x : b.getList()) {
                Atom atom = add2(a, x);
                list.add(atom);
            }
            return new Atom(list);
        } else {
            throw new TypeError("+ not defined for: " + a.getType() + " and " + b.getType());
        }
    }

    private static Atom add1(Atom a) {
        a.assertTypes(Type.INTEGER, Type.REAL, Type.COMPLEX, Type.LIST);
        if (a.getType() == Type.COMPLEX) {
            return new Atom(a.getComplex().conjugate());
        } else if (a.getType() == Type.REAL || a.getType() == Type.INTEGER) {
            return a;
        } else if (a.getType() == Type.LIST) {
            ArrayList<Atom> list = new ArrayList<>(a.getList().size());
            for (Atom atom : a.getList()) {
                Atom add1 = add1(atom);
                list.add(add1);
            }
            return new Atom(list);
        } else {
            throw new TypeError("+ not defined for: " + a.getType());
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() == 1) {
            return add1(args.get(0));
        } else if (args.size() == 2) {
            return add2(args.get(0), args.get(1));
        } else if (args.isEmpty()) {
            throw new TypeError("Expected 1 or more arguments to `+'.");
        } else {
            boolean seen = false;
            Atom acc = null;
            for (Atom arg : args) {
                if (!seen) {
                    seen = true;
                    acc = arg;
                } else {
                    acc = add2(acc, arg);
                }
            }
            return acc;
        }
    }

    @Override
    protected String name() {
        return "+";
    }
}
