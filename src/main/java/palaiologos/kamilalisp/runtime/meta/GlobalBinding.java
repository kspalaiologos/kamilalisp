package palaiologos.kamilalisp.runtime.meta;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.repl.Main;

import javax.naming.Binding;
import java.util.List;

public class GlobalBinding extends PrimitiveFunction implements SpecialForm {
    @Override
    protected String name() {
        return "def";
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (!env.isToplevel()) {
            throw new RuntimeException("def called outside of toplevel scope.");
        }

        assertArity(args, 2);

        Atom name = args.get(0);
        Atom value = Evaluation.evaluate(env, args.get(1));
        BindingHelper.bindingPatternMatch(env, name, value, true);
        return value;
    }
}
