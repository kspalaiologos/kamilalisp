package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.*;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class Where extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        List<Atom> indices = new ArrayList<>();
        List<Atom> inputList = args.get(0).getList();
        for (int i = 0; i < inputList.size(); i++) {
            if (inputList.get(i).getReal().compareTo(BigDecimal.ZERO) > 0) {
                int n = inputList.get(i).getReal().setScale(0, RoundingMode.UP).toBigInteger().intValueExact();
                for (int j = 0; j < n; j++) {
                    indices.add(new Atom(BigInteger.valueOf(i)));
                }
            }
        }
        return new Atom(indices);
    }

    @Override
    protected String name() {
        return "where";
    }
}
