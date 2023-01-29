package palaiologos.kamilalisp.runtime;

import palaiologos.kamilalisp.atom.*;

import java.util.List;
import java.util.stream.Collectors;

public class Compose implements SpecialForm, ReactiveFunction {
    private final List<Atom> atoms;
    private final int l;
    private final int c;

    public Compose(List<Atom> atoms, int l, int c) {
        this.atoms = atoms;
        this.l = l;
        this.c = c;
    }

    @Override
    public int line() {
        return l;
    }

    @Override
    public int column() {
        return c;
    }

    @Override
    public String stringify() {
        return atoms.stream().map(Atom::toString).collect(Collectors.joining("@"));
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        // Evaluate all atoms, then run the last function on args, and pass the return type to the previous function, and so on.
        List<Atom> evaluatedAtoms = atoms.stream().map(x -> Evaluation.evaluate(env, x)).toList();
        return new Atom(new Lambda() {
            @Override
            public String stringify() {
                return Compose.this.stringify();
            }

            @Override
            public String frameString() {
                return Compose.this.frameString();
            }

            @Override
            public Atom apply(Environment env, List<Atom> args) {
                Atom result = Evaluation.evaluate(env, evaluatedAtoms.get(evaluatedAtoms.size() - 1).getCallable(), args);
                for (int i = evaluatedAtoms.size() - 2; i >= 0; i--)
                    result = Evaluation.evaluate(env, evaluatedAtoms.get(i).getCallable(), List.of(result));
                return result;
            }

            @Override
            public int line() {
                return Compose.this.line();
            }

            @Override
            public int column() {
                return Compose.this.column();
            }
        });
    }

    @Override
    public String frameString() {
        return "@/syn";
    }
}
