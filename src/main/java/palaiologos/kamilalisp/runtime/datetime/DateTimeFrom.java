package palaiologos.kamilalisp.runtime.datetime;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.util.List;

public class DateTimeFrom extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.size() == 1) {
            long timestamp = args.get(0).getInteger().longValueExact();
            return new Atom(new DateTime(LocalDateTime.ofEpochSecond(timestamp, 0, ZoneOffset.UTC)));
        } else if(args.size() == 3) {
            int year = args.get(0).getInteger().intValueExact();
            int month = args.get(1).getInteger().intValueExact();
            int day = args.get(2).getInteger().intValueExact();
            return new Atom(new DateTime(LocalDateTime.of(year, month, day, 0, 0)));
        } else if(args.size() == 6) {
            int year = args.get(0).getInteger().intValueExact();
            int month = args.get(1).getInteger().intValueExact();
            int day = args.get(2).getInteger().intValueExact();
            int hour = args.get(3).getInteger().intValueExact();
            int minute = args.get(4).getInteger().intValueExact();
            int second = args.get(5).getInteger().intValueExact();
            return new Atom(new DateTime(LocalDateTime.of(year, month, day, hour, minute, second)));
        } else if(args.size() == 7) {
            int year = args.get(0).getInteger().intValueExact();
            int month = args.get(1).getInteger().intValueExact();
            int day = args.get(2).getInteger().intValueExact();
            int hour = args.get(3).getInteger().intValueExact();
            int minute = args.get(4).getInteger().intValueExact();
            int second = args.get(5).getInteger().intValueExact();
            int nanosecond = args.get(6).getInteger().intValueExact();
            return new Atom(new DateTime(LocalDateTime.of(year, month, day, hour, minute, second, nanosecond)));
        } else {
            throw new RuntimeException("datetime-from takes one, three, six or seven arguments.");
        }
    }

    @Override
    protected String name() {
        return "datetime-from";
    }
}
