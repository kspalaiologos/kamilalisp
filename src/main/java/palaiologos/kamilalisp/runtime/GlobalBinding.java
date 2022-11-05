package palaiologos.kamilalisp.runtime;

import palaiologos.kamilalisp.atom.*;

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

        Identifier name = args.get(0).getIdentifier();
        Atom value = Evaluation.evaluate(env, args.get(1));
        env.set(Identifier.of(name), value);
        return value;
    }
}
