package palaiologos.kamilalisp.runtime.datetime;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;
import palaiologos.kamilalisp.error.TypeError;

import java.math.BigInteger;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;

public class DateTimeToList extends PrimitiveFunction implements Lambda {
    private static Atom f(Atom a) {
        if(a.isUserdata(DateTime.class)) {
            LocalDateTime d = a.getUserdata(DateTime.class).getValue();
            return new Atom(List.of(
                    new Atom(BigInteger.valueOf(d.getYear())),
                    new Atom(BigInteger.valueOf(d.getMonthValue())),
                    new Atom(BigInteger.valueOf(d.getDayOfMonth())),
                    new Atom(BigInteger.valueOf(d.getHour())),
                    new Atom(BigInteger.valueOf(d.getMinute())),
                    new Atom(BigInteger.valueOf(d.getSecond())),
                    new Atom(BigInteger.valueOf(d.getNano()))
            ));
        } else if(a.isUserdata(Time.class)) {
            Duration d = a.getUserdata(Time.class).getValue();
            return new Atom(List.of(
                    new Atom(BigInteger.valueOf(d.toHoursPart())),
                    new Atom(BigInteger.valueOf(d.toMinutesPart())),
                    new Atom(BigInteger.valueOf(d.toSecondsPart())),
                    new Atom(BigInteger.valueOf(d.toNanosPart()))
            ));
        } else {
            throw new TypeError("`date:to-list' not defined for: " + a.getType());
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.size() == 1)
            return f(args.get(0));
        else
            return new Atom(args.stream().map(DateTimeToList::f).toList());
    }

    @Override
    protected String name() {
        return "date:to-list";
    }
}
