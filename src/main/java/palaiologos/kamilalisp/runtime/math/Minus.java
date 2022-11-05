package palaiologos.kamilalisp.runtime.math;

import ch.obermuhlner.math.big.BigComplex;
import com.google.common.collect.Streams;
import org.apache.commons.lang3.StringUtils;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.ArrayError;
import palaiologos.kamilalisp.error.TypeError;

import java.util.List;
import java.util.stream.Collectors;

public class Minus extends PrimitiveFunction implements Lambda {
    public static Atom subtract2(Atom a, Atom b) {
        a.assertTypes(Type.REAL, Type.COMPLEX, Type.STRING, Type.LIST);
        b.assertTypes(Type.REAL, Type.COMPLEX, Type.STRING, Type.LIST);
        if(a.getType() == Type.COMPLEX || b.getType() == Type.COMPLEX) {
            return new Atom(a.getComplex().subtract(b.getComplex()));
        } else if(a.getType() == Type.REAL && b.getType() == Type.REAL) {
            return new Atom(a.getReal().subtract(b.getReal()));
        } else if(a.getType() == Type.REAL && b.getType() == Type.COMPLEX) {
            return new Atom(BigComplex.valueOf(a.getReal()).subtract(b.getComplex()));
        } else if(a.getType() == Type.COMPLEX && b.getType() == Type.REAL) {
            return new Atom(a.getComplex().subtract(b.getReal()));
        } else if(a.getType() == Type.STRING && b.getType() == Type.STRING) {
            return new Atom(StringUtils.remove(a.getString(), b.getString()));
        } else if(a.getType() == Type.LIST || b.getType() == Type.LIST) {
            List<Atom> A = a.getList();
            List<Atom> B = b.getList();
            if(A.size() != B.size())
                throw new ArrayError("Mismatched input shapes: Subtracting vectors of length " + A.size() + " and " + B.size() + ".");
            return new Atom(Streams.zip(A.stream(), B.stream(), Minus::subtract2).collect(Collectors.toList()));
        } else {
            throw new TypeError("- not defined for: " + a.getType() + " and " + b.getType());
        }
    }

    public static Atom subtract1(Atom a) {
        a.assertTypes(Type.REAL, Type.COMPLEX, Type.LIST);
        if(a.getType() == Type.COMPLEX) {
            return new Atom(a.getComplex().negate());
        } else if(a.getType() == Type.REAL) {
            return new Atom(a.getReal().negate());
        } else if(a.getType() == Type.LIST) {
            return new Atom(a.getList().stream().map(Minus::subtract1).collect(Collectors.toList()));
        } else {
            throw new TypeError("- not defined for: " + a.getType());
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.size() == 1) {
            return subtract1(args.get(0));
        } else if(args.size() == 2) {
            return subtract2(args.get(0), args.get(1));
        } else if(args.size() == 0) {
            throw new TypeError("Expected 1 or more arguments to `-'.");
        } else {
            return args.stream().reduce(Minus::subtract2).get();
        }
    }

    @Override
    protected String name() {
        return "-";
    }
}
