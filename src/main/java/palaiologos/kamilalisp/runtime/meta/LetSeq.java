package palaiologos.kamilalisp.runtime.meta;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.runtime.Dfn;

import java.util.List;

public class LetSeq extends PrimitiveFunction implements SpecialForm {

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        List<Atom> bindings = args.get(0).getList();
        Atom lastValue = Atom.NULL;
        for (Atom arg : bindings) {
            if (arg.getType() == Type.LIST && !arg.getList().isEmpty()) {
                if (arg.getList().get(0).getType() == Type.IDENTIFIER) {
                    switch (Identifier.of(arg.getList().get(0).getIdentifier())) {
                        case "defun" -> {
                            List<Atom> declaration = arg.getList();
                            if (declaration.get(1).getType() != Type.IDENTIFIER) {
                                throw new RuntimeException("Expected identifier in `def' declaration in `let-seq'.");
                            }
                            String name = Identifier.of(declaration.get(1).getIdentifier());
                            Atom lambdaArgs = declaration.get(2);
                            Atom lambdaValue = declaration.get(3);
                            Atom lambda = Evaluation.evaluate(env, new Dfn(), List.of(lambdaArgs, lambdaValue));
                            env.set(name, lambda);
                            continue;
                        }
                        case "def" -> {
                            List<Atom> declaration = arg.getList();
                            if (declaration.get(1).getType() != Type.IDENTIFIER) {
                                throw new RuntimeException("Expected identifier in `def' declaration in `let-seq'.");
                            }
                            String name = Identifier.of(declaration.get(1).getIdentifier());
                            Atom value = Evaluation.evaluate(env, declaration.get(2));
                            env.set(name, value);
                            continue;
                        }
                        case "discard" -> {
                            // Discard and ignore.
                            Evaluation.evaluate(env, arg);
                            continue;
                        }
                    }
                }
            }

            lastValue = Evaluation.evaluate(env, arg);
        }

        return lastValue;
    }

    @Override
    protected String name() {
        return "let-seq";
    }
}
