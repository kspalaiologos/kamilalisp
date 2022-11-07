package palaiologos.kamilalisp.runtime.math;

import ch.obermuhlner.math.big.BigComplex;
import com.google.common.collect.Streams;
import org.apache.commons.lang3.StringUtils;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.ArrayError;
import palaiologos.kamilalisp.error.TypeError;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.List;
import java.util.stream.Collectors;

public class Signum extends PrimitiveFunction implements Lambda {
    public static Atom sgn1(Atom a) {
        a.assertTypes(Type.INTEGER, Type.REAL, Type.COMPLEX, Type.LIST);
        if(a.getType() == Type.COMPLEX) {
            return new Atom(BigComplex.valueOf(a.getComplex().re.signum(), a.getComplex().im.signum()));
        } else if(a.getType() == Type.REAL) {
            return new Atom(BigDecimal.valueOf(a.getReal().signum()));
        } else if(a.getType() == Type.INTEGER) {
            return new Atom(BigInteger.valueOf(a.getInteger().signum()));
        } else if(a.getType() == Type.LIST) {
            return new Atom(a.getList().stream().map(Signum::sgn1).collect(Collectors.toList()));
        } else {
            throw new TypeError("`signum' not defined for: " + a.getType());
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.size() == 1) {
            return sgn1(args.get(0));
        } else if(args.size() == 0) {
            throw new TypeError("Expected 1 or more arguments to `signum'.");
        } else {
            return new Atom(args.stream().map(Signum::sgn1).toList());
        }
    }

    @Override
    protected String name() {
        return "signum";
    }
}
