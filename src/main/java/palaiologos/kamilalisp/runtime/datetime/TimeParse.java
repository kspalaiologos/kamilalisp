package palaiologos.kamilalisp.runtime.datetime;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.time.Duration;
import java.time.LocalTime;
import java.util.List;

public class TimeParse extends PrimitiveFunction implements Lambda {
    private Atom parseTimeFrom(Atom a) {
        a.assertTypes(Type.STRING, Type.LIST);
        if (a.getType() == Type.LIST) {
            return new Atom(a.getList().stream().map(this::parseTimeFrom).toList());
        } else {
            LocalTime t = LocalTime.parse(a.getString());
            return new Atom(new Time(Duration.ofHours(t.getHour()).plusMinutes(t.getMinute()).plusSeconds(t.getSecond()).plusNanos(t.getNano())));
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() == 1) {
            return parseTimeFrom(args.get(0));
        } else if (args.size() > 1) {
            return new Atom(args.stream().map(this::parseTimeFrom).toList());
        } else {
            throw new TypeError("time:parse requires at least one argument");
        }
    }

    @Override
    protected String name() {
        return "time:parse";
    }
}
