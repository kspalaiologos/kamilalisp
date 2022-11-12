package palaiologos.kamilalisp.runtime.datetime;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;
import palaiologos.kamilalisp.error.TypeError;

import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

public class DateTimeDifference extends PrimitiveFunction implements Lambda {
    private static Atom f(Atom a, Atom b) {
        if(a.isUserdata(DateTime.class) && b.isUserdata(DateTime.class)) {
            LocalDateTime v = a.getUserdata(DateTime.class).getValue();
            LocalDateTime x = b.getUserdata(DateTime.class).getValue();
            v = v.minusYears(x.getYear());
            v = v.minusMonths(x.getMonthValue());
            v = v.minusDays(x.getDayOfMonth());
            v = v.minusHours(x.getHour());
            v = v.minusMinutes(x.getMinute());
            v = v.minusSeconds(x.getSecond());
            v = v.minusNanos(x.getNano());
            return new Atom(new DateTime(v));
        } else if(a.isUserdata(DateTime.class) && b.isUserdata(Time.class)) {
            LocalDateTime v = a.getUserdata(DateTime.class).getValue();
            LocalTime x = b.getUserdata(Time.class).getValue();
            v = v.minusHours(x.getHour());
            v = v.minusMinutes(x.getMinute());
            v = v.minusSeconds(x.getSecond());
            v = v.minusNanos(x.getNano());
            return new Atom(new DateTime(v));
        } else if(a.isUserdata(Time.class) && b.isUserdata(DateTime.class)) {
            LocalDateTime v = b.getUserdata(DateTime.class).getValue();
            LocalTime x = a.getUserdata(Time.class).getValue();
            v = v.minusHours(x.getHour());
            v = v.minusMinutes(x.getMinute());
            v = v.minusSeconds(x.getSecond());
            v = v.minusNanos(x.getNano());
            return new Atom(new DateTime(v));
        } else if(a.isUserdata(Time.class) && b.isUserdata(Time.class)) {
            LocalTime v = b.getUserdata(Time.class).getValue();
            LocalTime x = a.getUserdata(Time.class).getValue();
            v = v.minusHours(x.getHour());
            v = v.minusMinutes(x.getMinute());
            v = v.minusSeconds(x.getSecond());
            v = v.minusNanos(x.getNano());
            return new Atom(new Time(v));
        } else {
            throw new TypeError("Cannot subtract " + a.getType() + " and " + b.getType());
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() == 2) {
            return f(args.get(0), args.get(1));
        } else if (args.size() == 0) {
            throw new TypeError("Expected 2 or more arguments to `datetime-difference'.");
        } else {
            return args.stream().reduce(DateTimeDifference::f).get();
        }
    }

    @Override
    protected String name() {
        return "datetime-difference";
    }
}
