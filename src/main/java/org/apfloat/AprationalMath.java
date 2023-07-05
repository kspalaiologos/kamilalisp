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

import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.Iterator;
import java.util.List;
import java.util.NoSuchElementException;

/**
 * Various mathematical functions for arbitrary precision rational numbers.
 *
 * @version 1.11.0
 * @author Mikko Tommila
 */

public class AprationalMath
{
    private AprationalMath()
    {
    }

    /**
     * Integer power.
     *
     * @param x Base of the power operator.
     * @param n Exponent of the power operator.
     *
     * @return <code>x</code> to the <code>n</code>:th power, that is <code>x<sup>n</sup></code>.
     *
     * @exception ArithmeticException If both <code>x</code> and <code>n</code> are zero.
     */

    public static Aprational pow(Aprational x, long n)
        throws ArithmeticException, ApfloatRuntimeException
    {
        if (n == 0)
        {
            if (x.signum() == 0)
            {
                throw new ArithmeticException("Zero to power zero");
            }

            return new Apint(1, x.radix());
        }
        else if (n < 0)
        {
            x = Aprational.ONE.divide(x);
            n = -n;
        }

        // Algorithm improvements by Bernd Kellner
        int b2pow = 0;

        while ((n & 1) == 0)
        {
            b2pow++;
            n >>>= 1;
        }

        Aprational r = x;

        while ((n >>>= 1) > 0)
        {
            x = x.multiply(x);
            if ((n & 1) != 0)
            {
                r = r.multiply(x);
            }
        }

        while (b2pow-- > 0)
        {
            r = r.multiply(r);
        }

        return r;
    }

    /**
     * Returns an aprational whose value is <code>-x</code>.
     *
     * @deprecated Use {@link Aprational#negate()}.
     *
     * @param x The argument.
     *
     * @return <code>-x</code>.
     */

    @Deprecated
    public static Aprational negate(Aprational x)
        throws ApfloatRuntimeException
    {
        return x.negate();
    }

    /**
     * Absolute value.
     *
     * @param x The argument.
     *
     * @return Absolute value of <code>x</code>.
     */

    public static Aprational abs(Aprational x)
        throws ApfloatRuntimeException
    {
        if (x.signum() >= 0)
        {
            return x;
        }
        else
        {
            return x.negate();
        }
    }

    /**
     * Copy sign from one argument to another.
     *
     * @param x The value whose sign is to be adjusted.
     * @param y The value whose sign is to be used.
     *
     * @return <code>x</code> with its sign changed to match the sign of <code>y</code>.
     *
     * @since 1.1
     */

    public static Aprational copySign(Aprational x, Aprational y)
        throws ApfloatRuntimeException
    {
        if (y.signum() == 0)
        {
            return y;
        }
        else if (x.signum() != y.signum())
        {
            return x.negate();
        }
        else
        {
            return x;
        }
    }

    /**
     * Multiply by a power of the radix.
     * Note that this method is prone to intermediate overflow errors.
     * Also, scaling by a very large negative number won't result in an
     * underflow and a zero result, but an overflow of the denominator
     * and an exception thrown.
     *
     * @param x The argument.
     * @param scale The scaling factor.
     *
     * @return <code>x * x.radix()<sup>scale</sup></code>.
     */

    public static Aprational scale(Aprational x, long scale)
        throws ApfloatRuntimeException
    {
        if (scale >= 0)
        {
            return new Aprational(ApintMath.scale(x.numerator(), scale), x.denominator());
        }
        else if (scale == 0x8000000000000000L)
        {
            Apint scaler = ApintMath.pow(new Apint(x.radix(), x.radix()), 0x4000000000000000L);
            return new Aprational(x.numerator(), x.denominator().multiply(scaler)).divide(scaler);
        }
        else
        {
            return new Aprational(x.numerator(), ApintMath.scale(x.denominator(), -scale));
        }
    }

    /**
     * Rounds the given number to the specified precision with the specified rounding mode.
     *
     * @deprecated Use {@link #roundToPrecision(Aprational,long,RoundingMode)}.
     *
     * @param x The number to round.
     * @param precision The precision to round to.
     * @param roundingMode The rounding mode to use.
     *
     * @return The rounded number.
     *
     * @exception IllegalArgumentException If <code>precision</code> is less than zero or zero.
     * @exception ArithmeticException If rounding is necessary (result is not exact) and rounding mode is {@link RoundingMode#UNNECESSARY}.
     *
     * @since 1.7.0
     */

    @Deprecated
    public static Apfloat round(Aprational x, long precision, RoundingMode roundingMode)
        throws IllegalArgumentException, ArithmeticException, ApfloatRuntimeException
    {
        return roundToPrecision(x, precision, roundingMode);
    }

    /**
     * Rounds the given number to the specified precision with the specified rounding mode.
     *
     * @param x The number to round.
     * @param precision The precision to round to.
     * @param roundingMode The rounding mode to use.
     *
     * @return The rounded number.
     *
     * @exception IllegalArgumentException If <code>precision</code> is less than zero or zero.
     * @exception ArithmeticException If rounding is necessary (result is not exact) and rounding mode is {@link RoundingMode#UNNECESSARY}.
     *
     * @since 1.11.0
     */

    public static Apfloat roundToPrecision(Aprational x, long precision, RoundingMode roundingMode)
        throws IllegalArgumentException, ArithmeticException, ApfloatRuntimeException
    {
        return RoundingHelper.roundToPrecision(x, precision, roundingMode);
    }

    /**
     * Rounds <code>x</code> to integer using the specified rounding mode.
     *
     * @param x The number to round.
     * @param roundingMode The rounding mode to use.
     *
     * @return The rounded number.
     *
     * @exception ArithmeticException If rounding is necessary (result is not exact) and rounding mode is {@link RoundingMode#UNNECESSARY}.
     *
     * @since 1.11.0
     */

    public static Apint roundToInteger(Aprational x, RoundingMode roundingMode)
        throws IllegalArgumentException, ArithmeticException, ApfloatRuntimeException
    {
        return RoundingHelper.roundToInteger(x, roundingMode);
    }

    /**
     * Rounds <code>x</code> to the specified number of places using the specified rounding mode.
     *
     * @param x The number to round.
     * @param places The number of places to round to (in base 10, the number of decimal places).
     * @param roundingMode The rounding mode to use.
     *
     * @return The rounded number.
     *
     * @exception ArithmeticException If rounding is necessary (result is not exact) and rounding mode is {@link RoundingMode#UNNECESSARY}.
     *
     * @since 1.11.0
     */

    public static Apfloat roundToPlaces(Aprational x, long places, RoundingMode roundingMode)
        throws IllegalArgumentException, ArithmeticException, ApfloatRuntimeException
    {
        return RoundingHelper.roundToPlaces(x, places, roundingMode);
    }

    /**
     * Rounds <code>x</code> to the nearest multiple of <code>y</code> using the specified rounding mode.
     *
     * @param x The number to round.
     * @param y The integer multiple to round to.
     * @param roundingMode The rounding mode to use.
     *
     * @return The rounded number.
     *
     * @exception ArithmeticException If rounding is necessary (result is not exact) and rounding mode is {@link RoundingMode#UNNECESSARY}.
     *
     * @since 1.11.0
     */

    public static Aprational roundToMultiple(Aprational x, Aprational y, RoundingMode roundingMode)
        throws IllegalArgumentException, ArithmeticException, ApfloatRuntimeException
    {
        return RoundingHelper.roundToMultiple(x, y, roundingMode);
    }

    /**
     * Product of numbers.
     * This method may perform significantly better
     * than simply multiplying the numbers sequentially.<p>
     *
     * If there are no arguments, the return value is <code>1</code>.
     *
     * @param x The argument(s).
     *
     * @return The product of the given numbers.
     *
     * @since 1.3
     */

    public static Aprational product(Aprational... x)
        throws ApfloatRuntimeException
    {
        if (x.length == 0)
        {
            return Aprational.ONE;
        }

        Apint[] n = new Apint[x.length],
                m = new Apint[x.length];
        for (int i = 0; i < x.length; i++)
        {
            if (x[i].signum() == 0)
            {
                return Aprational.ZEROS[x[i].radix()];
            }
            n[i] = x[i].numerator();
            m[i] = x[i].denominator();
        }
        return new Aprational(ApintMath.product(n), ApintMath.product(m));
    }

    /**
     * Sum of numbers.
     * This method may perform significantly better
     * than simply adding the numbers sequentially.<p>
     *
     * If there are no arguments, the return value is <code>0</code>.
     *
     * @param x The argument(s).
     *
     * @return The sum of the given numbers.
     *
     * @since 1.3
     */

    public static Aprational sum(Aprational... x)
        throws ApfloatRuntimeException
    {
        if (x.length == 0)
        {
            return Aprational.ZERO;
        }

        // Sort by size
        x = x.clone();

        Arrays.sort(x, Comparator.comparing(ApfloatHelper::size));

        // Recursively add
        return recursiveSum(x, 0, x.length - 1);
    }

    /**
     * Returns the greater of the two values.
     *
     * @param x An argument.
     * @param y Another argument.
     *
     * @return The greater of the two values.
     *
     * @since 1.9.0
     */

    public static Aprational max(Aprational x, Aprational y)
        throws ApfloatRuntimeException
    {
        return (x.compareTo(y) > 0 ? x : y);
    }

    /**
     * Returns the smaller of the two values.
     *
     * @param x An argument.
     * @param y Another argument.
     *
     * @return The smaller of the two values.
     *
     * @since 1.9.0
     */

    public static Aprational min(Aprational x, Aprational y)
        throws ApfloatRuntimeException
    {
        return (x.compareTo(y) < 0 ? x : y);
    }

    /**
     * Binomial coefficient.
     *
     * @param n The first argument.
     * @param k The second argument.
     *
     * @return <math xmlns="http://www.w3.org/1998/Math/MathML">
     *           <mrow>
     *             <mo>(</mo>
     *               <mfrac linethickness="0">
     *                 <mi>n</mi>
     *                 <mi>k</mi>
     *               </mfrac>
     *             <mo>)</mo>
     *           </mrow>
     *         </math>
     *
     * @throws ArithmeticException If the result is not finite or not a rational number.
     *
     * @since 1.11.0
     */

    public static Aprational binomial(Aprational n, Aprational k)
        throws ArithmeticException, ApfloatRuntimeException
    {
        if (n.isInteger() && k.isInteger())
        {
            return ApintMath.binomial(n.numerator(), k.numerator());
        }
        if (n.isInteger() && n.signum() < 0 && !k.isInteger())
        {
            throw new ArithmeticException("Binomial coefficient is not finite");
        }
        if (!k.isInteger())
        {
            k = n.subtract(k);
        }
        if (!k.isInteger())
        {
            throw new ArithmeticException("Binomial coefficient is not a rational number");
        }
        int radix = n.radix();
        if (k.signum() < 0)
        {
            return Apint.ZEROS[radix];
        }
        Apint one = new Apint(1, radix);
        return pochhammer(n.subtract(k).add(one), k.numerator()).divide(ApintMath.factorial(k.longValueExact(), radix));
    }

    // Product of the numbers n * (n + 1) * (n + 2) * ... * (n + m - 1)
    private static Aprational pochhammer(Aprational n, Apint m)
    {
        assert (m.signum() >= 0);
        Apint one = Apint.ONES[n.radix()];
        if (m.signum() == 0)
        {
            return one;
        }
        if (m.equals(one))
        {
            return n;
        }
        Apint two = new Apint(2, n.radix());
        Apint k = m.divide(two);
        return pochhammer(n, k).multiply(pochhammer(n.add(k), m.subtract(k)));
    }

    /**
     * Returns the specified Bernoulli number. The default radix is used.
     *
     * @param n The argument.
     *
     * @return The Bernoulli number <code>B<sub>n</sub></code>.
     *
     * @throws IllegalArgumentException If <code>n &lt; 0</code>.
     *
     * @since 1.11.0
     */

    public static Aprational bernoulli(long n)
        throws IllegalArgumentException, ApfloatRuntimeException
    {
        ApfloatContext ctx = ApfloatContext.getContext();
        int radix = ctx.getDefaultRadix();

        return bernoulli(n, radix);
    }

    /**
     * Returns the specified Bernoulli number in the given radix.
     * 
     * @param n The argument.
     * @param radix The radix.
     *
     * @return The Bernoulli number <code>B<sub>n</sub></code>.
     *
     * @throws IllegalArgumentException If <code>n &lt; 0</code>.
     * @throws NumberFormatException If the radix is not valid.
     *
     * @since 1.11.0
     */

    public static Aprational bernoulli(long n, int radix)
        throws IllegalArgumentException, NumberFormatException, ApfloatRuntimeException
    {
        if (n < 0)
        {
            throw new IllegalArgumentException("Negative Bernoulli number: " + n);
        }

        if (n == 0)
        {
            return Apint.ONES[radix];
        }
        if (n == 1)
        {
            return new Aprational(new Apint(-1, radix), new Apint(2, radix));
        }
        if ((n & 1) == 1)
        {
            return Apint.ZEROS[radix];
        }
        return (n <= 2000 ? bernoulliSmall(n, radix) : bernoulliBig(n, radix));
    }

    static Aprational bernoulliSmall(long n, int radix)
    {
        assert (n > 0);
        Aprational sum = Aprational.ZERO;
        for (long k = 1; k <= n; k++)
        {
            Apint binomial = new Apint(1, radix);
            Apint part = Apint.ZERO;
            for (long v = 1; v <= k; v++)
            {
                binomial = binomial.multiply(new Apint(k + 1 - v, radix)).divide(new Apint(v, radix));
                Apint term = binomial.multiply(ApintMath.pow(new Apint(v, radix), n));
                part = ((v & 1) == 0 ? part.add(term) : part.subtract(term));
            }
            sum = sum.add(new Aprational(part, new Apint(k + 1, radix)));
        }
        return sum;

        // Alternative algorithm that uses more memory but isn't really much faster:
        //
        //     factorial = factorial.multiply(new Apint(k, radix));
        //     sum = sum.multiply(new Apint(k + 1, radix)).add(part.multiply(factorial));
        // }
        // return new Aprational(sum, ApintMath.factorial(n + 1, radix));
    }

    static Aprational bernoulliBig(long n, int radix)
    {
        // See https://arxiv.org/abs/1108.0286 for the algorithm, Fast computation of Bernoulli, Tangent and Secant numbers by Richard P. Brent, David Harvey
        assert (n > 1);
        assert (n & 1) == 0;
        n >>= 1;

        Apint one = Apint.ONES[radix],
              two = new Apint(2, radix);
        long p = Math.max(1, (long) Math.ceil(n * Math.log(n) / Math.log(radix))),
             precision = ApfloatHelper.extendPrecision(Math.multiplyExact(Math.multiplyExact(2, n) + 1, p));  // 2 * n * p + 2 is not enough!
        Apint f2n1 = ApintMath.factorial(2 * n - 1,  radix);
        Apfloat z = ApfloatMath.scale(new Apfloat(1, precision, radix), -p),
                v = ApfloatMath.scale(f2n1.multiply(ApfloatMath.tan(z)), -p);
        v = ApfloatMath.scale(v, 2 * p * (n - 1));
        v = v.frac();
        v = ApfloatMath.scale(v, 2 * p);
        Apint t = v.truncate();
        Apint two2n1 = ApintMath.pow(two, 2 * n - 1),
              two2n = two2n1.multiply(two);
        Aprational b = new Aprational(new Apint((n & 1) == 1 ? n : -n, radix).multiply(t), two2n.subtract(one).multiply(two2n1));
        return b;
    }

    static Iterator<Aprational> bernoullis(long n, int radix)
    {
        return (n <= 2000 ? bernoullisSmall(radix) : bernoullisBig(n, radix));
    }

    // Returns the even bernoulli numbers B_2n, n > 0
    static Iterator<Aprational> bernoullis2(long n, int radix)
    {
        return (n < 1000 ? bernoullis2Small(radix) : bernoullis2Big(n, radix));
    }

    static Iterator<Aprational> bernoullisSmall(int radix)
    {
        return new Iterator<Aprational>()
        {
            @Override
            public boolean hasNext()
            {
                return true;
            }

            @Override
            public Aprational next()
            {
                Aprational b;
                if (this.n == 0)
                {
                    b = Aprational.ONES[radix];
                }
                else if (this.n > 1 && (this.n & 1) == 1)
                {
                    b = Aprational.ZEROS[radix];
                }
                else
                {
                    b = Aprational.ZEROS[radix];
                    Iterator<Aprational> iterator = this.all.iterator();
                    Apint binomial = null;
                    for (long k = 0; iterator.hasNext(); k++)
                    {
                        binomial = (k == 0 ? new Apint(1, radix) : binomial.multiply(new Apint(n + 1 - k, radix)).divide(new Apint(k, radix)));
                        b = b.subtract(binomial.multiply(iterator.next()).divide(new Apint(n - k + 1, radix)));
                    }
                }
                this.all.add(b);
                this.n++;

                return b;
            }

            private long n;
            private List<Aprational> all = new ArrayList<>();
        };
    }

    // Returns the even bernoulli numbers B_2n, n > 0
    static Iterator<Aprational> bernoullis2Small(int radix)
    {
        return new Iterator<Aprational>()
        {
            @Override
            public boolean hasNext()
            {
                return true;
            }

            @Override
            public Aprational next()
            {
                this.i.next();
                return this.i.next();
            }

            private Iterator<Aprational> i = bernoullisSmall(radix);

            {
                this.i.next();
            }
        };
    }

    static Iterator<Aprational> bernoullisBig(long n, int radix)
    {
        return new Iterator<Aprational>()
        {
            @Override
            public boolean hasNext()
            {
                return this.k <= n;
            }

            @Override
            public Aprational next()
            {
                if (this.k > n)
                {
                    throw new NoSuchElementException();
                }

                Aprational b;
                if (this.k == 0)
                {
                    b = Aprational.ONES[radix];
                }
                else if (this.k == 1)
                {
                    b = new Aprational(new Apint(-1, radix), new Apint(2, radix));
                }
                else if ((this.k & 1) == 1)
                {
                    b = Aprational.ZEROS[radix];
                }
                else
                {
                    b = this.i.next();
                }
                this.k++;

                return b;
            }

            private long k;
            private Iterator<Aprational> i = bernoullis2Big(n >> 1, radix);
        };
    }

    // Returns the even bernoulli numbers B_2n, n > 0
    static Iterator<Aprational> bernoullis2Big(long n, int radix)
    {
        Apint one = Apint.ONES[radix],
              two = new Apint(2, radix);
        long p = (long) Math.ceil(n * Math.log(n) / Math.log(radix)),
             precision = ApfloatHelper.extendPrecision(Math.multiplyExact(Math.multiplyExact(2, n) + 1, p));  // 2 * n * p + 2 is not enough!
        Apint f2n1 = ApintMath.factorial(2 * n - 1,  radix);
        Apfloat z = ApfloatMath.scale(new Apfloat(1, precision, radix), -p);

        return new Iterator<Aprational>()
        {
            @Override
            public boolean hasNext()
            {
                return this.k <= n;
            }

            @Override
            public Aprational next()
            {
                if (this.k > n)
                {
                    throw new NoSuchElementException();
                }

                long k = this.k;
                this.v = ApfloatMath.scale(this.v, 2 * p);
                Apint t1 = this.v.truncate();
                this.f2k1 = (k == 1 ? this.f2k1 : this.f2k1.multiply(new Apint(2 * k - 1, radix)).multiply(new Apint(2 * k - 2, radix)));
                Apint t = t1.multiply(this.f2k1).divide(f2n1);
                this.v = this.v.frac();
                this.two2k = this.two2k1.multiply(two);
                Aprational b = new Aprational(new Apint((k & 1) == 1 ? k : -k, radix).multiply(t), this.two2k.subtract(one).multiply(this.two2k1));
                this.two2k1 = this.two2k.multiply(two);
                this.k++;
                return b;
            }

            private long k = 1;
            private Apfloat v = ApfloatMath.scale(f2n1.multiply(ApfloatMath.tan(z)), -p);
            private Apint f2k1 = one,
                    two2k1 = two,
                    two2k;
        };
    }

    private static Aprational recursiveSum(Aprational[] x, int n, int m)
        throws ApfloatRuntimeException
    {
        if (n == m)
        {
            return x[n];
        }
        else
        {
            int k = (n + m) >>> 1;
            return recursiveSum(x, n, k).add(recursiveSum(x, k + 1, m));
        }
    }
}
