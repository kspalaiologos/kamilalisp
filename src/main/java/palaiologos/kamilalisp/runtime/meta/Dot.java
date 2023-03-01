package palaiologos.kamilalisp.runtime.meta;

import palaiologos.kamilalisp.atom.*;

import java.math.BigDecimal;
import java.util.List;

public class Dot implements ReactiveFunction, SpecialForm {
    private final Object index;
    private final Atom obj;
    private final int line;
    private final int col;

    public Dot(Atom obj, BigDecimal index, int line, int col) {
        this.index = index;
        this.obj = obj;
        this.line = line;
        this.col = col;
    }

    public Dot(Atom obj, String index, int line, int col) {
        this.index = index;
        this.obj = obj;
        this.line = line;
        this.col = col;
    }

    @Override
    public String stringify() {
        return obj + "." + index;
    }

    @Override
    public String frameString() {
        return "." + index;
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        Atom objEv = Evaluation.evaluate(env, obj);
        return objEv.dot(index);
    }

    @Override
    public int line() {
        return line;
    }

    @Override
    public int column() {
        return col;
    }
}
