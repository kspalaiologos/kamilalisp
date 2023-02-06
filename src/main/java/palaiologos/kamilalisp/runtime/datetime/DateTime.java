package palaiologos.kamilalisp.runtime.datetime;

import com.google.common.collect.ImmutableMap;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Userdata;

import java.time.LocalDateTime;

public class DateTime implements Userdata {
    private final LocalDateTime value;

    public DateTime(LocalDateTime value) {
        this.value = value;
    }

    public LocalDateTime getValue() {
        return value;
    }

    @Override
    public Atom field(Object key) {
        throw new UnsupportedOperationException("DateTime does not support field access");
    }

    @Override
    public int compareTo(Userdata other) {
        if (!(other instanceof DateTime))
            return other.hashCode() - hashCode();
        return value.compareTo(((DateTime) other).value);
    }

    @Override
    public boolean equals(Userdata other) {
        if (!(other instanceof DateTime))
            return false;
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
