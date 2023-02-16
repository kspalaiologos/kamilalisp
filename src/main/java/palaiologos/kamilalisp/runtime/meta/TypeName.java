package palaiologos.kamilalisp.runtime.meta;

import palaiologos.kamilalisp.atom.*;

import java.util.List;

public class TypeName extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        return new Atom(args.stream().map(x -> switch(x.getType()) {
            case INTEGER -> "integer";
            case REAL -> "float";
            case COMPLEX -> "complex";
            case STRING -> "string";
            case IDENTIFIER -> "atom";
            case LIST -> "list";
            case CALLABLE -> "callable";
            case USERDATA -> x.getUserdata().typeName();
        }).map(Atom::new).toList());
    }

    @Override
    protected String name() {
        return "meta:type-name";
    }
}
