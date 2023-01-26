package palaiologos.kamilalisp.runtime.datetime;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.ReactiveFunction;
import palaiologos.kamilalisp.atom.SpecialForm;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.List;

public class DateNow implements SpecialForm, ReactiveFunction {
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
        return new Atom(new DateTime(LocalDateTime.now(ZoneId.of("UTC"))));
    }

    @Override
    public String stringify() {
        return "date:now";
    }

    @Override
    public String frameString() {
        return "date:now/reactive-primitive function";
    }
}
