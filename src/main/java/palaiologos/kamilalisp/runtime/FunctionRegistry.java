package palaiologos.kamilalisp.runtime;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;

public class FunctionRegistry {
    public static void registerDefault(Environment env) {
        env.set("lambda", new Atom(new Dfn()));
        env.set("def", new Atom(new GlobalBinding()));
        env.set("+", new Atom(new Plus()));
        env.set("-", new Atom(new Minus()));
    }
}
