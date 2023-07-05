/*
 * MIT License
 *
 * Copyright (c) 2002-2023 Mikko Tommila
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
package org.apfloat;

/**
 * Helper class for the Riemann zeta function.
 *
 * @since 1.11.0
 * @version 1.11.0
 * @author Mikko Tommila
 */

class ZetaHelper
{
    // See http://numbers.computation.free.fr/Constants/Miscellaneous/zetaevaluations.pdf
    // Numerical evaluation of the Riemann Zeta-function, Xavier Gourdon and Pascal Sebah, 23 July 2003

    // See https://arxiv.org/pdf/1703.01414.pdf
    // The Zetafast algorithm for computing zeta functions, Kurt Fischer, 8 June 2017

    public static Apcomplex zeta(Apcomplex s)
    {
        int radix = s.radix();
        Apint one = new Apint(1, radix);
        if (s.equals(one))
        {
            throw new ArithmeticException("Zeta of one");
        }
        Apint two = new Apint(2, radix);
        if (s.isInteger() && s.real().signum() < 0 && s.real().mod(two).signum() == 0)
        {
            return Apcomplex.ZEROS[radix];
        }
        if (s.real().signum() == 0 && s.imag().signum() == 0)
        {
            return new Aprational(one, two).negate();
        }
        if (s.precision() == Apfloat.INFINITE)
        {
            throw new InfiniteExpansionException("Cannot calculate zeta function to infinite precision");
        }
        if (s.real().signum() < 0)
        {
            s = ApfloatHelper.extendPrecision(s);
            Apcomplex result = chi(s).multiply(zeta(one.subtract(s)));
            return ApfloatHelper.reducePrecision(result);
        }
        if (s.imag().signum() < 0)
        {
            return zeta(s.conj()).conj();
        }
        if (s.imag().doubleValue() == Double.POSITIVE_INFINITY)
        {
            throw new OverflowException("Imaginary part too large");
        }

        if (s.real().compareTo(one) < 0 && s.imag().compareTo(new Apint(50000, radix)) > 0)
        {
            // Zetafast is only faster for rather large values if Im(s)
            return new ZetaHelper().zetafast(s);
        }
        else
        {
            return alternatingSum(s);
        }
    }

    private static Apcomplex chi(Apcomplex s)
    {
        int radix = s.radix();
        Apint one = new Apint(1, radix),
              two = new Apint(2, radix);
        Apfloat pi = ApfloatMath.pi(s.precision(), radix);
        Apcomplex s1 = s.subtract(one);

        return ApcomplexMath.pow(two, s).multiply(ApcomplexMath.pow(pi, s1)).multiply(ApcomplexMath.sin(pi.multiply(s).divide(two))).multiply(ApcomplexMath.gamma(s1.negate()));
    }

    public static Apcomplex alternatingSum(Apcomplex s)
    {
        int radix = s.radix();
        long doublePrecision = ApfloatHelper.getDoublePrecision(radix),
             workingPrecision = s.precision();
        Apint one = new Apint(1, radix),
              two = new Apint(2, radix),
              four = new Apint(4, radix);
        double t = Math.abs(s.imag().doubleValue()),
               s12 = ApcomplexMath.abs(one.subtract(ApcomplexMath.pow(two, one.subtract(s.precision(doublePrecision))))).doubleValue();
        long n = (long) ((workingPrecision * Math.log(radix) + t * Math.PI / 2 + Math.log((1 + 2 * t) / s12)) / Math.log(3 + Math.sqrt(8))),
             n2 = Math.multiplyExact(n, 2);
        Apfloat denominator = ApfloatMath.factorial(n2, workingPrecision, radix),
                numerator = new Apint(n, radix).multiply(denominator).multiply(ApfloatMath.pow(four.precision(workingPrecision), n)),
                d = Apfloat.ZERO;
        Apcomplex sum = Apcomplex.ZERO;
        for (long k = n; k > 0; k--)
        {
            numerator = numerator.divide(new Apint(n + k, radix));
            d = d.add(numerator.divide(denominator));
            numerator = numerator.divide(four);
            denominator = denominator.multiply(new Apint(n - k + 1, radix)).divide(new Apint(2 * k, radix)).divide(new Apint(2 * k - 1, radix));
            sum = sum.add(((k & 1) == 0 ? d.negate() : d).multiply(ApcomplexMath.pow(new Apint(k, radix), s.negate())));
        }
        d = d.add(numerator.divide(denominator));
        Apcomplex result = one.divide(d.multiply(one.subtract(ApcomplexMath.pow(two, one.subtract(s))))).multiply(sum);
        return result;
    }

    public Apcomplex zetafast(Apcomplex s)
    {
        this.radix = s.radix();
        s = ApfloatHelper.extendPrecision(s);
        this.workingPrecision = s.precision();
        double t = s.imag().doubleValue();
        this.v = findRoot(s, t, radix, workingPrecision);
        double N = 1.11 * Math.sqrt(1 + (0.5 + t) / v);
        this.NN = new Apfloat(N, workingPrecision, radix);
        long M = (long) Math.ceil(N);
        this.one = new Apint(1, radix);
        this.two = new Apint(2, radix);
        this.pi = ApfloatMath.pi(workingPrecision, radix);
        this.i = new Apcomplex(Apcomplex.ZERO, one);
        this.s1 = s.subtract(one);
        this.oneS = s1.negate();
        this.iTwoPiN = i.divide(two.multiply(pi).multiply(NN));
        this.gammaS = ApcomplexMath.gamma(s);
        Apint vv = new Apint(v, radix);
        Apcomplex result = D(N, s).add(E1(M, s)).subtract(ApcomplexMath.gamma(oneS.add(vv)).divide(oneS.multiply(ApcomplexMath.gamma(vv))).multiply(ApcomplexMath.pow(NN, oneS)));
        result = ApfloatHelper.reducePrecision(result);
        return result;
    }

    private static long findRoot(Apcomplex s, double t, int radix, long workingPrecision)
    {
        double m = Math.max(1 - s.real().doubleValue(), 0) / 2,
               x = 0,
               p;
        do
        {
            p = x;
            x = Math.log(8) + workingPrecision * Math.log(radix) + m * Math.log(0.5 + x + t);
        } while (Math.ceil(x) != Math.ceil(p));
        return (long) Math.ceil(x);
    }

    private Apcomplex D(double N, Apcomplex s)
    {
        double lambda = 3.151;
        long limit = (long) Math.ceil(lambda * v * N);
        Apcomplex sum = Apcomplex.ZERO;
        for (long n = 1; n <= limit; n++)
        {
            Apint nn = new Apint(n, radix);
            sum = sum.add(ApcomplexMath.pow(nn, s.negate()).multiply(Q(v, nn.divide(NN))));
        }
        return sum;
    }

    private Apcomplex Q(long v, Apfloat m)
    {
        Apfloat numerator = new Apfloat(1, workingPrecision, radix),
                denominator = numerator;
        Apcomplex sum = Apcomplex.ZERO;
        for (long w = 0; w < v; w++)
        {
            sum = sum.add(numerator.divide(denominator));
            numerator = numerator.multiply(m);
            denominator = denominator.multiply(new Apint(w + 1, radix));
        }
        Apcomplex result = sum.multiply(ApcomplexMath.exp(m.negate()));
        return result;
    }

    private Apcomplex E1(long M, Apcomplex s)
    {
        Apcomplex sum = Apcomplex.ZERO;
        for (long m = 1; m <= M; m++)
        {
            sum = sum.add(E1(new Apint(m, radix), s));
        }
        Apcomplex result = ApcomplexMath.pow(two.multiply(pi), s1).multiply(ApcomplexMath.gamma(oneS)).multiply(ApcomplexMath.exp(i.multiply(pi).divide(two).multiply(oneS))).multiply(sum);
        return result;
    }

    private Apcomplex E1(Apcomplex m, Apcomplex s)
    {
        Apcomplex miTwoPiN = m.add(iTwoPiN),
                  denominator = gammaS,
                  numerator = denominator.multiply(ApcomplexMath.pow(miTwoPiN, s1)),
                  sum = Apcomplex.ZERO;
        for (long w = 0; w < v; w++)
        {
            Apint ww = new Apint(w, radix);
            sum = sum.add(numerator.divide(denominator));
            Apint w1 = ww.add(one);
            numerator = numerator.multiply(iTwoPiN.negate());
            denominator = denominator.multiply(w1).divide(s.subtract(w1)).multiply(miTwoPiN);
        }
        Apcomplex result = ApcomplexMath.pow(m, s1).subtract(sum);
        return result;
    }

    private int radix;
    private long workingPrecision;
    private long v;
    private Apfloat NN;
    private Apint one;
    private Apint two;
    private Apfloat pi;
    private Apcomplex i;
    private Apcomplex oneS;
    private Apcomplex s1;
    private Apcomplex iTwoPiN;
    private Apcomplex gammaS;
}
