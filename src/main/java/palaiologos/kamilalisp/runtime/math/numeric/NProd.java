package palaiologos.kamilalisp.runtime.math.numeric;

import ch.obermuhlner.math.big.BigComplex;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.List;

public class NProd extends PrimitiveFunction implements SpecialForm {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 3);
        List<Atom> start = args.get(0).getList();

        Identifier variable = start.get(1).getIdentifier();
        BigInteger startValue, endValue;
        startValue = Evaluation.evaluate(env, start.get(2)).getInteger();
        endValue = Evaluation.evaluate(env, args.get(1)).getInteger();

        Atom expr = args.get(2);

        BigComplex sumC = BigComplex.ZERO;
        BigDecimal sumR = BigDecimal.ZERO;
        BigInteger sumZ = BigInteger.ZERO;

        Environment sumEnv = new Environment(env);
        Atom sumAtom = new Atom();

        for (BigInteger i = startValue; i.compareTo(endValue) <= 0; i = i.add(BigInteger.ONE)) {
            sumAtom.hack(Type.INTEGER, i);
            sumEnv.set(Identifier.of(variable), sumAtom);
            Atom n = Evaluation.evaluate(sumEnv, expr);
            if (n.getType() == Type.INTEGER)
                sumZ = sumZ.multiply(n.getInteger());
            else if (n.getType() == Type.REAL)
                sumR = sumR.multiply(n.getReal());
            else if (n.getType() == Type.COMPLEX)
                sumC = sumC.multiply(n.getComplex());
            else
                throw new TypeError("Expected a number as the result of the expression in `nprod'.");
        }

        return new Atom(sumC.multiply(BigComplex.valueOf(sumR)).multiply(BigComplex.valueOf(new BigDecimal(sumZ))));
    }

    @Override
    protected String name() {
        return "n-prod";
    }
}
