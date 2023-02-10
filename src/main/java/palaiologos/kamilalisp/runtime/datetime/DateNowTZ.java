package palaiologos.kamilalisp.runtime.datetime;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.List;

public class DateNowTZ extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.isEmpty()) {
            // Local time
            return new Atom(new DateTime(LocalDateTime.now()));
        } else if (args.size() == 1) {
            // Time in string timezone id.
            args.get(0).assertTypes(Type.STRING);
            String tz = args.get(0).getString();
            return new Atom(new DateTime(LocalDateTime.now(ZoneId.of(tz))));
        } else {
            throw new TypeError("Expected one or zero arguments to `date:now'.");
        }
    }

    @Override
    protected String name() {
        return "date:now";
    }
}
