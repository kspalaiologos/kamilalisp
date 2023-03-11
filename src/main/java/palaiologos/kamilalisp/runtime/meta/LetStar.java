package palaiologos.kamilalisp.runtime.meta;

import palaiologos.kamilalisp.atom.*;

import java.util.List;

public class LetStar extends PrimitiveFunction implements SpecialForm {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        args.get(0).assertTypes(Type.LIST);
        Environment newEnv = new Environment(env);
        Atom name = args.get(0).getList().get(0);
        Atom value = Evaluation.evaluate(newEnv, args.get(0).getList().get(1));
        BindingHelper.bindingPatternMatch(newEnv, name, value, false);
        return Evaluation.evaluate(newEnv, args.get(1));
    }

    @Override
    protected String name() {
        return "let*";
    }
}
