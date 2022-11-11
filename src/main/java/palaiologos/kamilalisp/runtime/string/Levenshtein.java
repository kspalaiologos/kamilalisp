package palaiologos.kamilalisp.runtime.string;

import org.apache.commons.text.similarity.LevenshteinDistance;
import palaiologos.kamilalisp.atom.*;

import java.math.BigDecimal;
import java.util.List;

public class Levenshtein extends PrimitiveFunction implements Lambda {
    @Override
    protected String name() {
        return "levenshtein";
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() != 2)
            throw new RuntimeException("levenshtein called with wrong number of arguments.");

        args.get(0).assertTypes(Type.STRING);
        args.get(1).assertTypes(Type.STRING);
        return new Atom(BigDecimal.valueOf(LevenshteinDistance.getDefaultInstance().apply(args.get(0).getString(), args.get(1).getString())));
    }
}
