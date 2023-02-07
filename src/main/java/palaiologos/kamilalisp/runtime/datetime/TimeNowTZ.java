package palaiologos.kamilalisp.runtime.datetime;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.List;

public class TimeNowTZ extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.isEmpty()) {
            // Local time
            LocalDateTime now = LocalDateTime.now();
            return new Atom(new Time(Duration.ofHours(now.getHour()).plusMinutes(now.getMinute()).plusSeconds(now.getSecond()).plusNanos(now.getNano())));
        } else if (args.size() == 1) {
            // Time in string timezone id.
            args.get(0).assertTypes(Type.STRING);
            String tz = args.get(0).getString();
            LocalDateTime now = LocalDateTime.now(ZoneId.of(tz));
            return new Atom(new Time(Duration.ofHours(now.getHour()).plusMinutes(now.getMinute()).plusSeconds(now.getSecond()).plusNanos(now.getNano())));
        } else {
            throw new TypeError("Expected one or zero arguments to `time:now-tz'.");
        }
    }

    @Override
    protected String name() {
        return "time:now-tz";
    }
}
