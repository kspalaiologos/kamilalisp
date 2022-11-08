package palaiologos.kamilalisp.runtime;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Evaluation;
import palaiologos.kamilalisp.atom.Lambda;

import java.util.List;
import java.util.stream.Collectors;

public class Compose implements Lambda {
    private List<Atom> atoms;
    private int l, c;

    @Override
    public int line() {
        return l;
    }

    @Override
    public int column() {
        return c;
    }

    public Compose(List<Atom> atoms, int l, int c) {
        this.atoms = atoms; this.l = l; this.c = c;
    }

    @Override
    public String stringify() {
        return atoms.stream().map(Atom::toString).collect(Collectors.joining("@"));
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        // Evaluate all atoms, then run the last function on args, and pass the return type to the previous function, and so on.
        List<Atom> evaluatedAtoms = atoms.stream().map(x -> Evaluation.evaluate(env, x)).toList();
        Atom result = Evaluation.evaluate(env, evaluatedAtoms.get(evaluatedAtoms.size() - 1).getCallable(), args);
        for(int i = evaluatedAtoms.size() - 2; i >= 0; i--)
            result = Evaluation.evaluate(env, evaluatedAtoms.get(i).getCallable(), List.of(result));
        return result;
    }

    @Override
    public String frameString() {
        return "@/syn";
    }
}
