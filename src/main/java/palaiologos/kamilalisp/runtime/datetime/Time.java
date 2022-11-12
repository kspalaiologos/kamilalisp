package palaiologos.kamilalisp.runtime.datetime;

import com.google.common.collect.ImmutableMap;
import palaiologos.kamilalisp.atom.Callable;
import palaiologos.kamilalisp.atom.Userdata;

import java.time.LocalDateTime;
import java.time.LocalTime;

public class Time implements Userdata {
    private final LocalTime value;

    public Time(LocalTime value) {
        this.value = value;
    }

    @Override
    public ImmutableMap<String, Callable> getMethods() {
        return ImmutableMap.of();
    }

    @Override
    public int compareTo(Userdata other) {
        return value.compareTo(((Time) other).value);
    }

    @Override
    public boolean equals(Userdata other) {
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
