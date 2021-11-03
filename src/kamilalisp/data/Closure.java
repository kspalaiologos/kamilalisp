package kamilalisp.data;

import java.util.List;

public interface Closure extends Callable {
    default List requote() {
        return List.of();
    }
}
