package palaiologos.kamilalisp.runtime.math.prime;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

class PollardRhoStateManager {
    private static final ThreadLocal<PollardRho> pollardRho = new ThreadLocal<>();

    public static List<BigInteger> factorList(BigInteger i) {
        if (pollardRho.get() == null) {
            pollardRho.set(new PollardRho());
        }

        PollardRho instance = pollardRho.get();
        instance.factor(i);
        HashMap<BigInteger, BigInteger> factors = instance.getFactors();
        List<BigInteger> factorList = new ArrayList<>();
        for (BigInteger factor : factors.keySet()) {
            for (int j = 0; j < factors.get(factor).intValueExact(); j++) {
                factorList.add(factor);
            }
        }
        instance.reset();
        return factorList;
    }

    public static HashMap<BigInteger, BigInteger> factorMap(BigInteger i) {
        if (pollardRho.get() == null) {
            pollardRho.set(new PollardRho());
        }

        PollardRho instance = pollardRho.get();
        instance.factor(i);
        HashMap<BigInteger, BigInteger> factors = instance.getFactors();
        instance.reset();
        return factors;
    }
}
