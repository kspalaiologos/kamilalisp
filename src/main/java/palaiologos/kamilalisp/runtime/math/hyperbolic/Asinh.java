package palaiologos.kamilalisp.runtime.math.hyperbolic;

import ch.obermuhlner.math.big.BigComplex;
import ch.obermuhlner.math.big.BigComplexMath;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.math.MathContext;
import java.util.List;
import java.util.stream.Collectors;

public class Asinh extends PrimitiveFunction implements Lambda {
    private static final String name = "asinh";

    private static BigComplex imagTrig(BigComplex z, MathContext mc) {
        // asinh(z) = ln(z + sqrt(z^2 + 1))
        BigComplex x = BigComplexMath.sqrt(z.multiply(z).add(BigComplex.ONE, mc), mc);
        return BigComplexMath.log(z.add(x, mc), mc);
    }

    public static Atom trig1(Environment env, Atom a) {
        a.assertTypes(Type.REAL, Type.COMPLEX, Type.LIST);
        if(a.getType() == Type.COMPLEX) {
            return new Atom(imagTrig(a.getComplex(), env.getMathContext()));
        } else if(a.getType() == Type.REAL) {
            BigComplex arg = BigComplex.valueOf(a.getReal());
            BigComplex result = imagTrig(arg, env.getMathContext());
            if(result.isReal())
                return new Atom(result.re);
            else
                return new Atom(result);
        } else if(a.getType() == Type.LIST) {
            return new Atom(a.getList().stream().map(x -> trig1(env, a)).collect(Collectors.toList()));
        } else {
            throw new TypeError("`" + name + "' not defined for: " + a.getType());
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.size() == 1) {
            return trig1(env, args.get(0));
        } else if(args.size() == 0) {
            throw new TypeError("Expected 1 or more arguments to `" + name + "'.");
        } else {
            return new Atom(args.stream().map(x -> trig1(env, x)).toList());
        }
    }

    @Override
    protected String name() {
        return name;
    }
}
