package palaiologos.kamilalisp.runtime.datetime;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;
import palaiologos.kamilalisp.error.TypeError;

import java.math.BigInteger;
import java.time.LocalDateTime;
import java.util.List;

public class DateTimeDayOfWeek extends PrimitiveFunction implements Lambda {
    private static Atom f(Atom a) {
        if(a.isUserdata(DateTime.class)) {
            LocalDateTime d = a.getUserdata(DateTime.class).getValue();
            return new Atom(BigInteger.valueOf(d.getDayOfWeek().ordinal()));
        } else {
            throw new TypeError("`date:day-of-week' not defined for: " + a.getType());
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.size() == 1)
            return f(args.get(0));
        else
            return new Atom(args.stream().map(DateTimeDayOfWeek::f).toList());
    }

    @Override
    protected String name() {
        return "date:day-of-week";
    }
}
