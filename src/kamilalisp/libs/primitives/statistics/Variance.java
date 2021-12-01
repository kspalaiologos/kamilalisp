package kamilalisp.libs.primitives.statistics;

import kamilalisp.data.*;
import kamilalisp.libs.primitives.math.Power;
import kamilalisp.libs.primitives.math.Sqrt;
import kamilalisp.libs.primitives.math.Subtract;

import java.math.BigDecimal;
import java.util.List;
import java.util.stream.Collectors;

public class Variance implements Closure {
    public static Atom variance(Atom source, Executor env) {
        List<Atom> data = source.getList().get();
        Atom avg = Average.average(data, env);
        Atom variance = Average.average(data.stream()
                .map(x -> Power.power(Subtract.sub2(x, avg), new Atom(new BigDecimal(2)), env))
                .collect(Collectors.toList()), env);
        return variance;
    }

    @Override
    public Atom apply(Executor env, List<Atom> arguments) {
        if(arguments.size() != 1)
            throw new Error("'variance' expects exactly one argument.");
        return new Atom(new LbcSupplier<>(() -> {
            Atom source = arguments.get(0);
            source.guardType("'variance' argument", Type.LIST);
            return variance(source, env).get().get();
        }));
    }
}
