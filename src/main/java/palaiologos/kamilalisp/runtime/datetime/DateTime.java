package palaiologos.kamilalisp.runtime.datetime;

import com.google.common.collect.ImmutableMap;
import palaiologos.kamilalisp.atom.Callable;
import palaiologos.kamilalisp.atom.Userdata;

import java.time.LocalDateTime;

public class DateTime implements Userdata {
    private final LocalDateTime value;

    public LocalDateTime getValue() {
        return value;
    }

    public DateTime(LocalDateTime value) {
        this.value = value;
    }

    @Override
    public ImmutableMap<String, Callable> getMethods() {
        return ImmutableMap.of();
    }

    @Override
    public int compareTo(Userdata other) {
        return value.compareTo(((DateTime) other).value);
    }

    @Override
    public boolean equals(Userdata other) {
        return value.equals(((DateTime) other).value);
    }

    @Override
    public String toDisplayString() {
        return value.toString();
    }

    @Override
    public String typeName() {
        return "datetime";
    }

    @Override
    public boolean coerceBoolean() {
        return true;
    }
}
