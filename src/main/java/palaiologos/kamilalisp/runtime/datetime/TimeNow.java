package palaiologos.kamilalisp.runtime.datetime;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.ReactiveFunction;
import palaiologos.kamilalisp.atom.SpecialForm;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.List;

public class TimeNow implements SpecialForm, ReactiveFunction {
    @Override
    public int line() {
        return 0;
    }

    @Override
    public int column() {
        return 0;
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        LocalDateTime now = LocalDateTime.now(ZoneId.of("UTC"));
        return new Atom(new Time(Duration.ofHours(now.getHour()).plusMinutes(now.getMinute()).plusSeconds(now.getSecond()).plusNanos(now.getNano())));
    }

    @Override
    public String stringify() {
        return "time:now";
    }

    @Override
    public String frameString() {
        return "time:now/reactive-primitive function";
    }
}
