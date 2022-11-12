package palaiologos.kamilalisp.runtime.datetime;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.math.RoundingMode;
import java.time.Duration;
import java.time.LocalTime;
import java.util.List;

public class TimeSeconds extends PrimitiveFunction implements Lambda {
    private static Atom f(Atom a) {
        if(a.getType() == Type.LIST) {
            return new Atom(a.getList().stream().map(TimeSeconds::f).toList());
        } else if(a.getType() == Type.INTEGER) {
            return new Atom(new Time(Duration.ofSeconds(a.getInteger().longValueExact())));
        } else if(a.getType() == Type.REAL) {
            BigDecimal current = a.getReal();
            BigInteger seconds = current.setScale(0, RoundingMode.FLOOR).unscaledValue();
            current = current.subtract(new BigDecimal(seconds)).multiply(BigDecimal.valueOf(1000000000));
            BigInteger nanos = current.setScale(0, RoundingMode.FLOOR).unscaledValue();
            Duration d = Duration.ofSeconds(seconds.longValueExact()).plusNanos(nanos.longValueExact());
            return new Atom(new Time(d));
        } else {
            throw new TypeError("`time-seconds' not defined for: " + a.getType());
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.size() == 1)
            return f(args.get(0));
        else
            return new Atom(args.stream().map(TimeSeconds::f).toList());
    }

    @Override
    protected String name() {
        return "time-seconds";
    }
}
