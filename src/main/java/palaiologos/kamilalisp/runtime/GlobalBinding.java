package palaiologos.kamilalisp.runtime;

import palaiologos.kamilalisp.atom.*;

import java.util.Arrays;
import java.util.List;

public class GlobalBinding extends PrimitiveFunction implements SpecialForm {
    @Override
    protected String name() {
        return "def";
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(!env.isToplevel()) {
            throw new RuntimeException("def called outside of toplevel scope.");
        }

        assertArity(args, 2);

        if(FunctionRegistry.BUILTIN_BINDINGS.contains(Identifier.of(args.get(0).getIdentifier()))) {
            throw new RuntimeException("def can not shadow or redefine built-in bindings.");
        }

        Identifier name = args.get(0).getIdentifier();
        Atom value = Evaluation.evaluate(env, args.get(1));
        env.set(Identifier.of(name), value);
        return value;
    }
}