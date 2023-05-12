package palaiologos.kamilalisp.runtime.math.bit;

import com.google.common.collect.Streams;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.ArrayError;
import palaiologos.kamilalisp.error.TypeError;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

public class BitNand extends PrimitiveFunction implements Lambda {
    private static final String name = "bit:nand";

    private static Atom bitop2(Atom a, Atom b) {
        a.assertTypes(Type.INTEGER, Type.LIST);
        b.assertTypes(Type.INTEGER, Type.LIST);
        if (a.getType() == Type.INTEGER && b.getType() == Type.INTEGER) {
            return new Atom(a.getInteger().and(b.getInteger()).negate());
        } else if (a.getType() == Type.LIST && b.getType() == Type.LIST) {
            List<Atom> A = a.getList();
            List<Atom> B = b.getList();
            if (A.size() != B.size())
                throw new ArrayError("Mismatched input shapes: `" + name + "'-ing vectors of length " + A.size() + " and " + B.size() + ".");
            ArrayList<Atom> list = new ArrayList<>(A.size());
            for (int i = 0; i < A.size(); i++) {
                Atom atom = bitop2(A.get(i), B.get(i));
                list.add(atom);
            }
            return new Atom(list);
        } else if (a.getType() == Type.LIST && b.getType() == Type.INTEGER) {
            ArrayList<Atom> list = new ArrayList<>(a.getList().size());
            for (Atom x : a.getList()) {
                Atom atom = bitop2(x, b);
                list.add(atom);
            }
            return new Atom(list);
        } else if (a.getType() == Type.INTEGER && b.getType() == Type.LIST) {
            ArrayList<Atom> list = new ArrayList<>(b.getList().size());
            for (Atom x : b.getList()) {
                Atom atom = bitop2(a, x);
                list.add(atom);
            }
            return new Atom(list);
        } else {
            throw new TypeError(name + " not defined for: " + a.getType() + " and " + b.getType());
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() == 2) {
            return bitop2(args.get(0), args.get(1));
        } else if (args.size() <= 1) {
            throw new TypeError("Expected 2 or more arguments to `" + name + "'.");
        } else {
            boolean seen = false;
            Atom acc = null;
            for (Atom arg : args) {
                if (!seen) {
                    seen = true;
                    acc = arg;
                } else {
                    acc = bitop2(acc, arg);
                }
            }
            return acc;
        }
    }

    @Override
    protected String name() {
        return name;
    }
}
