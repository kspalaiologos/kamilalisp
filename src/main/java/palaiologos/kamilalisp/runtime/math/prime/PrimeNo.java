package palaiologos.kamilalisp.runtime.math.prime;

import palaiologos.kamilalisp.atom.*;

import java.math.BigInteger;
import java.util.List;

public class PrimeNo extends PrimitiveFunction implements Lambda {
    private static BigInteger pitabScaled = BigInteger.valueOf(10000 * PiTab.ptab.length);
    public static Atom primeNo(Atom a) {
        if (a.getType() == Type.LIST) {
            return new Atom(a.getList().stream().map(PrimeNo::primeNo).toList());
        } else if (a.getType() == Type.INTEGER) {
            if (a.getInteger().compareTo(pitabScaled) < 0) {
                // We have the approximate starting value now!
                BigInteger no = a.getInteger().divide(BigInteger.valueOf(10000));
                BigInteger last = BigInteger.valueOf(PiTab.ptab[no.intValue()]);
                no = no.multiply(BigInteger.valueOf(10000));
                while (no.compareTo(a.getInteger()) < 0) {
                    last = last.nextProbablePrime();
                    no = no.add(BigInteger.ONE);
                }
                return new Atom(last);
            } else {
                // Take the last number.
                BigInteger last = BigInteger.valueOf(PiTab.ptab[PiTab.ptab.length - 1]);
                BigInteger no = pitabScaled;
                while (no.compareTo(a.getInteger()) < 0) {
                    last = last.nextProbablePrime();
                    no = no.add(BigInteger.ONE);
                }
                return new Atom(last);
            }
        } else {
            throw new UnsupportedOperationException("prime:nth not defined for: " + a.getType());
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.isEmpty()) {
            throw new RuntimeException("prime:nth called with no arguments.");
        }

        if (args.size() == 1) {
            return primeNo(args.get(0));
        }

        return new Atom(args.stream().map(PrimeNo::primeNo).toList());
    }

    @Override
    protected String name() {
        return "prime:nth";
    }
}
