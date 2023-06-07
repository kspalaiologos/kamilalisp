package palaiologos.kamilalisp.runtime.math.prime;

import java.math.BigInteger;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

class PollardRho {
    private static final SecureRandom random = new SecureRandom();
    private HashMap<BigInteger, BigInteger> factors = new HashMap<>();

    private static BigInteger rho(BigInteger N) {
        BigInteger divisor;
        BigInteger c = new BigInteger(N.bitLength(), random);
        BigInteger x = new BigInteger(N.bitLength(), random);
        BigInteger xx = x;

        if (N.mod(BigInteger.TWO).compareTo(BigInteger.ZERO) == 0) return BigInteger.TWO;

        do {
            x = x.multiply(x).mod(N).add(c).mod(N);
            xx = xx.multiply(xx).mod(N).add(c).mod(N);
            xx = xx.multiply(xx).mod(N).add(c).mod(N);
            divisor = x.subtract(xx).gcd(N);
        } while ((divisor.compareTo(BigInteger.ONE)) == 0);

        return divisor;
    }

    public void factor(BigInteger N) {
        if (N.compareTo(BigInteger.ONE) == 0) return;
        if (N.isProbablePrime(100)) {
            factors.put(N, factors.getOrDefault(N, BigInteger.ZERO).add(BigInteger.ONE));
            return;
        }
        BigInteger divisor = rho(N);
        factor(divisor);
        factor(N.divide(divisor));
    }

    public HashMap<BigInteger, BigInteger> getFactors() {
        return factors;
    }

    public void reset() {
        factors = new HashMap<>();
    }
}
