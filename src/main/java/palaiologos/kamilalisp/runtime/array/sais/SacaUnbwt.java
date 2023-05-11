package palaiologos.kamilalisp.runtime.array.sais;

import palaiologos.kamilalisp.atom.*;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

public class SacaUnbwt extends PrimitiveFunction implements Lambda {
    private static void unbwt(byte[] T, byte[] U, int n, int pidx) {
        int[] C = new int[256];
        int[] LF = new int[n];
        int i, t;
        for (i = 0; i < 256; ++i) {
            C[i] = 0;
        }
        for (i = 0; i < n; ++i) {
            LF[i] = C[T[i] & 0xff]++;
        }
        for (i = 0, t = 0; i < 256; ++i) {
            t += C[i];
            C[i] = t - C[i];
        }
        for (i = n - 1, t = 0; 0 <= i; --i) {
            t = LF[t] + C[(U[i] = T[t]) & 0xff];
            t += (t < pidx) ? 1 : 0;
        }
        C = null;
    }

    private static void unbwt(char[] T, char[] U, int n, int pidx) {
        int[] C = new int[65536];
        int[] LF = new int[n];
        int i, t;
        for (i = 0; i < 65536; ++i) {
            C[i] = 0;
        }
        for (i = 0; i < n; ++i) {
            LF[i] = C[T[i] & 0xffff]++;
        }
        for (i = 0, t = 0; i < 65536; ++i) {
            t += C[i];
            C[i] = t - C[i];
        }
        for (i = n - 1, t = 0; 0 <= i; --i) {
            t = LF[t] + C[(U[i] = T[t]) & 0xffff];
            t += (t < pidx) ? 1 : 0;
        }
        C = null;
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        int idx = args.get(0).getInteger().intValueExact();
        if (args.get(1).getType() == Type.LIST) {
            ArrayList<BigInteger> list = new ArrayList<>();
            for (Atom atom : args.get(1).getList()) {
                BigInteger integer = atom.getInteger();
                list.add(integer);
            }
            boolean b1 = true;
            for (BigInteger x : list) {
                if (x.compareTo(BigInteger.valueOf(Byte.MIN_VALUE)) < 0 || x.compareTo(BigInteger.valueOf(Byte.MAX_VALUE)) >= 0) {
                    b1 = false;
                    break;
                }
            }
            if (b1) {
                byte[] T = new byte[list.size()];
                byte[] U = new byte[list.size()];
                for (int i = 0; i < list.size(); i++) {
                    T[i] = list.get(i).byteValueExact();
                }
                unbwt(T, U, list.size(), idx);
                List<Atom> result = new ArrayList<>();
                for (byte b : U) {
                    result.add(new Atom(BigInteger.valueOf(b)));
                }
                return new Atom(result);
            } else {
                char[] T = new char[list.size()];
                char[] U = new char[list.size()];
                for (int i = 0; i < list.size(); i++) {
                    T[i] = (char) list.get(i).intValueExact();
                }
                unbwt(T, U, list.size(), idx);
                List<Atom> result = new ArrayList<>();
                for (char c : U) {
                    result.add(new Atom(BigInteger.valueOf(c)));
                }
                return new Atom(result);
            }
        } else if (args.get(1).getType() == Type.STRING) {
            String str = args.get(1).getString();
            char[] U = new char[str.length()];
            unbwt(str.toCharArray(), U, str.length(), idx);
            return new Atom(new String(U));
        }

        throw new RuntimeException("Invalid argument type");
    }

    @Override
    protected String name() {
        return "saca:bwt";
    }
}
