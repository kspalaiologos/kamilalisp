package kamilalisp.data;

import java.util.List;

public interface Callable {
    default String representation() {
        return "callable/syn";
    }
    Atom apply(Executor env, List<Atom> arguments);
}
