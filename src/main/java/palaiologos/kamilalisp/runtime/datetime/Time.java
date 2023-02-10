package palaiologos.kamilalisp.runtime.datetime;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Userdata;

import java.math.BigInteger;
import java.time.Duration;
import java.util.List;

public record Time(Duration value) implements Userdata {

    @Override
    public Atom field(Object key) {
        if (!(key instanceof String))
            throw new UnsupportedOperationException("Time does not support field access");
        return switch ((String) key) {
            case "hours" -> new Atom(BigInteger.valueOf(value.toHours()));
            case "minutes" -> new Atom(BigInteger.valueOf(value.toMinutes()));
            case "seconds" -> new Atom(BigInteger.valueOf(value.getSeconds()));
            case "nanoseconds" -> new Atom(BigInteger.valueOf(value.getNano()));
            case "as-list" -> new Atom(List.of(
                    new Atom(BigInteger.valueOf(value.toHours())),
                    new Atom(BigInteger.valueOf(value.toMinutes())),
                    new Atom(BigInteger.valueOf(value.getSeconds())),
                    new Atom(BigInteger.valueOf(value.getNano()))
            ));
            default -> throw new UnsupportedOperationException("Time does not support field access");
        };
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
