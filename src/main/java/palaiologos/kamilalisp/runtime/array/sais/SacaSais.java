package palaiologos.kamilalisp.runtime.array.sais;

import palaiologos.kamilalisp.atom.*;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class SacaSais extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        if (args.get(0).getType() == Type.LIST) {
            List<BigInteger> list = args.get(0).getList().stream().map(Atom::getInteger).toList();
            boolean b = true;
            for (BigInteger bigInteger : list) {
                if (bigInteger.compareTo(BigInteger.valueOf(Byte.MIN_VALUE)) < 0 || bigInteger.compareTo(BigInteger.valueOf(Byte.MAX_VALUE)) >= 0) {
                    b = false;
                    break;
                }
            }
            if (b) {
                byte[] data = new byte[list.size()];
                for (int i = 0; i < list.size(); i++)
                    data[i] = list.get(i).byteValueExact();
                int[] sa = new int[data.length];
                SAIS.suffixsort(data, sa, data.length);
                ArrayList<Atom> result = new ArrayList<>();
                for (int x : sa) {
                    Atom atom = new Atom(BigInteger.valueOf(x));
                    result.add(atom);
                }
                return new Atom(result);
            } else {
                boolean result = true;
                for (BigInteger bigInteger : list) {
                    if (bigInteger.compareTo(BigInteger.valueOf(Short.MIN_VALUE)) < 0 || bigInteger.compareTo(BigInteger.valueOf(Short.MAX_VALUE)) >= 0) {
                        result = false;
                        break;
                    }
                }
                if (result) {
                    short[] data = new short[list.size()];
                    short max = 0;
                    for (int i = 0; i < list.size(); i++) {
                        data[i] = list.get(i).shortValueExact();
                        if (data[i] > max)
                            max = data[i];
                    }
                    int[] sa = new int[data.length];
                    SAIS.suffixsort(data, sa, data.length, max);
                    ArrayList<Atom> list1 = new ArrayList<>();
                    for (int x : sa) {
                        Atom atom = new Atom(BigInteger.valueOf(x));
                        list1.add(atom);
                    }
                    return new Atom(list1);
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
                    ArrayList<Atom> list1 = new ArrayList<>();
                    for (int x : sa) {
                        Atom atom = new Atom(BigInteger.valueOf(x));
                        list1.add(atom);
                    }
                    return new Atom(list1);
                }
            }
        } else if (args.get(0).getType() == Type.STRING) {
            String str = args.get(0).getString();
            int[] sa = new int[str.length()];
            SAIS.suffixsort(str, sa, str.length());
            ArrayList<Atom> list = new ArrayList<>();
            for (int x : sa) {
                Atom atom = new Atom(BigInteger.valueOf(x));
                list.add(atom);
            }
            return new Atom(list);
        }

        throw new RuntimeException("Invalid argument type");
    }

    @Override
    protected String name() {
        return "saca:sais";
    }
}
