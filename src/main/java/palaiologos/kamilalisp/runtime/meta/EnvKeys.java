package palaiologos.kamilalisp.runtime.meta;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

public class EnvKeys extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (!args.isEmpty()) {
            throw new RuntimeException("Expected no arguments to `meta:env-keys'.");
        }

        return new Atom(env.recursiveKeys().stream().map(Atom::new).collect(Collectors.toList()));
    }

    @Override
    protected String name() {
        return "meta:env-keys";
    }
}
