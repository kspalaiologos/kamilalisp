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

import java.util.Arrays;
import java.util.function.BiFunction;
import java.util.function.LongFunction;

/**
 * Helper class for the incomplete gamma function.
 *
 * @since 1.10.0
 * @version 1.11.0
 * @author Mikko Tommila
 */

class IncompleteGammaHelper
{
    // See https://hal.archives-ouvertes.fr/hal-01329669/document
    // Fast and accurate evaluation of a generalized incomplete gamma function Rémy Abergel, Lionel Moisan

    private static class Sequence
    {
        public Sequence(LongFunction<Apcomplex> a, LongFunction<Apcomplex> b)
        {
            this.a = a;
            this.b = b;
        }

        public Apcomplex a(long n)
        {
            return this.a.apply(n);
        }

        public Apcomplex b(long n)
        {
            return this.b.apply(n);
        }

        private LongFunction<Apcomplex> a;
        private LongFunction<Apcomplex> b;
    }

    private static class ContinuedFractionResult
    {
        private Apcomplex result;
        private Apcomplex delta;
        private long iterations;

        public ContinuedFractionResult(Apcomplex result, Apcomplex delta, long iterations)
        {
            this.result = result;
            this.delta = delta;
            this.iterations = iterations;
        }

        public Apcomplex getResult()
        {
            return result;
        }

        public Apcomplex getDelta()
        {
            return delta;
        }

        public long getIterations()
        {
            return iterations;
        }
    }

    private static enum ContinuedFractionType
    {
        LOWER, UPPER;
    }

    private static enum ContinuedFraction
    {
        LOWER1(ContinuedFractionType.LOWER, IncompleteGammaHelper::lowerGammaSequence)
        {
            @Override
            protected long doGetMinIterations(Apcomplex a, Apcomplex z)
            {
                return (a.real().signum() >= 0 ? 0 : Math.subtractExact(4, Math.multiplyExact(2, a.real().longValueExact())));
            }
        },
        LOWER2(ContinuedFractionType.LOWER, IncompleteGammaHelper::lowerGammaSequenceAlternative)
        {
            @Override
            protected long doGetMinIterations(Apcomplex a, Apcomplex z)
            {
                return Math.max(a.real().signum() >= 0 ? 0 : Math.subtractExact(3, a.real().longValueExact()),
                                Math.subtractExact(2, Math.addExact(a.real().longValueExact(), z.real().longValueExact())));
            }
        },
        UPPER1(ContinuedFractionType.UPPER, IncompleteGammaHelper::upperGammaSequence)
        {
            @Override
            protected long doGetMinIterations(Apcomplex a, Apcomplex z)
            {
                return Math.max(a.real().signum() <= 0 ? 0 : Math.addExact(2, a.real().longValueExact()),
                                Math.addExact(1, Math.subtractExact(a.real().longValueExact(), z.real().longValueExact()) / 2));
            }
        },
        UPPER2(ContinuedFractionType.UPPER, IncompleteGammaHelper::upperGammaSequenceAlternative)
        {
            @Override
            protected long doGetMinIterations(Apcomplex a, Apcomplex z)
            {
                return (a.real().signum() <= 0 ? 0 : Math.addExact(Math.multiplyExact(2, a.real().longValueExact()), 2));
            }
        };

        private ContinuedFraction(ContinuedFractionType type, BiFunction<Apcomplex, Apcomplex, Sequence> sequence)
        {
            this.type = type;
            this.sequence = sequence;
        }

        public ContinuedFractionType getType()
        {
            return this.type;
        }

        public BiFunction<Apcomplex, Apcomplex, Sequence> getSequence()
        {
            return this.sequence;
        }

        public long getMinIterations(Apcomplex a, Apcomplex z)
        {
            try
            {
                return doGetMinIterations(a, z);
            }
            catch (ArithmeticException ae)
            {
                throw new OverflowException(ae.getMessage(), ae);
            }
        }

        protected abstract long doGetMinIterations(Apcomplex a, Apcomplex z);

        public static ContinuedFraction[] upperValues()
        {
            ContinuedFraction[] upperValues = { UPPER1 };
            return upperValues;
        }

        public static ContinuedFraction[] lowerValues()
        {
            ContinuedFraction[] lowerValues = { LOWER1 };
            return lowerValues;
        }

        public static ContinuedFraction[] bothValues()
        {
            ContinuedFraction[] bothValues = { LOWER1, UPPER1 };
            return bothValues;
        }

        private ContinuedFractionType type;
        private BiFunction<Apcomplex, Apcomplex, Sequence> sequence;
    }

    private static class GammaValue
    {
        public GammaValue(Apcomplex a, Apcomplex result, boolean inverted)
        {
            this.a = a;
            this.result = result;
            this.inverted = inverted;
        }

        public GammaValue invert()
        {
            return new GammaValue(this.a, this.result, !this.inverted);
        }

        public Apcomplex subtract(GammaValue that)
        {
            if (this.inverted == that.inverted)
            {
                Apcomplex result = this.result.subtract(that.result);
                return this.inverted ? result.negate() : result;
            }
            else
            {
                Apcomplex result = this.result.add(that.result).subtract(ApcomplexMath.gamma(this.a));
                return this.inverted ? result.negate() : result;
            }
        }

        public Apcomplex getValue()
        {
            return (this.inverted ? ApcomplexMath.gamma(this.a).subtract(this.result) : this.result);
        }

        private Apcomplex a;
        private Apcomplex result;
        private boolean inverted;
    }

    private static class RetryException
        extends RuntimeException
    {
        private static final long serialVersionUID = 1L;
    }

    public static Apcomplex gamma(Apcomplex a, Apcomplex z)
    {
        if (z.real().signum() == 0 && z.imag().signum() == 0)
        {
            if (a.real().signum() <= 0)
            {
                throw new ArithmeticException("Upper gamma with first argument real part nonpositive and second argment zero");
            }
            return ApcomplexMath.gamma(a);
        }
        checkPrecision(a, z);

        return upperGamma(a, z).getValue();
    }

    public static Apcomplex gamma(Apcomplex a, Apcomplex z0, Apcomplex z1)
    {
        if (a.real().signum() == 0 && a.imag().signum() == 0 &&
            z0.real().signum() == 0 && z0.imag().signum() == 0 &&
            z1.real().signum() == 0 && z1.imag().signum() == 0)
        {
            throw new ArithmeticException("Gamma of zero");
        }
        if (z0.equals(z1))
        {
            return Apcomplex.ZEROS[z0.radix()];
        }
        checkPrecision(a, z0, z1);

        if (z0.real().signum() == 0 && z0.imag().signum() == 0)
        {
            return lowerGamma(a, z1, null).getValue();
        }
        if (z1.real().signum() == 0 && z1.imag().signum() == 0)
        {
            return lowerGamma(a, z0, null).getValue().negate();
        }

        return upperGamma(a, z0).subtract(upperGamma(a, z1));
    }

    private static void checkPrecision(Apcomplex... z)
    {
        long precision = Arrays.stream(z).mapToLong(Apcomplex::precision).min().getAsLong();
        if (precision == Apfloat.INFINITE)
        {
            throw new InfiniteExpansionException("Cannot calculate incomplete gamma function to infinite precision");
        }
    }

    private static GammaValue upperGamma(Apcomplex a, Apcomplex z)
    {
        ContinuedFraction[] algorithms = null;
        if (a.isInteger() && a.real().signum() <= 0)
        {
            if (isCloseToNegativeRealAxis(z))
            {
                // Note that this transformation may be extremely slow if n is large
                // gamma(-n,z) = (-1)^n/n! gamma(0,z) - e^-z sum[z^(k-n-1)/(-n)_k,{k,1,n}]
                // See https://functions.wolfram.com/GammaBetaErf/Gamma2/17/02/01/
                long n;
                try
                {
                    n = a.real().longValueExact(); // If this overflows then the value would overflow anyways
                }
                catch (ArithmeticException ae)
                {
                    throw new OverflowException(ae.getMessage(), ae);
                }
                return new GammaValue(a, upperGamma(n, z), false);
            }
            algorithms = ContinuedFraction.upperValues();
        }

        if (algorithms == null)
        {
            if (useLowerGamma(a, z))
            {
                return lowerGamma(a, z, ContinuedFraction.lowerValues()).invert();
            }
            algorithms = (isMaybeUnstable(a, z) ? ContinuedFraction.bothValues() : ContinuedFraction.upperValues());
        }

        ContinuedFraction fastest = fastestG(a, z, algorithms);
        return gammaG(a, z, fastest, ContinuedFractionType.UPPER);
    }

    private static GammaValue lowerGamma(Apcomplex a, Apcomplex z, ContinuedFraction[] algorithms)
    {
        if (a.isInteger() && a.real().signum() <= 0)
        {
            throw new ArithmeticException("Lower gamma with first argument nonpositive integer");
        }
        if (useSum(z))
        {
            // The series is fastest for small z
            return new GammaValue(a, sum(a, z), false);
        }

        if (algorithms == null)
        {
            if (isMaybeUnstable(a, z))
            {
                algorithms = ContinuedFraction.bothValues();
            }
            else if (useUpperGamma(a, z))
            {
                algorithms = ContinuedFraction.upperValues();
            }
            else
            {
                algorithms = ContinuedFraction.lowerValues();
            }
        }

        ContinuedFraction fastest = fastestG(a, z, algorithms);
        return gammaG(a, z, fastest, ContinuedFractionType.LOWER);
    }

    private static boolean useSum(Apcomplex z)
    {
        // The series converges fast for small z
        return z.scale() <= 0;
    }

    private static boolean useLowerGamma(Apcomplex a, Apcomplex z)
    {
        // The continued fraction for upper gamma would not converge well
        return z.scale() < a.scale() || isCloseToNegativeRealAxis(z) || useSum(z);
    }

    private static boolean isCloseToNegativeRealAxis(Apcomplex z)
    {
        // If z is too close to the negative real axis, the upper gamma continued fraction converges poorly
        return (z.real().signum() <= 0 || z.real().scale() < 0) && z.imag().scale() < 0;
    }

    private static boolean useUpperGamma(Apcomplex a, Apcomplex z)
    {
        // The continued fraction for upper gamma converges better
        return a.scale() < z.scale();
    }

    private static boolean isMaybeUnstable(Apcomplex a, Apcomplex z)
    {
        // Borderline cases where upper gamma continued fraction might not converge well
        if (a.scale() > 0 && z.scale() > 0)
        {
            double ratio = norm(a).divide(norm(z)).doubleValue();
            return 0.01 <= ratio && ratio <= 100.0;
        }
        return false;
    }

    private static Apfloat norm(Apcomplex z)
    {
        return ApcomplexMath.norm(z.precision(ApfloatHelper.getDoublePrecision(z.radix())));
    }

    private static GammaValue gammaG(Apcomplex a, Apcomplex z, ContinuedFraction algorithm, ContinuedFractionType type)
    {
        Apcomplex g = g(algorithm.getSequence(), a, z, algorithm.getMinIterations(a, z));
        return new GammaValue(a, g, algorithm.getType() != type);
    }

    // Converges well only when |z| > |a|, a can be zero but z cannot
    private static Sequence upperGammaSequence(Apcomplex a, Apcomplex z)
    {
        int radix = z.radix();
        Apfloat one = new Apint(1, radix);
        Apcomplex za = z.subtract(a);
        Sequence s = new Sequence(n ->
        {
            if (n == 1)
            {
                return one;
            }
            else
            {
                Apint n1 = new Apint(n - 1, radix);
                return n1.multiply(a.subtract(n1));
            }
        }, n -> new Apint(2 * n - 1, radix).add(za));
        return s;
    }

    // Converges best when |z| <= |a|, both a and z must be nonzero and a must not be a negative integer
    private static Sequence lowerGammaSequence(Apcomplex a, Apcomplex z)
    {
        int radix = z.radix();
        Apfloat one = new Apint(1, radix);
        Sequence s = new Sequence(n ->
        {
            if (n == 1)
            {
                return one;
            }
            else if (n % 2 == 0)
            {
                return new Apint(1 - n / 2, radix).subtract(a).multiply(z);
            }
            else
            {
                return new Apint(n / 2, radix).multiply(z);
            }
        }, n -> new Apint(n - 1, radix).add(a));
        return s;
    }

    // Inferior alternative to the upper gamma sequence, converges well only when z is not close to the negative real axis
    private static Sequence upperGammaSequenceAlternative(Apcomplex a, Apcomplex z)
    {
        int radix = z.radix();
        Apfloat one = new Apint(1, radix);
        Sequence s = new Sequence(n ->
        {
            if (n == 1)
            {
                return one;
            }
            else if (n % 2 == 0)
            {
                return new Apint(n / 2, radix).subtract(a);
            }
            else
            {
                return new Apint(n / 2, radix);
            }
        }, n -> (n % 2 == 0 ? one : z));
        return s;
    }

    // Inferior alternative to the lower gamma sequence, converges well only when z is not close to the negative real axis
    private static Sequence lowerGammaSequenceAlternative(Apcomplex a, Apcomplex z)
    {
        int radix = z.radix();
        Apfloat one = new Apint(1, radix);
        Apcomplex az = a.add(z);
        Sequence s = new Sequence(n ->
        {
            if (n == 1)
            {
                return one;
            }
            else
            {
                return new Apint(2 - n, radix).subtract(a).multiply(z);
            }
        }, n ->
        {
            if (n == 1)
            {
                return a;
            }
            else
            {
                return az.add(new Apint(n - 1, radix));
            }
        });
        return s;
    }

    private static ContinuedFraction fastestG(Apcomplex a, Apcomplex z, ContinuedFraction[] algorithms)
    {
        // There are some input values for which the upper continued fraction behaves in a very pathological way e.g. a=-1e-2+4e2i and z=1e-2+1e2i
        int radix = z.radix();
        long precision = (long) (50 / Math.log10(radix));
        a = a.precision(precision);
        z = z.precision(precision);

        ContinuedFraction fastest = null;
        ContinuedFractionResult fastestResult = null;
        for (ContinuedFraction continuedFraction : algorithms)
        {
            ContinuedFractionResult result = continuedFraction(continuedFraction.sequence.apply(a, z), radix, precision, 0, 50);
            if (fastest == null)
            {
                fastest = continuedFraction;
                fastestResult = result;
            }
            else
            {
                long resultIterations = result.getIterations();
                long fastestIterations = fastestResult.getIterations();
                if (resultIterations < fastestIterations)
                {
                    // Whichever continued fraction reached the precision goal earlier is faster
                    fastest = continuedFraction;
                    fastestResult = result;
                }
                else if (resultIterations == fastestIterations)
                {
                    // If neither continued fraction reached the precision goal within the max iterations, see which one got better precision
                    Apint one = new Apint(1, radix);
                    long resultPrecision = result.getDelta().equalDigits(one);
                    long fastestPrecision = fastestResult.getDelta().equalDigits(one);
                    if (resultPrecision > fastestPrecision)
                    {
                        fastest = continuedFraction;
                        fastestResult = result;
                    }
                }
            }
        }

        return fastest;
    }

    private static Apcomplex g(BiFunction<Apcomplex, Apcomplex, Sequence> s, Apcomplex a, Apcomplex z, long minIterations)
    {
        int radix = z.radix();
        long extraPrecision = extraPrecision(radix); // More extra precision because the incomplete gamma behaves so erratically, the more the bigger the numbers
        a = ApfloatHelper.extendPrecision(a, extraPrecision);
        z = ApfloatHelper.extendPrecision(z, extraPrecision);
        long reducePrecision = extraPrecision;

        Apcomplex f = null;
        do
        {
            try
            {
                f = continuedFraction(s.apply(a, z), radix, Math.min(a.precision(), z.precision()), minIterations, Long.MAX_VALUE).getResult();
            }
            catch (RetryException re)
            {
                // If the continued fraction initially converges to a wrong value and we don't calculate it accurately enough then keep increasing the precision
                // See:
                // Walter Gautschi, "Anomalous convergence of a continued fraction for ratios of Kummer functions", Mathematics of Computation, volume 31, number 140, October 1977, pages 994-999
                // https://www.ams.org/journals/mcom/1977-31-140/S0025-5718-1977-0442204-3/S0025-5718-1977-0442204-3.pdf
                a = ApfloatHelper.extendPrecision(a, extraPrecision);
                z = ApfloatHelper.extendPrecision(z, extraPrecision);
                reducePrecision += extraPrecision;
                extraPrecision += extraPrecision;
            }
        } while (f == null);
        Apcomplex g = f.multiply(ApcomplexMath.exp(a.multiply(ApcomplexMath.log(z)).subtract(z)));

        return ApfloatHelper.reducePrecision(g, reducePrecision);
    }

    private static long extraPrecision(int radix)
    {
        return (long) (Apfloat.EXTRA_PRECISION * 2 / Math.log10(radix));
    }

    // Modified Lentz's method
    private static ContinuedFractionResult continuedFraction(Sequence s, int radix, long workingPrecision, long minIterations, long maxIterations)
    {
        Apint one = new Apint(1, radix);
        long n = 0;
        Apcomplex an;
        Apcomplex bn;
        Apcomplex f = tiny(new Apint(0, radix), workingPrecision);
        Apcomplex c = f;
        Apcomplex d = Apcomplex.ZERO;
        Apcomplex delta;
        long precision;
        long precisionLoss = extraPrecision(radix) / 4;
        long targetPrecision = workingPrecision - precisionLoss;  // Due to round-off errors we cannot always reach workingPrecision but slightly less is sufficient
        long maxPrecision = 0;
        do
        {
            n = Math.addExact(n, 1);
            an = s.a(n).precision(workingPrecision);
            bn = s.b(n).precision(workingPrecision);
            d = d.multiply(an).add(bn);
            d = ApfloatHelper.ensurePrecision(d, workingPrecision);
            if (d.real().signum() == 0 && d.imag().signum() == 0)
            {
                d = tiny(bn, workingPrecision);
            }
            c = bn.add(an.divide(c));
            c = ApfloatHelper.ensurePrecision(c, workingPrecision);
            if (c.real().signum() == 0 && c.imag().signum() == 0)
            {
                c = tiny(bn, workingPrecision);
            }
            d = one.divide(d);
            delta = c.multiply(d);
            f = f.multiply(delta);
            precision = delta.equalDigits(one);
            maxPrecision = Math.max(maxPrecision, precision);
            if (precision < precisionLoss && maxPrecision >= targetPrecision - precisionLoss)   // Check if the continued fraction initially converges to a wrong value and we don't calculate it accurately enough
            {
                throw new RetryException();
            }
        } while (n < minIterations ||
                 n <= maxIterations &&
                 precision < targetPrecision);
        return new ContinuedFractionResult(f, delta, n);
    }

    private static Apcomplex tiny(Apcomplex z, long workingPrecision)
    {
        if (z.real().signum() == 0 && z.imag().signum() == 0)
        {
            z = new Apfloat(1, workingPrecision, z.radix());
        }
        return ApcomplexMath.scale(ApcomplexMath.ulp(z), -workingPrecision).precision(workingPrecision);
    }

    // Upper gamma of nonpositive integer
    private static Apcomplex upperGamma(long mn, Apcomplex z)
    {
        Apcomplex result = e1(z);   // Same as upperGamma(0, z)
        assert (mn <= 0);
        long n = -mn;
        if (n > 0)
        {
            long workingPrecision = ApfloatHelper.extendPrecision(z.precision());
            int radix = z.radix();
            result = result.divide(ApfloatMath.factorial(n, workingPrecision, radix));
            if ((n & 1) == 1)
            {
                result = result.negate();
            }
            z = ApfloatHelper.extendPrecision(z);
            Apcomplex ez = ApcomplexMath.exp(z.negate());
            Apcomplex s = ApcomplexMath.pow(z, mn).divide(new Apint(mn, radix)),
                      sum = s;
            for (long k = 2; k <= n; k++)
            {
                mn++;
                s = s.multiply(z).divide(new Apint(mn, radix));
                sum = sum.add(s);
            }
            result = result.subtract(ez.multiply(sum));
        }
        return result;
    }

    private static Apcomplex sum(Apcomplex a, Apcomplex z)
    {
        a = ApfloatHelper.extendPrecision(a);
        z = ApfloatHelper.extendPrecision(z);

        boolean useAlternatingSum = (z.real().signum() >= 0);
        Apcomplex za = ApcomplexMath.pow(z, a);
        if (!useAlternatingSum)
        {
            za = za.multiply(ApcomplexMath.exp(z.negate()));
        }
        long targetPrecision = Math.min(a.precision(), z.precision());
        int radix = z.radix();
        Apcomplex sum = Apcomplex.ZERO;
        Apint one = new Apint(1, radix);
        Apcomplex f = (useAlternatingSum ? one.precision(targetPrecision) : a);
        long n = 0;
        Apcomplex t;
        do
        {
            if (useAlternatingSum)
            {
                Apint nn = new Apint(n, radix);
                Apcomplex an = a.add(nn);
                if (n > 0)
                {
                    za = za.multiply(z);
                    f = f.multiply(nn);
                }
                t = za.divide(f.multiply(an));
                sum = (n & 1) == 0 ? sum.add(t) : sum.subtract(t);
            }
            else
            {
                if (n > 0)
                {
                    a = a.add(one);
                    za = za.multiply(z);
                    f = f.multiply(a);
                }
                t = za.divide(f);
                sum = sum.add(t);
            }
            n++;
        } while (sum.scale() - t.scale() < targetPrecision && !t.equals(Apcomplex.ZERO)); // Also check for underflow of t

        return ApfloatHelper.reducePrecision(sum);
    }

    // Exponential integral for upperGamma(0, z)
    private static Apcomplex e1(Apcomplex z)
    {
        assert (isCloseToNegativeRealAxis(z));

        int radix = z.radix();
        long targetPrecision = z.precision();
        Apcomplex mz = ApfloatHelper.extendPrecision(z).negate();
        Apcomplex s = mz,
                  sum = s,
                  t;
        long k = 1;
        do
        {
            k++;
            Apint kk = new Apint(k, radix);
            s = s.multiply(mz).divide(kk);
            t = s.divide(kk);
            sum = sum.add(t);
        } while (sum.scale() - t.scale() < targetPrecision && !t.equals(Apcomplex.ZERO));   // Also check for underflow of t

        Apcomplex result = ApfloatMath.euler(targetPrecision, radix).negate().subtract(ApcomplexMath.log(z)).subtract(ApfloatHelper.reducePrecision(sum));
        return result;
    }
}
