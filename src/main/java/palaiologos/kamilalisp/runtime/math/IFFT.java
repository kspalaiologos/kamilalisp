package palaiologos.kamilalisp.runtime.math;

import ch.obermuhlner.math.big.BigComplex;
import com.google.common.collect.Streams;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class IFFT extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        List<Atom> data = args.get(0).getList();
        BigDecimal[] real = new BigDecimal[data.size()];
        BigDecimal[] imag = new BigDecimal[data.size()];
        for (int i = 0; i < data.size(); i++) {
            BigComplex complex = data.get(i).getComplex();
            real[i] = complex.re;
            imag[i] = complex.im;
        }
        FFT.inverseTransform(env.getMathContext(), real, imag);
        ArrayList<Atom> result = new ArrayList<>(data.size());
        for (int i = 0; i < data.size(); i++)
            result.add(new Atom(BigComplex.valueOf(real[i], imag[i])));
        return new Atom(result);
    }

    @Override
    protected String name() {
        return "ifft";
    }
}
