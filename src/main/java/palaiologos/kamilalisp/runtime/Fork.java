package palaiologos.kamilalisp.runtime;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Evaluation;
import palaiologos.kamilalisp.atom.Lambda;

import java.util.List;
import java.util.stream.Collectors;

public class Fork implements Lambda {
    // Need to evaluate these.
    private Atom reductor;
    private List<Atom> reductees;

    private int l, c;

    @Override
    public int line() {
        return l;
    }

    @Override
    public int column() {
        return c;
    }

    public Fork(Atom reductor, List<Atom> reductees, int l, int c) {
        this.reductor = reductor;
        this.reductees = reductees;
        this.l = l; this.c = c;
    }

    @Override
    public String stringify() {
        return "[" + reductor.toString() + " " + reductees.stream().map(Atom::toString).collect(Collectors.joining(" ")) + "]";
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        return Evaluation.evaluate(env, reductor).getCallable()
                .apply(env, reductees.isEmpty() ? args :
                        reductees.stream().map(x -> Evaluation.evaluate(env, x).getCallable()
                                .apply(env, args)).collect(Collectors.toList()));
    }

    @Override
    public String frameString() {
        return "[]/syn";
    }
}
