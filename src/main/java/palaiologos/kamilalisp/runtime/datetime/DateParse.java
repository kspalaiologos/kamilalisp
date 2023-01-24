package palaiologos.kamilalisp.runtime.datetime;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.ZonedDateTime;
import java.util.Date;
import java.util.List;

public class DateParse extends PrimitiveFunction implements Lambda {
    private Atom parseDateFrom(Atom a) {
        a.assertTypes(Type.STRING, Type.LIST);
        if(a.getType() == Type.LIST) {
            return new Atom(a.getList().stream().map(this::parseDateFrom).toList());
        } else {
            LocalDateTime t = LocalDateTime.parse(a.getString());
            return new Atom(new DateTime(t));
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() == 1) {
            return parseDateFrom(args.get(0));
        } else if(args.size() > 1) {
            return new Atom(args.stream().map(this::parseDateFrom).toList());
        } else {
            throw new TypeError("date:parse requires at least one argument");
        }
    }

    @Override
    protected String name() {
        return "date:parse";
    }
}
