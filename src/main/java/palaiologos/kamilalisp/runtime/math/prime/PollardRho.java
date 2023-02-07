package palaiologos.kamilalisp.runtime.math.prime;

import java.math.BigInteger;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.List;

class PollardRho {
    private static final BigInteger ZERO = new BigInteger("0");
    private static final BigInteger ONE = new BigInteger("1");
    private static final BigInteger TWO = new BigInteger("2");
    private static final SecureRandom random = new SecureRandom();
    private List<BigInteger> factors = new ArrayList<>();

    private static BigInteger rho(BigInteger N) {
        BigInteger divisor;
        BigInteger c = new BigInteger(N.bitLength(), random);
        BigInteger x = new BigInteger(N.bitLength(), random);
        BigInteger xx = x;

        if (N.mod(TWO).compareTo(ZERO) == 0) return TWO;

        do {
            x = x.multiply(x).mod(N).add(c).mod(N);
            xx = xx.multiply(xx).mod(N).add(c).mod(N);
            xx = xx.multiply(xx).mod(N).add(c).mod(N);
            divisor = x.subtract(xx).gcd(N);
        } while ((divisor.compareTo(ONE)) == 0);

        return divisor;
    }

    public void factor(BigInteger N) {
        if (N.compareTo(ONE) == 0) return;
        if (N.isProbablePrime(100)) {
            factors.add(N);
            return;
        }
        BigInteger divisor = rho(N);
        factor(divisor);
        factor(N.divide(divisor));
    }

    public List<BigInteger> getFactors() {
        return factors;
    }

    public void reset() {
        factors = new ArrayList<>();
    }
}
