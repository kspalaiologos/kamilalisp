package palaiologos.kamilalisp.runtime.math;

import ch.obermuhlner.math.big.BigComplexMath;
import ch.obermuhlner.math.big.BigDecimalMath;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.util.List;
import java.util.stream.Collectors;

public class Gamma extends PrimitiveFunction implements Lambda {
    private static Atom gamma1(Environment e, Atom a) {
        a.assertTypes(Type.INTEGER, Type.REAL, Type.COMPLEX, Type.LIST);
        if (a.getType() == Type.COMPLEX) {
            return new Atom(BigComplexMath.gamma(a.getComplex(), e.getMathContext()));
        } else if (a.getType() == Type.REAL || a.getType() == Type.INTEGER) {
            return new Atom(BigDecimalMath.gamma(a.getReal(), e.getMathContext()));
        } else if (a.getType() == Type.LIST) {
            return new Atom(a.getList().stream().map(x -> gamma1(e, x)).collect(Collectors.toList()));
        } else {
            throw new TypeError("`gamma' not defined for: " + a.getType());
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() == 1) {
            return gamma1(env, args.get(0));
        } else if (args.isEmpty()) {
            throw new TypeError("Expected 1 or more arguments to `gamma'.");
        } else {
            return new Atom(args.stream().map(x -> gamma1(env, x)).toList());
        }
    }

    @Override
    protected String name() {
        return "gamma";
    }
}
