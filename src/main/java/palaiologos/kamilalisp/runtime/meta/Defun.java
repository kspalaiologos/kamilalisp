package palaiologos.kamilalisp.runtime.meta;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.runtime.Dfn;
import palaiologos.kamilalisp.runtime.GlobalBinding;

import java.util.List;

public class Defun extends PrimitiveFunction implements SpecialForm {
    private final Dfn dfn = new Dfn();
    private final GlobalBinding globalBinding = new GlobalBinding();

    @Override
    protected String name() {
        return "defun";
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 3);
        Atom lambda = Evaluation.evaluate(env, dfn, List.of(args.get(1), args.get(2)));
        return Evaluation.evaluate(env, globalBinding, List.of(args.get(0), lambda));
    }
}
