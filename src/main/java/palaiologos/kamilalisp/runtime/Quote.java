package palaiologos.kamilalisp.runtime;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.ReactiveFunction;
import palaiologos.kamilalisp.atom.SpecialForm;

import java.util.List;

public class Quote implements SpecialForm, ReactiveFunction {
    private final Atom form;
    private final int l;
    private final int c;

    public Quote(Atom form, int l, int c) {
        this.form = form;
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
    public Atom apply(Environment env, List<Atom> args) {
        return form;
    }

    @Override
    public String stringify() {
        return "'" + form.toString();
    }

    @Override
    public String frameString() {
        return "'/syn";
    }
}
