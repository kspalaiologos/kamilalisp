package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.math.BigInteger;
import java.util.Arrays;
import java.util.List;

public class WhereMask extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        int[] indices = args.get(0).getList().stream().mapToInt(x -> x.getInteger().intValueExact()).toArray();
        int max = Arrays.stream(indices).max().orElse(0);
        int[] mask = new int[max + 1];
        for (int index : indices)
            mask[index]++;
        return new Atom(Arrays.stream(mask).mapToObj(x -> new Atom(BigInteger.valueOf(x))).toList());
    }

    @Override
    protected String name() {
        return "where-mask";
    }
}
