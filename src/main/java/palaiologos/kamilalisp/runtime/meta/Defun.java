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
        if(args.size() < 3) {
            throw new RuntimeException("Expected at least 3 arguments in `defun'.");
        }
        Atom lambda = Evaluation.evaluate(env, Dfn.INSTANCE, args.subList(1, args.size()));
        return Evaluation.evaluate(env, globalBinding, List.of(args.get(0), lambda));
    }
}
