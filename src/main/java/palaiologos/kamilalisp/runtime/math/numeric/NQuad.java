package palaiologos.kamilalisp.runtime.math.numeric;

import ch.obermuhlner.math.big.BigComplex;
import ch.obermuhlner.math.big.BigDecimalMath;
import com.google.common.math.BigIntegerMath;
import org.apache.commons.lang3.tuple.Pair;
import org.apache.commons.lang3.tuple.Triple;
import org.checkerframework.checker.units.qual.A;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.runtime.meta.ConcurrentLRUCache;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.math.MathContext;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;
import java.util.stream.IntStream;

public class NQuad extends PrimitiveFunction implements SpecialForm {
    private static ConcurrentLRUCache<Integer, Triple<BigDecimal, List<BigDecimal>, List<BigComplex>>> coefficientCache = new ConcurrentLRUCache<>(10);

    public static Atom quad(Environment e, Atom begin, Atom end, Atom expr, Atom variable) {
        final int m = (int) (5 + Math.log(e.getMathContext().getPrecision() / 30.0) / Math.log(2));
        MathContext mc = new MathContext(e.getMathContext().getPrecision() * m);

        BigComplex sum = BigComplex.ZERO;

        Environment sumEnv = new Environment(e);
        Atom sumAtom = new Atom();

        String v = Identifier.of(variable.getIdentifier()).substring(1);

        sumEnv.set(v, sumAtom);

        List<BigDecimal> xk;
        List<BigComplex> wk;
        BigDecimal h;

        if(coefficientCache.get(m) != null) {
            Triple<BigDecimal, List<BigDecimal>, List<BigComplex>> t = coefficientCache.get(m);
            h = t.getLeft();
            xk = t.getMiddle();
            wk = t.getRight();
        } else {
            xk = new ArrayList<>();
            wk = new ArrayList<>();

            final BigDecimal half = new BigDecimal("0.5");

            BigDecimal tol = half.pow(mc.getPrecision());
            BigDecimal pi4 = BigDecimalMath.pi(mc).divide(BigDecimal.valueOf(4), mc);

            h = half.pow(m - 1, mc);

            BigDecimal expt0 = BigDecimalMath.exp(half.pow(m), mc);
            BigDecimal a = pi4.multiply(expt0);
            BigDecimal b = pi4.divide(expt0, mc);
            BigDecimal udelta = BigDecimalMath.exp(h, mc);
            BigDecimal urdelta = BigDecimal.ONE.divide(udelta, mc);

            for (int k = 0; k < 3 * Math.pow(2, m); k++) {
                BigDecimal c = BigDecimalMath.exp(a.subtract(b), mc);
                BigDecimal d = BigDecimal.ONE.divide(c, mc);
                BigDecimal co = c.add(d).multiply(half, mc);
                BigDecimal si = c.subtract(d).multiply(half, mc);
                BigDecimal x = si.divide(co, mc);
                BigDecimal w = a.add(b).divide(co.multiply(co), mc);
                BigDecimal diff = x.subtract(BigDecimal.ONE).abs();
                if (diff.compareTo(tol) <= 0)
                    break;
                xk.add(x);
                wk.add(BigComplex.valueOf(w));
                a = a.multiply(udelta, mc);
                b = b.multiply(urdelta, mc);
            }

            coefficientCache.put(m, Triple.of(h, xk, wk));
        }

        if(begin.isNumeric() && end.isNumeric() && begin.getReal().equals(end.getReal()))
            return new Atom(BigDecimal.ZERO);

        if(begin.isNumeric() && end.isNumeric() && (begin.getInteger().compareTo(BigInteger.valueOf(-1)) != 0 || end.getInteger().compareTo(BigInteger.valueOf(1)) != 0)) {
            // (a+b+y(b-a))/2=x
            // r*(dx/dy)=r*(b-a)/2

            BigDecimal apb = begin.getReal().add(end.getReal(), mc).divide(BigDecimal.valueOf(2), mc);
            BigDecimal bma = end.getReal().subtract(begin.getReal(), mc).divide(BigDecimal.valueOf(2), mc);

            for(int i = 0; i < xk.size(); i++) {
                BigComplex result = BigComplex.ZERO;

                sumAtom.hack(Type.REAL, xk.get(i).multiply(bma).add(apb));
                result = result.add(wk.get(i).multiply(Evaluation.evaluate(sumEnv, expr).getComplex()));

                sumAtom.hack(Type.REAL, xk.get(i).multiply(bma).negate().add(apb));
                result = result.add(wk.get(i).multiply(Evaluation.evaluate(sumEnv, expr).getComplex()));

                sum = sum.add(result.multiply(h), e.getMathContext());
            }

            return new Atom(sum.multiply(bma, e.getMathContext()));
        } else if(begin.getType() == Type.INTEGER && end.getType() == Type.INTEGER && begin.getInteger().equals(BigInteger.valueOf(-1)) && end.getInteger().equals(BigInteger.valueOf(1))) {
            for (int i = 0; i < xk.size(); i++) {
                BigComplex result = BigComplex.ZERO;

                sumAtom.hack(Type.REAL, xk.get(i));
                result = result.add(wk.get(i).multiply(Evaluation.evaluate(sumEnv, expr).getComplex()));

                sumAtom.hack(Type.REAL, xk.get(i).negate());
                result = result.add(wk.get(i).multiply(Evaluation.evaluate(sumEnv, expr).getComplex()));

                sum = sum.add(result.multiply(h), e.getMathContext());
            }

            return new Atom(sum);
        }

        throw new RuntimeException("Invalid arguments to n-quad.");
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
