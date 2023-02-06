package palaiologos.kamilalisp.runtime;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.ReactiveFunction;
import palaiologos.kamilalisp.atom.SpecialForm;

import java.math.BigDecimal;
import java.util.List;

public class Dot implements ReactiveFunction, SpecialForm {
    private Object index;
    private Atom obj;
    private int line, col;

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
        return null;
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
