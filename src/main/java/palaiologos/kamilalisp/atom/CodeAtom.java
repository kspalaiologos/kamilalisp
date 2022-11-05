package palaiologos.kamilalisp.atom;

import ch.obermuhlner.math.big.BigComplex;

import java.math.BigDecimal;
import java.util.List;

public class CodeAtom extends Atom {
    public int line, col;

    public int getLine() {
        return line;
    }

    public int getCol() {
        return col;
    }

    public CodeAtom setLine(int l) {
        line = l;
        return this;
    }

    public CodeAtom setCol(int c) {
        col = c;
        return this;
    }

    public CodeAtom() {
        super();
    }

    public CodeAtom(String data) {
        super(data);
    }

    public CodeAtom(BigDecimal data) {
        super(data);
    }

    public CodeAtom(BigComplex data) {
        super(data);
    }

    public CodeAtom(List<Atom> data) {
        super(data);
    }

    public CodeAtom(Callable data) {
        super(data);
    }

    public CodeAtom(Identifier data) {
        super(data);
    }
}
