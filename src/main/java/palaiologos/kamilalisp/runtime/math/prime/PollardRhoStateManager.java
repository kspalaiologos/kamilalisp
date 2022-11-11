package palaiologos.kamilalisp.runtime.math.prime;

import java.math.BigInteger;
import java.util.List;

public class PollardRhoStateManager {
    private static final ThreadLocal<PollardRho> pollardRho = new ThreadLocal<>();

    public static List<BigInteger> factor(BigInteger i) {
        if (pollardRho.get() == null) {
            pollardRho.set(new PollardRho());
        }

        PollardRho instance = pollardRho.get();
        instance.factor(i);
        List<BigInteger> factors = instance.getFactors();
        instance.reset();
        return factors;
    }
}
