package palaiologos.kamilalisp.runtime.math.num;

import ch.obermuhlner.math.big.BigComplex;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.runtime.array.Rank;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.math.MathContext;
import java.util.List;

public class Det extends PrimitiveFunction implements Lambda {
    public static Atom det(MathContext mc, List<List<Atom>> l1) {
        if (l1.stream().anyMatch(x -> x.size() != l1.get(0).size())) {
            throw new RuntimeException("Expected a square matrix.");
        }

        if (l1.stream().allMatch(x -> x.stream().allMatch(y -> y.getType() == Type.INTEGER || y.getType() == Type.REAL))) {
            if (l1.size() == 0) {
                throw new RuntimeException("Empty matrix.");
            } else if (l1.size() == 1) {
                return l1.get(0).get(0);
            } else if (l1.size() == 2) {
                BigDecimal a = l1.get(0).get(0).getReal();
                BigDecimal b = l1.get(0).get(1).getReal();
                BigDecimal c = l1.get(1).get(0).getReal();
                BigDecimal d = l1.get(1).get(1).getReal();
                return new Atom(a.multiply(d).subtract(b.multiply(c)));
            } else if (l1.size() == 3) {
                BigDecimal a = l1.get(0).get(0).getReal();
                BigDecimal b = l1.get(0).get(1).getReal();
                BigDecimal c = l1.get(0).get(2).getReal();
                BigDecimal d = l1.get(1).get(0).getReal();
                BigDecimal e = l1.get(1).get(1).getReal();
                BigDecimal f = l1.get(1).get(2).getReal();
                BigDecimal g = l1.get(2).get(0).getReal();
                BigDecimal h = l1.get(2).get(1).getReal();
                BigDecimal i = l1.get(2).get(2).getReal();
                return new Atom(
                        a.multiply(e).multiply(i).add(b.multiply(f).multiply(g)).add(c.multiply(d).multiply(h))
                                .subtract(c.multiply(e).multiply(g)).subtract(b.multiply(d).multiply(i)).subtract(a.multiply(f).multiply(h))
                );
            } else {
                BigDecimal[][] A = l1.stream().map(x -> x.stream().map(Atom::getReal).toArray(BigDecimal[]::new)).toArray(BigDecimal[][]::new);
                BigDecimal[][][] lup;
                try {
                    lup = PLUDecomposition.lu(mc, A);
                } catch (ArithmeticException e) {
                    return Atom.FALSE;
                }
                BigInteger sumDiagP = BigInteger.ZERO;
                BigDecimal prodL = BigDecimal.ONE, prodU = BigDecimal.ONE;
                for (int i = 0; i < lup[2].length; i++)
                    sumDiagP = sumDiagP.add(lup[2][i][i].toBigIntegerExact());
                for (int i = 0; i < lup[0].length; i++)
                    prodL = prodL.multiply(lup[0][i][i]);
                for (int i = 0; i < lup[1].length; i++)
                    prodU = prodU.multiply(lup[1][i][i]);

                BigDecimal detp = BigInteger.valueOf(lup[2].length - 1).subtract(sumDiagP).remainder(BigInteger.TWO).compareTo(BigInteger.ZERO) == 0 ? BigDecimal.ONE : BigDecimal.ONE.negate();
                BigDecimal result = detp.multiply(prodL).multiply(prodU);
                result = result.setScale(mc.getPrecision(), mc.getRoundingMode());
                return new Atom(result);
            }
        } else {
            if (l1.size() == 0) {
                throw new RuntimeException("Expected at least a 2x2 matrix.");
            } else if (l1.size() == 1) {
                return l1.get(0).get(0);
            } else if (l1.size() == 2) {
                BigComplex a = l1.get(0).get(0).getComplex();
                BigComplex b = l1.get(0).get(1).getComplex();
                BigComplex c = l1.get(1).get(0).getComplex();
                BigComplex d = l1.get(1).get(1).getComplex();
                return new Atom(a.multiply(d).subtract(b.multiply(c)));
            } else if (l1.size() == 3) {
                BigComplex a = l1.get(0).get(0).getComplex();
                BigComplex b = l1.get(0).get(1).getComplex();
                BigComplex c = l1.get(0).get(2).getComplex();
                BigComplex d = l1.get(1).get(0).getComplex();
                BigComplex e = l1.get(1).get(1).getComplex();
                BigComplex f = l1.get(1).get(2).getComplex();
                BigComplex g = l1.get(2).get(0).getComplex();
                BigComplex h = l1.get(2).get(1).getComplex();
                BigComplex i = l1.get(2).get(2).getComplex();
                return new Atom(
                        a.multiply(e).multiply(i).add(b.multiply(f).multiply(g)).add(c.multiply(d).multiply(h))
                                .subtract(c.multiply(e).multiply(g)).subtract(b.multiply(d).multiply(i)).subtract(a.multiply(f).multiply(h))
                );
            } else {
                BigComplex[][] A = l1.stream().map(x -> x.stream().map(Atom::getComplex).toArray(BigComplex[]::new)).toArray(BigComplex[][]::new);
                BigComplex[][][] lup;
                try {
                    lup = PLUDecomposition.lu(mc, A);
                } catch (ArithmeticException e) {
                    return Atom.FALSE;
                }
                BigInteger sumDiagP = BigInteger.ZERO;
                BigComplex prodL = BigComplex.ONE, prodU = BigComplex.ONE;
                for (int i = 0; i < lup[2].length; i++)
                    sumDiagP = sumDiagP.add(lup[2][i][i].re.toBigIntegerExact());
                for (int i = 0; i < lup[0].length; i++)
                    prodL = prodL.multiply(lup[0][i][i]);
                for (int i = 0; i < lup[1].length; i++)
                    prodU = prodU.multiply(lup[1][i][i]);

                BigComplex detp = BigInteger.valueOf(lup[2].length - 1).subtract(sumDiagP).remainder(BigInteger.TWO).compareTo(BigInteger.ZERO) == 0 ? BigComplex.ONE : BigComplex.ONE.negate();
                BigComplex result = detp.multiply(prodL).multiply(prodU);
                BigDecimal re = result.re.setScale(mc.getPrecision(), mc.getRoundingMode());
                BigDecimal im = result.im.setScale(mc.getPrecision(), mc.getRoundingMode());
                return new Atom(BigComplex.valueOf(re, im));
            }
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        Atom a1 = args.get(0);
        if (Rank.computeRank(a1) != 2) {
            throw new RuntimeException("Expected a matrix of rank 2.");
        }

        List<List<Atom>> l1 = a1.getList().stream().map(Atom::getList).toList();
        return det(env.getMathContext(), l1);
    }

    @Override
    protected String name() {
        return "num:det";
    }
}
