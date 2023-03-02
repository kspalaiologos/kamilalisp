package palaiologos.kamilalisp.runtime.meta;

import ch.obermuhlner.math.big.BigComplex;
import palaiologos.kamilalisp.atom.*;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.List;

import static palaiologos.kamilalisp.atom.StackFrame.isDeBruijnAllowed;
import static palaiologos.kamilalisp.atom.StackFrame.lambdaDeBruijn;

public class Self extends PrimitiveFunction implements Lambda {
    private final int l;
    private final int c;
    private final int index;

    public Self(int index, int l, int c) {
        this.index = index;
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
        if (isDeBruijnAllowed(index))
            return new SelfThunk(lambdaDeBruijn(index), args, env);
        else
            throw new RuntimeException("&" + index + " is not allowed here");
    }

    @Override
    protected String name() {
        return "&" + index + "/syn";
    }
}
