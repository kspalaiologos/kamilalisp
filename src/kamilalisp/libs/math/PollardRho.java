package kamilalisp.libs.math;

import kamilalisp.data.*;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.security.SecureRandom;
import java.util.*;
import java.util.stream.Collectors;

public class PollardRho {
    private final static BigInteger ZERO = new BigInteger("0");
    private final static BigInteger ONE  = new BigInteger("1");
    private final static BigInteger TWO  = new BigInteger("2");
    private final static SecureRandom random = new SecureRandom();

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
        } while((divisor.compareTo(ONE)) == 0);

        return divisor;
    }

    private List<BigInteger> factors = new ArrayList<>();

    public void factor(BigInteger N) {
        if (N.compareTo(ONE) == 0) return;
        if (N.isProbablePrime(50)) { factors.add(N); return; }
        BigInteger divisor = rho(N);
        factor(divisor);
        factor(N.divide(divisor));
    }

    public List<BigInteger> getFactors() {
        return factors;
    }

    public static void install(Environment env) {
        env.push("p-factors", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'p-factors'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("First argument to 'p-factors'", Type.NUMBER);
                    PollardRho p = new PollardRho();
                    if(arguments.get(0).getNumber().get().compareTo(BigDecimal.ZERO) == 0)
                        throw new Error("'p-factors' - can't factor 0.");
                    p.factor(arguments.get(0).getNumber().get().toBigInteger());
                    return p.getFactors().stream().map(x -> new Atom(new BigDecimal(x))).collect(Collectors.toList());
                }));
            }
        }));

        env.push("p-ufactors", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'p-ufactors'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("First argument to 'p-ufactors'", Type.NUMBER);
                    PollardRho p = new PollardRho();
                    if(arguments.get(0).getNumber().get().compareTo(BigDecimal.ZERO) == 0)
                        throw new Error("'p-ufactors' - can't factor 0.");
                    p.factor(arguments.get(0).getNumber().get().toBigInteger());
                    List<Atom> factors = p.getFactors().stream().map(x -> new Atom(new BigDecimal(x))).collect(Collectors.toList());
                    HashMap<Atom, Long> map = new HashMap<>();
                    for(Atom a : factors) {
                        if(map.containsKey(a.getNumber().get()))
                            map.put(a, map.get(a) + 1);
                        else
                            map.put(a, 1L);
                    }
                    return map.entrySet().stream().map(x -> new Atom(List.of(x.getKey(), new Atom(new BigDecimal(x.getValue()))))).collect(Collectors.toList());
                }));
            }
        }));

        env.push("divisors", new Atom(new Closure() {
            private void genDivisors(int curIndex, BigInteger curDivisor, LinkedHashMap<Atom, Long> map, List<Atom> factors) {
                if(curIndex == map.size()) {
                    factors.add(new Atom(new BigDecimal(curDivisor)));
                    return;
                }
                for(int i = 0; i <= map.get(map.keySet().toArray()[curIndex]); i++) {
                    genDivisors(curIndex + 1, curDivisor, map, factors);
                    curDivisor = curDivisor.multiply(((Atom) map.keySet().toArray()[curIndex]).getNumber().get().toBigInteger());
                }
            }

            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("Invalid invocation to 'divisors'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("First argument to 'divisors'", Type.NUMBER);
                    PollardRho p = new PollardRho();
                    if(arguments.get(0).getNumber().get().compareTo(BigDecimal.ZERO) == 0)
                        throw new Error("'divisors' - can't factor 0.");
                    p.factor(arguments.get(0).getNumber().get().toBigInteger());
                    List<Atom> factors = p.getFactors().stream().map(x -> new Atom(new BigDecimal(x))).collect(Collectors.toList());
                    LinkedHashMap<Atom, Long> map = new LinkedHashMap<>();
                    for(Atom a : factors) {
                        if(map.containsKey(a.getNumber().get()))
                            map.put(a, map.get(a) + 1);
                        else
                            map.put(a, 1L);
                    }
                    List<Atom> f = new LinkedList<>();
                    genDivisors(0, BigInteger.ONE, map, f);
                    if(!f.contains(arguments.get(0)))
                        f.add(arguments.get(0));
                    return f;
                }));
            }
        }));
    }
}
