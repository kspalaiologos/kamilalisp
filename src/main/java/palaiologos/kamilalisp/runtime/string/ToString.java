package palaiologos.kamilalisp.runtime.string;

import ch.obermuhlner.math.big.BigComplex;
import org.apache.commons.text.similarity.LevenshteinDistance;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;
import palaiologos.kamilalisp.runtime.math.Signum;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.List;
import java.util.stream.Collectors;

public class ToString extends PrimitiveFunction implements Lambda {
    @Override
    protected String name() {
        return "to-string";
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.size() == 1) {
            return new Atom(args.get(0).toString());
        } else if(args.size() == 0) {
            throw new TypeError("Expected 1 or more arguments to `to-string'.");
        } else {
            return new Atom(args.stream().map(Atom::toString).map(Atom::new).toList());
        }
    }
}
