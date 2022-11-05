package palaiologos.kamilalisp.runtime;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.runtime.array.*;
import palaiologos.kamilalisp.runtime.math.*;
import palaiologos.kamilalisp.runtime.meta.EnvKeys;

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
        env.set("range", new Atom(new Range()));
        env.set("foldl", new Atom(new Foldl()));
        env.set("foldr", new Atom(new Foldr()));
        env.set("foldl1", new Atom(new Foldl1()));
        env.set("foldr1", new Atom(new Foldr1()));
        env.set("lift", new Atom(new Lift()));
        env.set("mod", new Atom(new Mod()));
        env.set("tie", new Atom(new Tie()));
        env.set("exp", new Atom(new Exp()));

        env.set("env-keys", new Atom(new EnvKeys()));
    }
}
