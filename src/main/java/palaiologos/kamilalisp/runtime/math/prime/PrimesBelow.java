package palaiologos.kamilalisp.runtime.math.prime;

import palaiologos.kamilalisp.atom.*;

import java.math.BigInteger;
import java.util.*;

public class PrimesBelow extends PrimitiveFunction implements Lambda {
    private static final BigInteger pts = BigInteger.valueOf(37811);
    private static final BigInteger longMax = BigInteger.valueOf(Integer.MAX_VALUE);

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        args.get(0).assertTypes(Type.INTEGER);
        BigInteger n = args.get(0).getInteger();
        if (n.compareTo(BigInteger.TWO) < 0)
            throw new ArithmeticException("prime:below not defined for integers less than 0.");
        if (n.compareTo(pts) <= 0) {
            // Return a subset of pts. Binsearch to find the end.
            int iN = n.intValue();
            int index = 0;
            int low = 0;
            int high = PiTab.pi.length - 1;
            while (low <= high) {
                int mid = (low + high) / 2;
                if (PiTab.pi[mid] < iN) {
                    index = mid + 1;
                    low = mid + 1;
                } else if (PiTab.pi[mid] > iN) {
                    high = mid - 1;
                } else {
                    index = mid;
                    break;
                }
            }
            ArrayList<Atom> primes = new ArrayList<>();
            for (int i = 0; i < index; i++) {
                primes.add(new Atom(BigInteger.valueOf(PiTab.pi[i])));
            }
            return new Atom(primes);
        } else if(n.compareTo(longMax) < 0) {
            // Optimization: we can make the sieve pi.length elements smaller.
            Pair<int[], Integer> atkin = atkin(n.intValue());
            int[] arr = atkin.fst();
            int count = atkin.snd();
            return new Atom(new AbstractList<Atom>() {
                @Override
                public Atom get(int index) {
                    return new Atom(BigInteger.valueOf(arr[index]));
                }

                @Override
                public int size() {
                    return count;
                }
            });
        } else {
            throw new ArithmeticException("prime:below not yet defined for integers greater than Long.MAX_VALUE.");
        }
    }

    private static Pair<int[], Integer> atkin(int limit) {
        int[] primes = new int[(int) (limit * 1.1 / Math.log(limit))];
        int count = 0;

        primes[count++] = 2;
        primes[count++] = 3;

        boolean sieve[] = new boolean[limit+1];

        Arrays.fill(sieve, false);

        for (int x = 1; x * x <= limit; x++) {
            for (int y = 1; y * y <= limit; y++) {
                int n = (4 * x * x) + (y * y);
                if (n <= limit && (n % 12 == 1 || n % 12 == 5))
                    sieve[n] ^= true;
                n = (3 * x * x) + (y * y);
                if (n <= limit && n % 12 == 7)
                    sieve[n] ^= true;
                n = (3 * x * x) - (y * y);
                if (x > y && n <= limit
                        && n % 12 == 11)
                    sieve[n] ^= true;
            }
        }

        for (int r = 5; r * r <= limit; r++) {
            if (sieve[r]) {
                for (int i = r * r; i <= limit; i += r * r)
                    sieve[i] = false;
            }
        }

        // Print primes using sieve[]
        for (int a = 5; a <= limit; a++)
            if (sieve[a])
                primes[count++] = a;

        return new Pair<>(primes, count);
    }


    @Override
    protected String name() {
        return "prime:below";
    }
}
