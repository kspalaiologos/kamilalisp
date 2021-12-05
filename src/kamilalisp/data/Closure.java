package kamilalisp.data;

import java.util.List;

public interface Closure extends Callable {
    default Atom requote() {
        return Atom.NULL;
    }
}
