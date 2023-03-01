package palaiologos.kamilalisp.runtime.meta;

import com.google.common.collect.Lists;
import palaiologos.kamilalisp.atom.*;

import java.util.List;

public class Over implements SpecialForm, ReactiveFunction {
    private final Atom form;

    private final int l;
    private final int c;

    public Over(Atom form, int line, int col) {
        this.form = form;
        this.l = line;
        this.c = col;
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
        Callable lambda = Evaluation.evaluate(env, form).getCallable();
        return new Atom(new Lambda() {
            @Override
            public String stringify() {
                return Over.this.stringify();
            }

            @Override
            public String frameString() {
                return Over.this.frameString();
            }

            @Override
            public Atom apply(Environment env, List<Atom> args) {
                return Evaluation.evaluate(env, lambda, Lists.reverse(args));
            }

            @Override
            public int line() {
                return Over.this.line();
            }

            @Override
            public int column() {
                return Over.this.column();
            }
        });
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
