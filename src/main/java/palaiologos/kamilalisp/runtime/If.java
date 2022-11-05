package palaiologos.kamilalisp.runtime;

import palaiologos.kamilalisp.atom.*;

import java.util.List;

public class If extends PrimitiveFunction implements SpecialForm {
    @Override
    protected String name() {
        return "if";
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 3);

        Atom condition = Evaluation.evaluate(env, args.get(0));
        Atom ifTrue = args.get(1);
        Atom ifFalse = args.get(2);

        if(condition.coerceBool())
            return Evaluation.evaluate(env, ifTrue);
        else
            return Evaluation.evaluate(env, ifFalse);
    }
}
