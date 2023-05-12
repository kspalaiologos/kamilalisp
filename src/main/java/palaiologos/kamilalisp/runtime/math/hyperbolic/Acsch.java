package palaiologos.kamilalisp.runtime.math.hyperbolic;

import ch.obermuhlner.math.big.BigComplex;
import ch.obermuhlner.math.big.BigComplexMath;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.math.MathContext;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class Acsch extends PrimitiveFunction implements Lambda {
    private static final String name = "acsch";

    private static BigComplex imagTrig(BigComplex z, MathContext mc) {
        // acsch(z) = ln(1/x + sqrt(1 + 1/x^2))
        BigComplex x = BigComplex.ONE.divide(z, mc);
        BigComplex root = BigComplexMath.sqrt(BigComplex.ONE.add(x.multiply(x, mc), mc), mc);
        return BigComplexMath.log(BigComplex.ONE.add(root, mc).divide(x, mc), mc);
    }

    private static Atom trig1(Environment env, Atom a) {
        a.assertTypes(Type.INTEGER, Type.REAL, Type.COMPLEX, Type.LIST);
        if (a.getType() == Type.COMPLEX) {
            return new Atom(imagTrig(a.getComplex(), env.getMathContext()));
        } else if (a.getType() == Type.REAL || a.getType() == Type.INTEGER) {
            BigComplex arg = BigComplex.valueOf(a.getReal());
            BigComplex result = imagTrig(arg, env.getMathContext());
            if (result.isReal())
                return new Atom(result.re);
            else
                return new Atom(result);
        } else if (a.getType() == Type.LIST) {
            ArrayList<Atom> list = new ArrayList<>();
            for (Atom x : a.getList()) {
                Atom atom = trig1(env, a);
                list.add(atom);
            }
            return new Atom(list);
        } else {
            throw new TypeError("`" + name + "' not defined for: " + a.getType());
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() == 1) {
            return trig1(env, args.get(0));
        } else if (args.isEmpty()) {
            throw new TypeError("Expected 1 or more arguments to `" + name + "'.");
        } else {
            ArrayList<Atom> list = new ArrayList<>();
            for (Atom x : args) {
                Atom atom = trig1(env, x);
                list.add(atom);
            }
            return new Atom(list);
        }
    }

    @Override
    protected String name() {
        return name;
    }
}
