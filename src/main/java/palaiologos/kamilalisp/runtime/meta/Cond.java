package palaiologos.kamilalisp.runtime.meta;

import palaiologos.kamilalisp.atom.*;

import java.util.List;

public class Cond extends PrimitiveFunction implements SpecialForm {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        for (Atom a : args) {
            a.assertTypes(Type.LIST);
            if (a.getList().size() == 2) {
                if (Evaluation.evaluate(env, a.getList().get(0)).coerceBool())
                    return Evaluation.evaluate(env, a.getList().get(1));
            } else if (a.getList().size() == 1) {
                return Evaluation.evaluate(env, a.getList().get(0));
            } else {

                throw new RuntimeException("Invalid cond clause");
            }
        }
        throw new RuntimeException("Unexhaustive cond clause.");
    }

    @Override
    protected String name() {
        return "cond";
    }
}
