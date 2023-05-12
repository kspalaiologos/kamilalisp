package palaiologos.kamilalisp.runtime.math.hyperbolic;

import ch.obermuhlner.math.big.BigComplex;
import ch.obermuhlner.math.big.BigComplexMath;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.math.MathContext;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class Sinh extends PrimitiveFunction implements Lambda {
    private static final String name = "sinh";

    private static BigComplex imagTrig(BigComplex z, MathContext mc) {
        // sinh(z) = (e^z - e^-z) / 2
        BigComplex e_z = BigComplexMath.exp(z, mc);
        BigComplex e_neg_z = BigComplexMath.exp(z.negate(), mc);
        return e_z.subtract(e_neg_z).divide(BigComplex.valueOf(2), mc);
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
