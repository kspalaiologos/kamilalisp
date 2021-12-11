package kamilalisp.data;

import java.util.List;

public interface Closure extends Callable {
    // A tuple of parameters and code.
    default List<Atom> requote() {
        return Atom.NULL.getList().get();
    }
}
