package palaiologos.kamilalisp.runtime.math.numeric;

import ch.obermuhlner.math.big.BigComplex;
import ch.obermuhlner.math.big.BigDecimalMath;
import org.apache.commons.lang3.tuple.Pair;
import org.checkerframework.checker.units.qual.A;
import palaiologos.kamilalisp.atom.*;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.math.MathContext;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.IntStream;

public class NQuad extends PrimitiveFunction implements SpecialForm {
    public static Atom quad(Environment e, Atom begin, Atom end, Atom expr, Atom variable) {
        MathContext mc = new MathContext(e.getMathContext().getPrecision() * 10);
        final int m = 7;

        if(begin.getInteger().compareTo(BigInteger.valueOf(-1)) != 0)
            throw new RuntimeException("begin must be -1");
        if(end.getInteger().compareTo(BigInteger.valueOf(1)) != 0)
            throw new RuntimeException("end must be 1");

        BigComplex sum = BigComplex.ZERO;

        Environment sumEnv = new Environment(e);
        Atom sumAtom = new Atom();

        String v = Identifier.of(variable.getIdentifier()).substring(1);

        sumEnv.set(v, sumAtom);

        List<BigDecimal> xk = new ArrayList<>();
        List<BigComplex> wk = new ArrayList<>();

        BigDecimal h;

        final BigDecimal half = new BigDecimal("0.5");

        {
            BigDecimal tol = half.pow(mc.getPrecision() + 10);
            BigDecimal pi4 = BigDecimalMath.pi(mc).divide(BigDecimal.valueOf(4), mc);

            h = half.pow(m - 1, mc);

            BigDecimal expt0 = BigDecimalMath.exp(half.pow(m), mc);
            BigDecimal a = pi4.multiply(expt0);
            BigDecimal b = pi4.divide(expt0, mc);
            BigDecimal udelta = BigDecimalMath.exp(h, mc);
            BigDecimal urdelta = BigDecimal.ONE.divide(udelta, mc);

            for(int k = 0; k < 3 * Math.pow(2, m); k++) {
                BigDecimal c = BigDecimalMath.exp(a.subtract(b), mc);
                BigDecimal d = BigDecimal.ONE.divide(c, mc);
                BigDecimal co = c.add(d).multiply(half, mc);
                BigDecimal si = c.subtract(d).multiply(half, mc);
                BigDecimal x = si.divide(co, mc);
                BigDecimal w = a.add(b).divide(co.multiply(co), mc);
                BigDecimal diff = x.subtract(BigDecimal.ONE).abs();
                if(diff.compareTo(tol) <= 0)
                    break;
                xk.add(x);
                wk.add(BigComplex.valueOf(w));
                a = a.multiply(udelta, mc);
                b = b.multiply(urdelta, mc);
            }
        }

        for(int i = 0; i < xk.size(); i++) {
            BigComplex result = BigComplex.ZERO;

            sumAtom.hack(Type.REAL, xk.get(i));
            result = result.add(wk.get(i).multiply(Evaluation.evaluate(sumEnv, expr).getComplex()));

            sumAtom.hack(Type.REAL, xk.get(i).negate());
            result = result.add(wk.get(i).multiply(Evaluation.evaluate(sumEnv, expr).getComplex()));

            sum = sum.add(result.multiply(h));
        }

        return new Atom(sum);
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        return quad(env, Evaluation.evaluate(env, args.get(0)), Evaluation.evaluate(env, args.get(1)), args.get(2), args.get(3));
    }

    @Override
    protected String name() {
        return "n-quad";
    }
}
