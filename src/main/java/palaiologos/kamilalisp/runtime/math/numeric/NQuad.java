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

        BigDecimal pitwo = BigDecimalMath.pi(mc).divide(BigDecimal.valueOf(2), mc);

        if(begin.getInteger().compareTo(BigInteger.valueOf(-1)) != 0)
            throw new RuntimeException("begin must be -1");
        if(end.getInteger().compareTo(BigInteger.valueOf(1)) != 0)
            throw new RuntimeException("end must be 1");

        BigComplex sum = BigComplex.ZERO;

        Environment sumEnv = new Environment(e);
        Atom sumAtom = new Atom();

        String v = Identifier.of(variable.getIdentifier()).substring(1);

        BigDecimal h = new BigDecimal("0.5").pow(m - 1, mc);

        sumEnv.set(v, sumAtom);

        List<BigDecimal> xk = new ArrayList<>();
        List<BigComplex> wk = new ArrayList<>();

        IntStream.range(0, (int) (3 * Math.pow(2, m))).mapToObj(BigDecimal::valueOf).parallel().map(i -> {
            BigDecimal x = i.multiply(h, mc);
            BigDecimal sinhCoeff = pitwo.multiply(BigDecimalMath.sinh(x, mc));
            BigDecimal cxk = BigDecimalMath.tanh(sinhCoeff, mc);
            BigDecimal cwk = pitwo.multiply(BigDecimalMath.cosh(x, mc))
                    .divide(BigDecimalMath.cosh(sinhCoeff, mc).pow(2), mc);
            return Pair.of(cxk, BigComplex.valueOf(cwk));
        }).toList().forEach(p -> {
            xk.add(p.getLeft());
            wk.add(p.getRight());
        });

        for(int i = 0; i < 3 * Math.pow(2, m); i++) {
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
