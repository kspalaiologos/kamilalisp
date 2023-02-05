package palaiologos.kamilalisp.runtime.meta;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.runtime.Dfn;

import java.util.List;

public class Defun extends PrimitiveFunction implements SpecialForm {
    private final GlobalBinding globalBinding = new GlobalBinding();

    @Override
    protected String name() {
        return "defun";
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 3);
        Atom lambda = Evaluation.evaluate(env, Dfn.INSTANCE, List.of(args.get(1), args.get(2)));
        return Evaluation.evaluate(env, globalBinding, List.of(args.get(0), lambda));
    }
}
