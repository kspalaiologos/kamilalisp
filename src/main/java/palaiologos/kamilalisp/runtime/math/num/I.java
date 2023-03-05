package palaiologos.kamilalisp.runtime.math.num;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

public class I extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        int size = args.get(0).getInteger().intValueExact();
        List<Atom> result = new ArrayList<>();
        for (int i = 0; i < size; i++) {
            List<Atom> row = new ArrayList<>();
            for (int j = 0; j < size; j++)
                row.add(new Atom(BigInteger.valueOf(i == j ? 1 : 0)));
            result.add(new Atom(row));
        }
        return new Atom(result);
    }

    @Override
    protected String name() {
        return "num:I";
    }
}
