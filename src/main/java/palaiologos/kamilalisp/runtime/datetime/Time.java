package palaiologos.kamilalisp.runtime.datetime;

import com.google.common.collect.ImmutableMap;
import palaiologos.kamilalisp.atom.Callable;
import palaiologos.kamilalisp.atom.Userdata;

import java.time.Duration;

public class Time implements Userdata {
    private final Duration value;

    public Time(Duration value) {
        this.value = value;
    }

    public Duration getValue() {
        return value;
    }

    @Override
    public ImmutableMap<String, Callable> getMethods() {
        return ImmutableMap.of();
    }

    @Override
    public int compareTo(Userdata other) {
        if (!(other instanceof Time))
            return other.hashCode() - hashCode();
        return value.compareTo(((Time) other).value);
    }

    @Override
    public boolean equals(Userdata other) {
        if (!(other instanceof Time))
            return false;
        return value.equals(((Time) other).value);
    }

    @Override
    public String toDisplayString() {
        return value.toString();
    }

    @Override
    public String typeName() {
        return "time";
    }

    @Override
    public boolean coerceBoolean() {
        return true;
    }
}
