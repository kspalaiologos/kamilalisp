package palaiologos.kamilalisp.runtime;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.runtime.math.Minus;
import palaiologos.kamilalisp.runtime.math.Plus;
import palaiologos.kamilalisp.runtime.math.Star;

import java.math.BigDecimal;

public class FunctionRegistry {
    public static void registerDefault(Environment env) {
        env.set("fr", new Atom(new BigDecimal(10)));
        env.set("lambda", new Atom(new Dfn()));
        env.set("def", new Atom(new GlobalBinding()));
        env.set("+", new Atom(new Plus()));
        env.set("-", new Atom(new Minus()));
        env.set("*", new Atom(new Star()));
    }
}
