package palaiologos.kamilalisp.runtime.meta;

import palaiologos.kamilalisp.atom.*;

import java.util.List;

public class TryCatch extends PrimitiveFunction implements SpecialForm {

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        Atom tryBlock = args.get(0);
        Atom catchBlock = args.get(1);
        return Evaluation.safeEvaluate(env, tryBlock, str -> {
            Environment catchEnv = new Environment(env);
            catchEnv.set("error", new Atom(str));
            return Evaluation.evaluate(catchEnv, catchBlock);
        });
    }

    @Override
    protected String name() {
        return "try-catch";
    }
}
