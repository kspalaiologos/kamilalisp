package palaiologos.kamilalisp.runtime.datetime;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.time.LocalTime;
import java.util.List;

public class TimeFrom extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.size() == 2) {
            int hour = args.get(0).getInteger().intValueExact();
            int minute = args.get(1).getInteger().intValueExact();
            return new Atom(new Time(LocalTime.of(hour, minute, 0)));
        } else if(args.size() == 3) {
            int hour = args.get(0).getInteger().intValueExact();
            int minute = args.get(1).getInteger().intValueExact();
            int second = args.get(2).getInteger().intValueExact();
            return new Atom(new Time(LocalTime.of(hour, minute, second)));
        } else if(args.size() == 4) {
            int hour = args.get(0).getInteger().intValueExact();
            int minute = args.get(1).getInteger().intValueExact();
            int second = args.get(2).getInteger().intValueExact();
            int nanosecond = args.get(3).getInteger().intValueExact();
            return new Atom(new Time(LocalTime.of(hour, minute, second, nanosecond)));
        } else {
            throw new RuntimeException("time-from expects 3 or 4 arguments.");
        }
    }

    @Override
    protected String name() {
        return "time-from";
    }
}
