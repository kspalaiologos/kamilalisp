package palaiologos.kamilalisp.runtime;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.util.List;
import java.util.stream.Collectors;

public class Dfn extends PrimitiveFunction implements SpecialForm {
    public class DfnClass implements Lambda {
        List<Identifier> bindings;
        boolean wantsVararg;
        Atom code;
        Environment env;
        int f_line, f_col;

        public DfnClass(List<Identifier> bindings, boolean wantsVararg, Atom code, Environment env, int f_line, int f_col) {
            this.bindings = bindings;
            this.wantsVararg = wantsVararg;
            this.code = code;
            this.env = env;
            this.f_line = f_line;
            this.f_col = f_col;
        }

        @Override
        public String stringify() {
            return "(λ " + bindings.stream().map(Identifier::of).collect(Collectors.joining(" ")) + " . " + code.toString() + ")";
        }

        @Override
        public String frameString() {
            return "(λ " + bindings.stream().map(Identifier::of).collect(Collectors.joining(" ")) + " . " + code.shortString() + ")";
        }

        @Override
        public Atom apply(Environment throwaway, List<Atom> args) {
            Environment descendantEnv = new Environment(env);
            if(!wantsVararg) {
                assertArity(args, bindings.size());
                for (int i = 0; i < bindings.size(); i++)
                    descendantEnv.set(Identifier.of(bindings.get(i)), args.get(i));
            } else {
                if(args.size() < bindings.size() - 1)
                    throw new TypeError("Expected at least " + (bindings.size() - 1) + " arguments to `" + stringify() + "'.");
                for (int i = 0; i < bindings.size() - 1; i++)
                    descendantEnv.set(Identifier.of(bindings.get(i)), args.get(i));
                descendantEnv.set(Identifier.of(bindings.get(bindings.size() - 1)), new Atom(args.subList(bindings.size() - 1, args.size())));
            }
            return Evaluation.evaluate(descendantEnv, code);
        }

        @Override
        public int line() {
            return f_line;
        }

        @Override
        public int column() {
            return f_col;
        }
    };

    @Override
    protected String name() {
        return "lambda";
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        // env is the caller environment that defines the lambda function.
        // (lambda (x) (+ x x))
        // (lambda x (+ x x))
        assertArity(args, 2);

        List<Identifier> bindings;
        if(args.get(0).getType() == Type.LIST) {
            bindings = args.get(0).getList().stream().map(Atom::getIdentifier).toList();
        } else if(args.get(0).getType() == Type.IDENTIFIER) {
            bindings = List.of(args.get(0).getIdentifier());
        } else {
            throw new TypeError("Expected a list or an identifier as the first argument to `lambda'.");
        }

        for(int i = 0; i < bindings.size(); i++)
            if(Identifier.of(bindings.get(i)).startsWith("...") && i != bindings.size() - 1)
                throw new TypeError("Cannot use a name ends with `...' as a binding.");

        final boolean wantsVararg = bindings.size() > 0 && Identifier.of(bindings.get(bindings.size() - 1)).startsWith("...");

        Atom code = args.get(1);

        int line = 0, col = 0;
        if(args.get(0) instanceof CodeAtom) {
            col = (((CodeAtom) args.get(0)).getCol());
            line = (((CodeAtom) args.get(0)).getLine());
        }

        final int f_line = line, f_col = col;

        return new CodeAtom(new DfnClass(bindings, wantsVararg, code, env, f_line, f_col)).setCol(col).setLine(line);
    }
}
