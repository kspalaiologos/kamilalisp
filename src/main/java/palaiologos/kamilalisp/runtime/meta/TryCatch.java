package palaiologos.kamilalisp.runtime.meta;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.RaiseError;

import java.util.List;

public class TryCatch extends PrimitiveFunction implements SpecialForm {

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        Atom tryBlock = args.get(0);
        Atom catchBlock = args.get(1);
        return Evaluation.safeEvaluate(env, tryBlock, (str, t) -> {
            Environment catchEnv = new Environment(env);
            catchEnv.set("error", new Atom(str));
            catchEnv.set("error-msg", new Atom(t.getMessage()));
            if (t instanceof RaiseError) {
                catchEnv.set("error-id", new Atom(((RaiseError) t).id));
            } else {
                catchEnv.set("error-id", new Atom("generic-error", true));
            }
            return Evaluation.evaluate(catchEnv, catchBlock);
        });
    }

    @Override
    protected String name() {
        return "try-catch";
    }
}
