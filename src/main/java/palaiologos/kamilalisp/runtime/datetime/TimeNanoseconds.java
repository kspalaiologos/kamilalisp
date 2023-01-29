package palaiologos.kamilalisp.runtime.datetime;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.math.RoundingMode;
import java.time.Duration;
import java.util.List;

public class TimeNanoseconds extends PrimitiveFunction implements Lambda {
    private static Atom f(Atom a) {
        if (a.getType() == Type.LIST) {
            return new Atom(a.getList().stream().map(TimeNanoseconds::f).toList());
        } else if (a.getType() == Type.INTEGER) {
            return new Atom(new Time(Duration.ofNanos(a.getInteger().longValueExact())));
        } else if (a.getType() == Type.REAL) {
            BigDecimal current = a.getReal();
            BigInteger nanos = current.setScale(0, RoundingMode.FLOOR).unscaledValue();
            return new Atom(new Time(Duration.ofNanos(nanos.longValueExact())));
        } else {
            throw new TypeError("`time:nanoseconds' not defined for: " + a.getType());
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() == 1)
            return f(args.get(0));
        else
            return new Atom(args.stream().map(TimeNanoseconds::f).toList());
    }

    @Override
    protected String name() {
        return "time:nanoseconds";
    }
}
