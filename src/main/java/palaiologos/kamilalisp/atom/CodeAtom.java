package palaiologos.kamilalisp.atom;

import ch.obermuhlner.math.big.BigComplex;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.List;

public class CodeAtom extends Atom {
    private int line;
    private int col;

    public CodeAtom() {
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

    public CodeAtom(BigInteger data) {
        super(data);
    }

    public int getLine() {
        return line;
    }

    public CodeAtom setLine(int l) {
        line = l;
        return this;
    }

    public int getCol() {
        return col;
    }

    public CodeAtom setCol(int c) {
        col = c;
        return this;
    }

}
