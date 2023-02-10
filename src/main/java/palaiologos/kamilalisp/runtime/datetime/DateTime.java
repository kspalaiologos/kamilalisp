package palaiologos.kamilalisp.runtime.datetime;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.math.BigInteger;
import java.time.LocalDateTime;
import java.util.List;

public record DateTime(LocalDateTime value) implements Userdata {
    private static class AddOp extends PrimitiveFunction implements Lambda {
        private final DateTime value;

        public AddOp(DateTime value) {
            this.value = value;
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if(args.size() == 0)
                throw new TypeError("Expected 1 or more arguments to `datetime.add'");
            return args.stream().reduce(new Atom(value), AbstractTime::add);
        }

        @Override
        public String name() {
            return "datetime.add";
        }
    }

    private static class SubOp extends PrimitiveFunction implements Lambda {
        private final DateTime value;

        public SubOp(DateTime value) {
            this.value = value;
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if(args.size() == 0)
                throw new TypeError("Expected 1 or more arguments to `datetime.sub'");
            return args.stream().reduce(new Atom(value), AbstractTime::sub);
        }

        @Override
        public String name() {
            return "datetime.sub";
        }
    }

    @Override
    public Atom field(Object key) {
        if (!(key instanceof String))
            throw new UnsupportedOperationException("DateTime does not support field access");
        return switch ((String) key) {
            case "year" -> new Atom(BigInteger.valueOf(value.getYear()));
            case "month" -> new Atom(BigInteger.valueOf(value.getMonthValue()));
            case "day" -> new Atom(BigInteger.valueOf(value.getDayOfMonth()));
            case "day-of-week" -> new Atom(BigInteger.valueOf(value.getDayOfWeek().getValue()));
            case "day-of-week-str" -> new Atom(value.getDayOfWeek().toString());
            case "hour" -> new Atom(BigInteger.valueOf(value.getHour()));
            case "minute" -> new Atom(BigInteger.valueOf(value.getMinute()));
            case "second" -> new Atom(BigInteger.valueOf(value.getSecond()));
            case "nanosecond" -> new Atom(BigInteger.valueOf(value.getNano()));
            case "as-list" -> new Atom(List.of(
                    new Atom(BigInteger.valueOf(value.getYear())),
                    new Atom(BigInteger.valueOf(value.getMonthValue())),
                    new Atom(BigInteger.valueOf(value.getDayOfMonth())),
                    new Atom(BigInteger.valueOf(value.getHour())),
                    new Atom(BigInteger.valueOf(value.getMinute())),
                    new Atom(BigInteger.valueOf(value.getSecond())),
                    new Atom(BigInteger.valueOf(value.getNano()))
            ));
            case "add" -> new Atom(new AddOp(this));
            case "sub" -> new Atom(new SubOp(this));
            default -> throw new UnsupportedOperationException("DateTime does not support field access");
        };
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
    public String toString() {
        return value.toString();
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
