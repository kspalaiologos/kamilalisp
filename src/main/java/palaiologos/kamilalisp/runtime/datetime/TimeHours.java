package palaiologos.kamilalisp.runtime.datetime;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.math.RoundingMode;
import java.time.Duration;
import java.util.List;

public class TimeHours extends PrimitiveFunction implements Lambda {
    private static Atom f(Atom a) {
        if (a.getType() == Type.LIST) {
            return new Atom(a.getList().stream().map(TimeHours::f).toList());
        } else if (a.getType() == Type.INTEGER) {
            return new Atom(new Time(Duration.ofHours(a.getInteger().longValueExact())));
        } else if (a.getType() == Type.REAL) {
            BigDecimal current = a.getReal();
            BigInteger hours = current.setScale(0, RoundingMode.FLOOR).unscaledValue();
            current = current.subtract(new BigDecimal(hours)).multiply(BigDecimal.valueOf(60));
            BigInteger minutes = current.setScale(0, RoundingMode.FLOOR).unscaledValue();
            current = current.subtract(new BigDecimal(minutes)).multiply(BigDecimal.valueOf(60));
            BigInteger seconds = current.setScale(0, RoundingMode.FLOOR).unscaledValue();
            current = current.subtract(new BigDecimal(seconds)).multiply(BigDecimal.valueOf(1000000000));
            BigInteger nanos = current.setScale(0, RoundingMode.FLOOR).unscaledValue();
            Duration d = Duration.ofHours(hours.longValueExact()).plusMinutes(minutes.longValueExact()).plusSeconds(seconds.longValueExact()).plusNanos(nanos.longValueExact());
            return new Atom(new Time(d));
        } else {
            throw new TypeError("`time:hours' not defined for: " + a.getType());
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() == 1)
            return f(args.get(0));
        else
            return new Atom(args.stream().map(TimeHours::f).toList());
    }

    @Override
    protected String name() {
        return "time:hours";
    }
}
