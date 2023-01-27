package palaiologos.kamilalisp.runtime.meta;

import palaiologos.kamilalisp.atom.*;

import java.util.List;

public class Let extends PrimitiveFunction implements SpecialForm {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        args.get(0).assertTypes(Type.LIST);
        Environment newEnv = new Environment(env);
        for (Atom a : args.get(0).getList()) {
            a.assertTypes(Type.LIST);
            a.getList().get(0).assertTypes(Type.IDENTIFIER);
            newEnv.set(Identifier.of(a.getList().get(0).getIdentifier()), Evaluation.evaluate(newEnv, a.getList().get(1)));
        }
        return Evaluation.evaluate(newEnv, args.get(1));
    }

    @Override
    protected String name() {
        return "let";
    }
}
