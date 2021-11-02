package kamilalisp.libs;

import kamilalisp.data.*;

import java.util.List;

public class IOLib {
    public static void install(Environment env) {
        env.push("println", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                // XXX: REMOVE AND REPLACE WITH IO MONAD
                if(arguments.size() != 1)
                    throw new Error("'println' expects exactly one argument");
                if(arguments.get(0).getType() == Type.STRING_CONSTANT)
                    System.out.println(arguments.get(0).getStringConstant().get().get());
                else
                    System.out.println(arguments.get(0).toString());
                return arguments.get(0);
            }
        }));
    }
}
