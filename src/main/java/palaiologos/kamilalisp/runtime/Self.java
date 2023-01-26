package palaiologos.kamilalisp.runtime;

import palaiologos.kamilalisp.atom.*;

import java.util.List;

import static palaiologos.kamilalisp.atom.StackFrame.isDeBruijnAllowed;

public class Self extends PrimitiveFunction implements Lambda {
    private final int l;
    private final int c;
    private final int index;

    @Override
    public int line() {
        return l;
    }

    @Override
    public int column() {
        return c;
    }

    record SelfThunk(int index, List<Atom> args) implements ReactiveFunction, SpecialForm {
        @Override
        public String stringify() {
            return "&" + index + "/f-syn";
        }

        @Override
        public String frameString() {
            return "&" + index + "/f-syn";
        }

        @Override
        public Atom apply(Environment env, List<Atom> _args) {
            Lambda l = StackFrame.lambdaDeBruijn(index);
            return Evaluation.evaluate(env, l, args);
        }

        @Override
        public int line() {
            return 0;
        }

        @Override
        public int column() {
            return 0;
        }
    }

    public Self(int index, int l, int c) {
        this.index = index;
        this.l = l;
        this.c = c;
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(isDeBruijnAllowed(index))
            return new Atom(new SelfThunk(index, args));
        else
            throw new RuntimeException("&" + index + " is not allowed here");
    }

    @Override
    protected String name() {
        return "&" + index + "/syn";
    }
}
