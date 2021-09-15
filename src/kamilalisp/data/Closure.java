package kamilalisp.data;

import java.util.List;

public interface Closure extends Callable {
    Atom apply(Executor env, List<Atom> arguments);
}
