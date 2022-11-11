package palaiologos.kamilalisp.runtime;

import com.google.common.collect.Lists;
import palaiologos.kamilalisp.atom.*;

import java.util.List;

public class Over implements Lambda {
    private final Atom form;

    private final int l;
    private final int c;

    @Override
    public int line() {
        return l;
    }

    @Override
    public int column() {
        return c;
    }

    public Over(Atom form, int line, int col) {
        this.form = form;
        this.l = line;
        this.c = col;
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        Callable lambda = Evaluation.evaluate(env, form).getCallable();
        return Evaluation.evaluate(env, lambda, Lists.reverse(args));
    }

    @Override
    public String stringify() {
        return "^" + form.toString();
    }

    @Override
    public String frameString() {
        return "^/syn";
    }
}
