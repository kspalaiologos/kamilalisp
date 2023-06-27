package palaiologos.kamilalisp.runtime.flt64;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;
import rocks.palaiologos.maja.Complex;
import rocks.palaiologos.maja.Maja;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Cmplx64Solve extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        Complex[] coeffs = args.get(0).getList().stream().map(Cmplx64AtomThunk::toComplex).toArray(Complex[]::new);
        boolean[] mask = Maja.aberth(coeffs);
        List<Atom> results = new ArrayList<>();
        for(int i = 0; i < mask.length; i++) {
            if(!mask[i]) {
                results.add(Cmplx64AtomThunk.toAtom(coeffs[i]));
            }
        }
        return new Atom(results);
    }

    @Override
    protected String name() {
        return "cmplx64:solve";
    }
}
