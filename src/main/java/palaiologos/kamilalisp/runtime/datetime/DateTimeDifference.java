package palaiologos.kamilalisp.runtime.datetime;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;
import palaiologos.kamilalisp.error.TypeError;

import java.time.Duration;
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
            Duration x = b.getUserdata(Time.class).getValue();
            v = v.minusHours(x.toHoursPart());
            v = v.minusMinutes(x.toMinutesPart());
            v = v.minusSeconds(x.toSecondsPart());
            v = v.minusNanos(x.toNanosPart());
            return new Atom(new DateTime(v));
        } else if(a.isUserdata(Time.class) && b.isUserdata(DateTime.class)) {
            Duration v = a.getUserdata(Time.class).getValue();
            LocalDateTime x = b.getUserdata(DateTime.class).getValue();
            LocalDateTime z = LocalDateTime.of(0, 1, 1, v.toHoursPart(), v.toMinutesPart(), v.toSecondsPart(), v.toNanosPart());
            z = z.plusDays(v.toDaysPart());
            z = z.minusHours(x.getHour());
            z = z.minusMinutes(x.getMinute());
            z = z.minusSeconds(x.getSecond());
            z = z.minusNanos(x.getNano());
            return new Atom(new DateTime(z));
        } else if(a.isUserdata(Time.class) && b.isUserdata(Time.class)) {
            Duration v = b.getUserdata(Time.class).getValue();
            Duration x = a.getUserdata(Time.class).getValue();
            v = v.minusHours(x.toHoursPart());
            v = v.minusMinutes(x.toMinutesPart());
            v = v.minusSeconds(x.toSecondsPart());
            v = v.minusNanos(x.toNanosPart());
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
            throw new TypeError("Expected 2 or more arguments to `date:difference'.");
        } else {
            return args.stream().reduce(DateTimeDifference::f).get();
        }
    }

    @Override
    protected String name() {
        return "date:difference";
    }
}
