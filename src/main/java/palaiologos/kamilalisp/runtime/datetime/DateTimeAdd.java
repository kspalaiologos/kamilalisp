package palaiologos.kamilalisp.runtime.datetime;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;
import palaiologos.kamilalisp.error.TypeError;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;

public class DateTimeAdd extends PrimitiveFunction implements Lambda {
    private static Atom f(Atom a, Atom b) {
        if (a.isUserdata(DateTime.class) && b.isUserdata(DateTime.class)) {
            LocalDateTime v = a.getUserdata(DateTime.class).getValue();
            LocalDateTime x = b.getUserdata(DateTime.class).getValue();
            v = v.plusYears(x.getYear());
            v = v.plusMonths(x.getMonthValue());
            v = v.plusDays(x.getDayOfMonth());
            v = v.plusHours(x.getHour());
            v = v.plusMinutes(x.getMinute());
            v = v.plusSeconds(x.getSecond());
            v = v.plusNanos(x.getNano());
            return new Atom(new DateTime(v));
        } else if (a.isUserdata(DateTime.class) && b.isUserdata(Time.class)) {
            LocalDateTime v = a.getUserdata(DateTime.class).getValue();
            Duration x = b.getUserdata(Time.class).getValue();
            v = v.plusHours(x.toHoursPart());
            v = v.plusMinutes(x.toMinutesPart());
            v = v.plusSeconds(x.toSecondsPart());
            v = v.plusNanos(x.toNanosPart());
            return new Atom(new DateTime(v));
        } else if (a.isUserdata(Time.class) && b.isUserdata(DateTime.class)) {
            LocalDateTime v = b.getUserdata(DateTime.class).getValue();
            Duration x = a.getUserdata(Time.class).getValue();
            v = v.plusHours(x.toHoursPart());
            v = v.plusMinutes(x.toMinutesPart());
            v = v.plusSeconds(x.toSecondsPart());
            v = v.plusNanos(x.toNanosPart());
            return new Atom(new DateTime(v));
        } else if (a.isUserdata(Time.class) && b.isUserdata(Time.class)) {
            Duration v = b.getUserdata(Time.class).getValue();
            Duration x = a.getUserdata(Time.class).getValue();
            v = v.plusHours(x.toHoursPart());
            v = v.plusMinutes(x.toMinutesPart());
            v = v.plusSeconds(x.toSecondsPart());
            v = v.plusNanos(x.toNanosPart());
            return new Atom(new Time(v));
        } else {
            throw new TypeError("Cannot add " + a.getType() + " and " + b.getType());
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() == 2) {
            return f(args.get(0), args.get(1));
        } else if (args.isEmpty()) {
            throw new TypeError("Expected 2 or more arguments to `date:add'.");
        } else {
            return args.stream().reduce(DateTimeAdd::f).get();
        }
    }

    @Override
    protected String name() {
        return "date:add";
    }
}
