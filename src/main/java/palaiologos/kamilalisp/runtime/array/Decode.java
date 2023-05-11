package palaiologos.kamilalisp.runtime.array;

import ch.obermuhlner.math.big.BigComplex;
import com.google.common.collect.Lists;
import com.google.common.collect.Streams;
import palaiologos.kamilalisp.atom.*;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

public class Decode extends PrimitiveFunction implements Lambda {
    private static boolean all(List<Atom> l, Type t) {
        for (Atom a : l)
            if (a.getType() != t)
                return false;
        return true;
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        Atom left = args.get(0);
        Atom right = args.get(1);
        if (left.isNumeric() && right.isNumeric()) {
            return right;
        } else {
            List<Atom> leftList = left.getType() == Type.LIST ? left.getList() : List.of(left);
            List<Atom> rightList = right.getType() == Type.LIST ? right.getList() : List.of(right);
            int max = Math.max(leftList.size(), rightList.size());
            leftList = new Cycle.CycleListFacade(leftList, max);
            rightList = new Cycle.CycleListFacade(rightList, max);
            if (leftList.isEmpty() || rightList.isEmpty()) {
                return Atom.FALSE;
            } else if (leftList.size() == 1 && rightList.size() == 1) {
                return rightList.get(0);
            } else {
                if (all(leftList, Type.INTEGER)) {
                    List<BigInteger> results = new ArrayList<>();
                    results.add(BigInteger.ONE);
                    for (int i = 1; i < leftList.size(); i++) {
                        if (results.isEmpty())
                            results.add(leftList.get(i).getInteger());
                        else
                            results.add(results.get(i - 1).multiply(leftList.get(i).getInteger()));
                    }
                    results = Lists.reverse(results);
                    if (all(rightList, Type.INTEGER)) {
                        int len = Math.min(results.size(), rightList.size());
                        BigInteger result = BigInteger.ZERO;
                        for (int i = 0; i < len; i++) {
                            result = result.add(results.get(i).multiply(rightList.get(i).getInteger()));
                        }
                        return new Atom(result);
                    } else if (all(rightList, Type.REAL)) {
                        int len = Math.min(results.size(), rightList.size());
                        BigDecimal result = BigDecimal.ZERO;
                        for (int i = 0; i < len; i++) {
                            result = result.add(new BigDecimal(results.get(i)).multiply(rightList.get(i).getReal()));
                        }
                        return new Atom(result);
                    } else if (all(rightList, Type.COMPLEX)) {
                        int len = Math.min(results.size(), rightList.size());
                        BigComplex result = BigComplex.ZERO;
                        for (int i = 0; i < len; i++) {
                            result = result.add(rightList.get(i).getComplex().multiply(new BigDecimal(results.get(i))));
                        }
                        return new Atom(result);
                    } else {
                        throw new UnsupportedOperationException("decode expects rank 1 numeric vectors.");
                    }
                } else if (all(leftList, Type.REAL)) {
                    List<BigDecimal> results = new ArrayList<>();
                    results.add(BigDecimal.ONE);
                    for (int i = 1; i < leftList.size(); i++) {
                        if (results.isEmpty())
                            results.add(leftList.get(i).getReal());
                        else
                            results.add(results.get(i - 1).multiply(leftList.get(i).getReal()));
                    }
                    results = Lists.reverse(results);
                    if (all(rightList, Type.INTEGER)) {
                        int len = Math.min(results.size(), rightList.size());
                        BigDecimal result = BigDecimal.ZERO;
                        for (int i = 0; i < len; i++) {
                            result = result.add(results.get(i).multiply(new BigDecimal(rightList.get(i).getInteger())));
                        }
                        return new Atom(result);
                    } else if (all(rightList, Type.REAL)) {
                        int len = Math.min(results.size(), rightList.size());
                        BigDecimal result = BigDecimal.ZERO;
                        for (int i = 0; i < len; i++) {
                            result = result.add(results.get(i).multiply(rightList.get(i).getReal()));
                        }
                        return new Atom(result);
                    } else if (all(rightList, Type.COMPLEX)) {
                        int len = Math.min(results.size(), rightList.size());
                        BigComplex result = BigComplex.ZERO;
                        for (int i = 0; i < len; i++) {
                            result = result.add(rightList.get(i).getComplex().multiply(results.get(i)));
                        }
                        return new Atom(result);
                    } else {
                        throw new UnsupportedOperationException("decode expects rank 1 numeric vectors.");
                    }
                } else if (all(leftList, Type.COMPLEX)) {
                    List<BigComplex> results = new ArrayList<>();
                    results.add(BigComplex.ONE);
                    for (int i = 1; i < leftList.size(); i++) {
                        if (results.isEmpty())
                            results.add(leftList.get(i).getComplex());
                        else
                            results.add(results.get(i - 1).multiply(leftList.get(i).getComplex(), env.getMathContext()));
                    }
                    results = Lists.reverse(results);
                    int len = Math.min(results.size(), rightList.size());
                    BigComplex result = BigComplex.ZERO;
                    for (int i = 0; i < len; i++) {
                        result = result.add(rightList.get(i).getComplex().multiply(results.get(i)));
                    }
                    return new Atom(result);
                } else {
                    throw new UnsupportedOperationException("decode expects rank 1 numeric vectors.");
                }
            }
        }
    }

    @Override
    protected String name() {
        return "decode";
    }
}
