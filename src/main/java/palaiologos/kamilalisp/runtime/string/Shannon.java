package palaiologos.kamilalisp.runtime.string;

import palaiologos.kamilalisp.atom.*;

import java.math.BigDecimal;
import java.util.List;

public class Shannon extends PrimitiveFunction implements Lambda {
    @Override
    protected String name() {
        return "shannon-entropy";
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() != 1)
            throw new RuntimeException("shannon-entropy expects one argument.");

        args.get(0).assertTypes(Type.STRING);

        String str = args.get(0).getString();
        int len = str.length();
        double[] freq = new double[256];
        for (int i = 0; i < len; i++) {
            freq[str.charAt(i)]++;
        }
        double entropy = 0.0;
        for (int i = 0; i < 256; i++) {
            double p = freq[i] / len;
            if (p > 0)
                entropy -= p * (Math.log(p) / Math.log(2));
        }
        return new Atom(BigDecimal.valueOf(entropy));
    }
}
