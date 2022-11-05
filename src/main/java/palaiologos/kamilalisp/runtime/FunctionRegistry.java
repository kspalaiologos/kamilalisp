package palaiologos.kamilalisp.runtime;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.runtime.array.Car;
import palaiologos.kamilalisp.runtime.array.Cdr;
import palaiologos.kamilalisp.runtime.array.Lift;
import palaiologos.kamilalisp.runtime.array.Reverse;
import palaiologos.kamilalisp.runtime.math.*;

import java.math.BigDecimal;

public class FunctionRegistry {
    public static void registerDefault(Environment env) {
        env.set("fr", new Atom(new BigDecimal(10)));
        env.set("lambda", new Atom(new Dfn()));
        env.set("def", new Atom(new GlobalBinding()));
        env.set("+", new Atom(new Plus()));
        env.set("-", new Atom(new Minus()));
        env.set("*", new Atom(new Star()));
        env.set("/", new Atom(new Slash()));
        env.set("car", new Atom(new Car()));
        env.set("cdr", new Atom(new Cdr()));
        env.set("reverse", new Atom(new Reverse()));
        env.set("lift", new Atom(new Lift()));
        env.set("mod", new Atom(new Mod()));
    }
}
