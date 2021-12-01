package kamilalisp.libs.primitives.statistics;

import kamilalisp.data.*;
import kamilalisp.libs.primitives.math.Add;
import kamilalisp.libs.primitives.math.Quotient;

import java.math.BigDecimal;
import java.util.List;

public class Average implements Closure {
    public static Atom average(List<Atom> list, Executor env) {
        Atom sum = new Atom(BigDecimal.ZERO);
        for(Atom x : list)
            sum = Add.add2(sum, x);
        return Quotient.div2(env.env, sum, new Atom(new BigDecimal(list.size())));
    }

    @Override
    public Atom apply(Executor env, List<Atom> arguments) {
        if(arguments.size() != 1)
            throw new Error("'avg' expects exactly one argument.");
        return new Atom(new LbcSupplier<>(() -> {
            arguments.get(0).guardType("Argument to 'avg'", Type.LIST);
            List<Atom> list = arguments.get(0).getList().get();
            return average(list, env).get().get();
        }));
    }
}
