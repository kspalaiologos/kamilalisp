package palaiologos.kamilalisp.runtime.array.sais;

import palaiologos.kamilalisp.atom.*;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

public class SacaBwt extends PrimitiveFunction implements Lambda {
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
                byte[] result = new byte[data.length];
                int idx = SAIS.bwtransform(data, result, sa, data.length);
                List<Atom> rl = new ArrayList<>();
                for (int i = 0; i < result.length; i++) {
                    rl.add(new Atom(BigInteger.valueOf(result[i])));
                }
                return new Atom(List.of(new Atom(rl), new Atom(BigInteger.valueOf(idx))));
            } else {
                char[] data = new char[list.size()];
                for (int i = 0; i < list.size(); i++) {
                    data[i] = (char) list.get(i).intValueExact();
                }
                int[] sa = new int[data.length];
                char[] result = new char[data.length];
                int idx = SAIS.bwtransform(data, result, sa, data.length);
                List<Atom> rl = new ArrayList<>();
                for (char c : result) {
                    rl.add(new Atom(BigInteger.valueOf(c)));
                }
                return new Atom(List.of(new Atom(rl), new Atom(BigInteger.valueOf(idx))));
            }
        } else if (args.get(0).getType() == Type.STRING) {
            String str = args.get(0).getString();
            int[] sa = new int[str.length()];
            char[] result = new char[str.length()];
            int idx = SAIS.bwtransform(str.toCharArray(), result, sa, result.length);
            return new Atom(List.of(new Atom(String.valueOf(result)), new Atom(BigInteger.valueOf(idx))));
        }

        throw new RuntimeException("Invalid argument type");
    }

    @Override
    protected String name() {
        return "saca:bwt";
    }
}
