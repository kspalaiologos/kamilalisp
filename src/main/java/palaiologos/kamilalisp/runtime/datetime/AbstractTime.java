package palaiologos.kamilalisp.runtime.datetime;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.error.TypeError;

import java.time.Duration;
import java.time.LocalDateTime;

public class AbstractTime {
    public static Atom add(Atom a, Atom b) {
        if (a.isUserdata(DateTime.class) && b.isUserdata(DateTime.class)) {
            LocalDateTime v = a.getUserdata(DateTime.class).value();
            LocalDateTime x = b.getUserdata(DateTime.class).value();
            v = v.plusYears(x.getYear());
            v = v.plusMonths(x.getMonthValue());
            v = v.plusDays(x.getDayOfMonth());
            v = v.plusHours(x.getHour());
            v = v.plusMinutes(x.getMinute());
            v = v.plusSeconds(x.getSecond());
            v = v.plusNanos(x.getNano());
            return new Atom(new DateTime(v));
        } else if (a.isUserdata(DateTime.class) && b.isUserdata(Time.class)) {
            LocalDateTime v = a.getUserdata(DateTime.class).value();
            Duration x = b.getUserdata(Time.class).value();
            v = v.plusHours(x.toHoursPart());
            v = v.plusMinutes(x.toMinutesPart());
            v = v.plusSeconds(x.toSecondsPart());
            v = v.plusNanos(x.toNanosPart());
            return new Atom(new DateTime(v));
        } else if (a.isUserdata(Time.class) && b.isUserdata(DateTime.class)) {
            LocalDateTime v = b.getUserdata(DateTime.class).value();
            Duration x = a.getUserdata(Time.class).value();
            v = v.plusHours(x.toHoursPart());
            v = v.plusMinutes(x.toMinutesPart());
            v = v.plusSeconds(x.toSecondsPart());
            v = v.plusNanos(x.toNanosPart());
            return new Atom(new DateTime(v));
        } else if (a.isUserdata(Time.class) && b.isUserdata(Time.class)) {
            Duration v = b.getUserdata(Time.class).value();
            Duration x = a.getUserdata(Time.class).value();
            v = v.plusHours(x.toHoursPart());
            v = v.plusMinutes(x.toMinutesPart());
            v = v.plusSeconds(x.toSecondsPart());
            v = v.plusNanos(x.toNanosPart());
            return new Atom(new Time(v));
        } else {
            throw new TypeError("Cannot add " + a.getType() + " and " + b.getType());
        }
    }

    public static Atom sub(Atom a, Atom b) {
        if (a.isUserdata(DateTime.class) && b.isUserdata(DateTime.class)) {
            LocalDateTime v = a.getUserdata(DateTime.class).value();
            LocalDateTime x = b.getUserdata(DateTime.class).value();
            v = v.minusYears(x.getYear());
            v = v.minusMonths(x.getMonthValue());
            v = v.minusDays(x.getDayOfMonth());
            v = v.minusHours(x.getHour());
            v = v.minusMinutes(x.getMinute());
            v = v.minusSeconds(x.getSecond());
            v = v.minusNanos(x.getNano());
            return new Atom(new DateTime(v));
        } else if (a.isUserdata(DateTime.class) && b.isUserdata(Time.class)) {
            LocalDateTime v = a.getUserdata(DateTime.class).value();
            Duration x = b.getUserdata(Time.class).value();
            v = v.minusHours(x.toHoursPart());
            v = v.minusMinutes(x.toMinutesPart());
            v = v.minusSeconds(x.toSecondsPart());
            v = v.minusNanos(x.toNanosPart());
            return new Atom(new DateTime(v));
        } else if (a.isUserdata(Time.class) && b.isUserdata(DateTime.class)) {
            Duration v = a.getUserdata(Time.class).value();
            LocalDateTime x = b.getUserdata(DateTime.class).value();
            LocalDateTime z = LocalDateTime.of(0, 1, 1, v.toHoursPart(), v.toMinutesPart(), v.toSecondsPart(), v.toNanosPart());
            z = z.plusDays(v.toDaysPart());
            z = z.minusHours(x.getHour());
            z = z.minusMinutes(x.getMinute());
            z = z.minusSeconds(x.getSecond());
            z = z.minusNanos(x.getNano());
            return new Atom(new DateTime(z));
        } else if (a.isUserdata(Time.class) && b.isUserdata(Time.class)) {
            Duration v = b.getUserdata(Time.class).value();
            Duration x = a.getUserdata(Time.class).value();
            v = v.minusHours(x.toHoursPart());
            v = v.minusMinutes(x.toMinutesPart());
            v = v.minusSeconds(x.toSecondsPart());
            v = v.minusNanos(x.toNanosPart());
            return new Atom(new Time(v));
        } else {
            throw new TypeError("Cannot subtract " + a.getType() + " and " + b.getType());
        }
    }
}
