package palaiologos.kamilalisp.runtime.datetime;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.math.BigInteger;
import java.time.Duration;
import java.util.List;

public record Time(Duration value) implements Userdata {
    private static class AddOp extends PrimitiveFunction implements Lambda {
        private final Time value;

        public AddOp(Time value) {
            this.value = value;
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if(args.size() == 0)
                throw new TypeError("Expected 1 or more arguments to `time.add'");
            return args.stream().reduce(new Atom(value), AbstractTime::add);
        }

        @Override
        public String name() {
            return "time.add";
        }
    }

    private static class SubOp extends PrimitiveFunction implements Lambda {
        private final Time value;

        public SubOp(Time value) {
            this.value = value;
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if(args.size() == 0)
                throw new TypeError("Expected 1 or more arguments to `time.sub'");
            return args.stream().reduce(new Atom(value), AbstractTime::sub);
        }

        @Override
        public String name() {
            return "time.sub";
        }
    }

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
            case "add" -> new Atom(new AddOp(this));
            case "sub" -> new Atom(new SubOp(this));
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
