package palaiologos.kamilalisp.runtime.math;

import ch.obermuhlner.math.big.BigComplex;
import ch.obermuhlner.math.big.BigDecimalMath;
import com.google.common.collect.Streams;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.math.BigDecimal;
import java.math.MathContext;
import java.util.Arrays;
import java.util.List;

public class IFFT extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        List<Atom> data = args.get(0).getList();
        BigDecimal[] real = args.get(0).getList().stream().map(x -> x.getComplex().re).toArray(BigDecimal[]::new);
        BigDecimal[] imag = args.get(0).getList().stream().map(x -> x.getComplex().im).toArray(BigDecimal[]::new);
        FFT.inverseTransform(env.getMathContext(), real, imag);
        List<Atom> result = Streams.zip(Arrays.stream(real), Arrays.stream(imag), (re, im) -> new Atom(BigComplex.valueOf(re, im))).toList();
        return new Atom(result);
    }

    @Override
    protected String name() {
        return "ifft";
    }
}
