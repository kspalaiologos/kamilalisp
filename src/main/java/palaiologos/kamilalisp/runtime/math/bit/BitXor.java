package palaiologos.kamilalisp.runtime.math.bit;

import com.google.common.collect.Streams;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.ArrayError;
import palaiologos.kamilalisp.error.TypeError;

import java.util.List;
import java.util.stream.Collectors;

public class BitXor extends PrimitiveFunction implements Lambda {
    private static final String name = "bit:xor";

    public static Atom bitop2(Atom a, Atom b) {
        a.assertTypes(Type.INTEGER, Type.LIST);
        b.assertTypes(Type.INTEGER, Type.LIST);
        if (a.getType() == Type.INTEGER && b.getType() == Type.INTEGER) {
            return new Atom(a.getInteger().xor(b.getInteger()));
        } else if (a.getType() == Type.LIST && b.getType() == Type.LIST) {
            List<Atom> A = a.getList();
            List<Atom> B = b.getList();
            if (A.size() != B.size())
                throw new ArrayError("Mismatched input shapes: `" + name + "'-ing vectors of length " + A.size() + " and " + B.size() + ".");
            return new Atom(Streams.zip(A.stream(), B.stream(), BitXor::bitop2).collect(Collectors.toList()));
        } else if (a.getType() == Type.LIST && b.getType() == Type.INTEGER) {
            return new Atom(a.getList().stream().map(x -> bitop2(x, b)).collect(Collectors.toList()));
        } else if (a.getType() == Type.INTEGER && b.getType() == Type.LIST) {
            return new Atom(b.getList().stream().map(x -> bitop2(a, x)).collect(Collectors.toList()));
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
            return args.stream().reduce(BitXor::bitop2).get();
        }
    }

    @Override
    protected String name() {
        return name;
    }
}
