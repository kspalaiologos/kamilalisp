package kamilalisp.data;

import java.util.Optional;
import java.util.function.Supplier;

public class LbcSupplier<T> {
    private Supplier<T> supplier; private Optional<T> value;

    public LbcSupplier(Supplier<T> s) {
        this.supplier = s; this.value = Optional.empty();
    }

    public LbcSupplier(T t) {
        this.supplier = null; this.value = Optional.of(t);
    }

    public T get() {
        if(value.isEmpty()) {
            value = Optional.of(supplier.get());
            supplier = null;
        }

        return value.get();
    }
}
