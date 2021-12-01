package kamilalisp.libs.primitives.statistics;

import kamilalisp.data.*;
import kamilalisp.libs.primitives.list.Sort;
import kamilalisp.libs.primitives.math.Add;
import kamilalisp.libs.primitives.math.Quotient;

import java.math.BigDecimal;
import java.util.List;

public class Median implements Closure {
    public static Atom median(List<Atom> l, Executor env) {
        List<Atom> list = Sort.sort(l);
        if(list.size() % 2 == 0)
            return Quotient.div2(env.env, Add.add2(list.get(list.size() / 2), list.get(list.size() / 2 - 1)), new Atom(new BigDecimal(2)));
        else
            return list.get(list.size() / 2);
    }

    @Override
    public Atom apply(Executor env, List<Atom> arguments) {
        if(arguments.size() != 1)
            throw new Error("'median' expects exactly one argument.");
        return new Atom(new LbcSupplier<>(() -> {
            arguments.get(0).guardType("Argument to 'median'", Type.LIST);
            return median(arguments.get(0).getList().get(), env).get().get();
        }));
    }
}
