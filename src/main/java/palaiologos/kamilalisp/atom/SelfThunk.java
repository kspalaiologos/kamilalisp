package palaiologos.kamilalisp.atom;

import ch.obermuhlner.math.big.BigComplex;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.List;

public class SelfThunk extends AtomicThunk {
    public List<Atom> args;
    public Callable c;
    public Environment env;

    public SelfThunk(Callable c, List<Atom> args, Environment env) {
        super();
        this.args = args;
        this.c = c;
        this.env = env;
    }

    public void force() {
        if (args == null)
            return;
        Atom obj = Evaluation.evaluate(env, c, args);
        this.type = obj.getType();
        this.data = obj.data;
        args = null;
        env = null;
    }
}
