package kamilalisp.libs;

import kamilalisp.data.*;

import java.util.List;
import java.util.stream.Collectors;

public class IOLib {
    public static void install(Environment env) {
        env.push("println", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                // XXX: REMOVE AND REPLACE WITH IO MONAD
                String msg = arguments.stream().map(x -> x.toString()).collect(Collectors.joining(" "));
                System.out.println(msg);
                return new Atom(new StringConstant(msg));
            }
        }));
    }
}
