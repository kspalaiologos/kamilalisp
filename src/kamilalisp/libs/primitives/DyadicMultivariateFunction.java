package kamilalisp.libs.primitives;

import kamilalisp.data.Atom;
import kamilalisp.data.Closure;
import kamilalisp.data.Executor;
import kamilalisp.data.LbcSupplier;

import java.util.Arrays;
import java.util.List;

public class DyadicMultivariateFunction {
    public static Atom of(Closure f) {
        return new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                return new Atom(new LbcSupplier<>(() -> {
                    if(arguments.size() <= 2)
                        return f.apply(env, arguments).get().get();
                    else {
                        return arguments.stream().reduce((x, y) ->
                                f.apply(env, Arrays.asList(x, y))
                        ).get().get().get();
                    }
                }));
            }
        });
    }
}
