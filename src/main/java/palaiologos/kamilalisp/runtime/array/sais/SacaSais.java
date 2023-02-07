package palaiologos.kamilalisp.runtime.array.sais;

import palaiologos.kamilalisp.atom.*;

import java.math.BigInteger;
import java.util.Arrays;
import java.util.List;

public class SacaSais extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        if (args.get(0).getType() == Type.LIST) {
            List<BigInteger> list = args.get(0).getList().stream().map(Atom::getInteger).toList();
            if (list.stream().allMatch(x -> x.compareTo(BigInteger.valueOf(Byte.MIN_VALUE)) >= 0 && x.compareTo(BigInteger.valueOf(Byte.MAX_VALUE)) < 0)) {
                byte[] data = new byte[list.size()];
                for (int i = 0; i < list.size(); i++)
                    data[i] = list.get(i).byteValueExact();
                int[] sa = new int[data.length];
                SAIS.suffixsort(data, sa, data.length);
                return new Atom(Arrays.stream(sa).mapToObj(x -> new Atom(BigInteger.valueOf(x))).toList());
            } else if (list.stream().allMatch(x -> x.compareTo(BigInteger.valueOf(Short.MIN_VALUE)) >= 0 && x.compareTo(BigInteger.valueOf(Short.MAX_VALUE)) < 0)) {
                short[] data = new short[list.size()];
                short max = 0;
                for (int i = 0; i < list.size(); i++) {
                    data[i] = list.get(i).shortValueExact();
                    if (data[i] > max)
                        max = data[i];
                }
                int[] sa = new int[data.length];
                SAIS.suffixsort(data, sa, data.length, max);
                return new Atom(Arrays.stream(sa).mapToObj(x -> new Atom(BigInteger.valueOf(x))).toList());
            } else {
                int[] data = new int[list.size()];
                int max = 0;
                for (int i = 0; i < list.size(); i++) {
                    data[i] = list.get(i).intValueExact();
                    if (data[i] > max)
                        max = data[i];
                }
                int[] sa = new int[data.length];
                SAIS.suffixsort(data, sa, data.length, max);
                return new Atom(Arrays.stream(sa).mapToObj(x -> new Atom(BigInteger.valueOf(x))).toList());
            }
        } else if (args.get(0).getType() == Type.STRING) {
            String str = args.get(0).getString();
            int[] sa = new int[str.length()];
            SAIS.suffixsort(str, sa, str.length());
            return new Atom(Arrays.stream(sa).mapToObj(x -> new Atom(BigInteger.valueOf(x))).toList());
        }

        throw new RuntimeException("Invalid argument type");
    }

    @Override
    protected String name() {
        return "saca:sais";
    }
}
