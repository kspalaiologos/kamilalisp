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

        if(args.get(0).getType() == Type.STRING) {
            String str = args.get(0).getString();
            int len = str.length();
            int[] freq = new int[256];
            for (int i = 0; i < len; i++) {
                freq[str.charAt(i)]++;
            }
            double entropy = 0.0;
            for (int i = 0; i < 256; i++) {
                double p = ((double) freq[i]) / len;
                if (p > 0)
                    entropy -= p * (Math.log(p) / Math.log(2));
            }
            return new Atom(BigDecimal.valueOf(entropy));
        } else {
            int[] data = args.get(0).getList().stream().mapToInt(x -> x.getInteger().intValueExact()).toArray();
            int len = data.length;

            int min = Integer.MAX_VALUE;
            for (int i = 0; i < len; i++) {
                if (data[i] < min)
                    min = data[i];
            }

            if(min < 0) {
                for (int i = 0; i < len; i++) {
                    data[i] += Math.abs(min);
                }
            }

            int max = 0;
            for (int i = 0; i < len; i++) {
                if (data[i] > max)
                    max = data[i];
            }

            int[] freq = new int[max + 1];
            for (int i = 0; i < len; i++) {
                freq[data[i]]++;
            }

            double entropy = 0.0;
            for (int i = 0; i < max + 1; i++) {
                double p = ((double) freq[i]) / len;
                if (p > 0)
                    entropy -= p * (Math.log(p) / Math.log(2));
            }

            return new Atom(BigDecimal.valueOf(entropy));
        }
    }
}
