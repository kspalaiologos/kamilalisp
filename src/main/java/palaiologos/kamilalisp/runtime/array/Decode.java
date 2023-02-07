package palaiologos.kamilalisp.runtime.array;

import ch.obermuhlner.math.big.BigComplex;
import com.google.common.collect.Lists;
import com.google.common.collect.Streams;
import palaiologos.kamilalisp.atom.*;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

import static palaiologos.kamilalisp.atom.Type.LIST;

public class Decode extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        Atom left = args.get(0);
        Atom right = args.get(1);
        if (left.isNumeric() && right.isNumeric()) {
            return right;
        } else {
            List<Atom> leftList = left.getType() == LIST ? left.getList() : List.of(left);
            List<Atom> rightList = right.getType() == LIST ? right.getList() : List.of(right);
            int max = Math.max(leftList.size(), rightList.size());
            leftList = new Cycle.CycleListFacade(leftList, max);
            rightList = new Cycle.CycleListFacade(rightList, max);
            if (leftList.isEmpty() || rightList.isEmpty()) {
                return Atom.FALSE;
            } else if (leftList.size() == 1 && rightList.size() == 1) {
                return rightList.get(0);
            } else {
                if (leftList.stream().allMatch(x -> x.getType() == Type.INTEGER)) {
                    List<BigInteger> results = new ArrayList<>();
                    results.add(BigInteger.ONE);
                    for (int i = 1; i < leftList.size(); i++) {
                        if (results.isEmpty())
                            results.add(leftList.get(i).getInteger());
                        else
                            results.add(results.get(i - 1).multiply(leftList.get(i).getInteger()));
                    }
                    results = Lists.reverse(results);
                    if (rightList.stream().allMatch(x -> x.getType() == Type.INTEGER)) {
                        return new Atom(Streams.zip(results.stream(), rightList.stream(), (x, y) -> x.multiply(y.getInteger())).reduce(BigInteger.ZERO, BigInteger::add));
                    } else if (rightList.stream().allMatch(x -> x.getType() == Type.REAL)) {
                        return new Atom(Streams.zip(results.stream(), rightList.stream(), (x, y) -> y.getReal().multiply(new BigDecimal(x))).reduce(BigDecimal.ZERO, BigDecimal::add));
                    } else if (rightList.stream().allMatch(x -> x.getType() == Type.COMPLEX)) {
                        return new Atom(Streams.zip(results.stream(), rightList.stream(), (x, y) -> y.getComplex().multiply(BigComplex.valueOf(new BigDecimal(x)))).reduce(BigComplex.ZERO, BigComplex::add));
                    } else {
                        throw new UnsupportedOperationException("decode expects rank 1 numeric vectors.");
                    }
                } else if (leftList.stream().allMatch(x -> x.getType() == Type.REAL)) {
                    List<BigDecimal> results = new ArrayList<>();
                    results.add(BigDecimal.ONE);
                    for (int i = 1; i < leftList.size(); i++) {
                        if (results.isEmpty())
                            results.add(leftList.get(i).getReal());
                        else
                            results.add(results.get(i - 1).multiply(leftList.get(i).getReal()));
                    }
                    results = Lists.reverse(results);
                    if (rightList.stream().allMatch(x -> x.getType() == Type.INTEGER)) {
                        return new Atom(Streams.zip(results.stream(), rightList.stream(), (x, y) -> x.multiply(new BigDecimal(y.getInteger()))).reduce(BigDecimal.ZERO, BigDecimal::add));
                    } else if (rightList.stream().allMatch(x -> x.getType() == Type.REAL)) {
                        return new Atom(Streams.zip(results.stream(), rightList.stream(), (x, y) -> x.multiply(y.getReal())).reduce(BigDecimal.ZERO, BigDecimal::add));
                    } else if (rightList.stream().allMatch(x -> x.getType() == Type.COMPLEX)) {
                        return new Atom(Streams.zip(results.stream(), rightList.stream(), (x, y) -> y.getComplex().multiply(BigComplex.valueOf(x))).reduce(BigComplex.ZERO, BigComplex::add));
                    } else {
                        throw new UnsupportedOperationException("decode expects rank 1 numeric vectors.");
                    }
                } else if (leftList.stream().allMatch(x -> x.getType() == Type.COMPLEX)) {
                    List<BigComplex> results = new ArrayList<>();
                    results.add(BigComplex.ONE);
                    for (int i = 1; i < leftList.size(); i++) {
                        if (results.isEmpty())
                            results.add(leftList.get(i).getComplex());
                        else
                            results.add(results.get(i - 1).multiply(leftList.get(i).getComplex(), env.getMathContext()));
                    }
                    results = Lists.reverse(results);
                    return new Atom(Streams.zip(results.stream(), rightList.stream(), (x, y) -> y.getComplex().multiply(x, env.getMathContext())).reduce(BigComplex.ZERO, BigComplex::add));
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
