package palaiologos.kamilalisp.runtime.meta;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.util.List;

public class Dfn extends PrimitiveFunction implements SpecialForm {
    public static final Dfn INSTANCE = new Dfn();

    @Override
    protected String name() {
        return "λ";
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        // env is the caller environment that defines the lambda function.
        // (lambda (x) (+ x x))
        // (lambda x (+ x x))
        if (args.size() < 2)
            throw new TypeError("Expected at least two arguments to `lambda'.");

        List<String> bindings;
        if (args.get(0).getType() == Type.LIST) {
            bindings = args.get(0).getList().stream().map(Atom::getIdentifier).toList();
        } else if (args.get(0).getType() == Type.IDENTIFIER) {
            bindings = List.of(args.get(0).getIdentifier());
        } else {
            throw new TypeError("Expected a list or an identifier as the first argument to `lambda'.");
        }

        for (int i = 0; i < bindings.size(); i++)
            if ((bindings.get(i)).startsWith("...") && i != bindings.size() - 1)
                throw new TypeError("Cannot use a name ends with `...' as a binding.");

        boolean wantsVararg = !bindings.isEmpty() && (bindings.get(bindings.size() - 1)).startsWith("...");

        List<Atom> code = args.subList(1, args.size());

        int line = 0, col = 0;
        if (args.get(0) instanceof CodeAtom) {
            col = (((CodeAtom) args.get(0)).getCol());
            line = (((CodeAtom) args.get(0)).getLine());
        }

        int f_line = line, f_col = col;

        return new CodeAtom(new DfnClass(bindings, wantsVararg, code, env, f_line, f_col)).setCol(col).setLine(line);
    }

    public class DfnClass implements Lambda {
        List<String> bindings;
        boolean wantsVararg;
        List<Atom> code;
        Environment env;
        int f_line, f_col;

        DfnClass(List<String> bindings, boolean wantsVararg, List<Atom> code, Environment env, int f_line, int f_col) {
            this.bindings = bindings;
            this.wantsVararg = wantsVararg;
            this.code = code;
            this.env = env;
            this.f_line = f_line;
            this.f_col = f_col;
        }

        @Override
        public String stringify() {
            if (code.size() == 1)
                return "(λ " + String.join(" ", bindings) + " . " + code.get(0).toString() + ")";
            else
                return "(λ " + String.join(" ", bindings) + " . " + code.get(0).toString() + "...)";
        }

        @Override
        public String frameString() {
            if (code.size() == 1)
                return "(λ " + String.join(" ", bindings) + " . " + code.get(0).shortString() + ")";
            else
                return "(λ " + String.join(" ", bindings) + " . " + code.get(0).shortString() + "...)";
        }

        @Override
        public Atom apply(Environment throwaway, List<Atom> args) {
            Environment descendantEnv = new Environment(env);
            StackFrame.pushLambda(this);
            try {
                while (true) {
                    if (!wantsVararg) {
                        assertArity(args, bindings.size());
                        for (int i = 0; i < bindings.size(); i++)
                            descendantEnv.set(bindings.get(i), args.get(i));
                    } else {
                        if (args.size() < bindings.size() - 1)
                            throw new TypeError("Expected at least " + (bindings.size() - 1) + " arguments to `" + frameString() + "'.");
                        for (int i = 0; i < bindings.size() - 1; i++)
                            descendantEnv.set(bindings.get(i), args.get(i));
                        descendantEnv.set(bindings.get(bindings.size() - 1), new Atom(args.subList(bindings.size() - 1, args.size())));
                    }
                    for (int i = 0; i < code.size() - 1; i++)
                        Evaluation.evaluate(descendantEnv, code.get(i));
                    Atom a = Evaluation.evaluate(descendantEnv, code.get(code.size() - 1));
                    if (a instanceof SelfThunk selfThunk) {
                        if (selfThunk.c == this) {
                            args = selfThunk.args;
                        } else {
                            return a;
                        }
                    } else {
                        return a;
                    }
                }
            } finally {
                StackFrame.popLambda();
            }
        }

        @Override
        public int line() {
            return f_line;
        }

        @Override
        public int column() {
            return f_col;
        }
    }
}
