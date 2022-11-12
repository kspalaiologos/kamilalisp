package palaiologos.kamilalisp.runtime.datetime;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.time.LocalDateTime;
import java.time.Period;
import java.util.List;

public class DateDays extends PrimitiveFunction implements Lambda {
    private static Atom f(Atom a) {
        if(a.getType() == Type.LIST) {
            return new Atom(a.getList().stream().map(DateDays::f).toList());
        } else if(a.getType() == Type.INTEGER) {
            return new Atom(new DateTime(LocalDateTime.of(0, 1, 1, 0, 0).plus(Period.ofDays(a.getInteger().intValueExact()))));
        } else {
            throw new TypeError("`date:days' not defined for: " + a.getType());
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.size() == 1)
            return f(args.get(0));
        else
            return new Atom(args.stream().map(DateDays::f).toList());
    }

    @Override
    protected String name() {
        return "date:days";
    }
}
