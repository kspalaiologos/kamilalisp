package kamilalisp.data;

import java.util.List;

public interface Macro extends Callable {
    Atom apply(Executor env, List<Atom> arguments);
}
