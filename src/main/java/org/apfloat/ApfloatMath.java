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
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.Queue;
import java.util.PriorityQueue;
import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.concurrent.ConcurrentMap;
import java.util.concurrent.ConcurrentHashMap;

import org.apfloat.spi.Util;

/**
 * Various mathematical functions for arbitrary precision floating-point numbers.<p>
 *
 * Due to different types of round-off errors that can occur in the implementation,
 * no guarantees about e.g. monotonicity are given for any of the methods.
 *
 * @see ApintMath
 *
 * @version 1.11.0
 * @author Mikko Tommila
 */

public class ApfloatMath
{
    private ApfloatMath()
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

    public static Apfloat pow(Apfloat x, long n)
        throws ArithmeticException, ApfloatRuntimeException
    {
        if (n == 0)
        {
            if (x.signum() == 0)
            {
                throw new ArithmeticException("Zero to power zero");
            }

            return new Apfloat(1, Apfloat.INFINITE, x.radix());
        }
        else if (n < 0)
        {
            x = inverseRoot(x, 1);
            n = -n;
        }

        long precision = x.precision();
        x = ApfloatHelper.extendPrecision(x);   // Big exponents will accumulate round-off errors

        // Algorithm improvements by Bernd Kellner
        int b2pow = 0;

        while ((n & 1) == 0)
        {
            b2pow++;
            n >>>= 1;
        }

        Apfloat r = x;

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

        return r.precision(precision);
    }

    /**
     * Square root.
     *
     * @param x The argument.
     *
     * @return Square root of <code>x</code>.
     *
     * @exception ArithmeticException If <code>x</code> is negative.
     */

    public static Apfloat sqrt(Apfloat x)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return root(x, 2);
    }

    /**
     * Cube root.
     *
     * @param x The argument.
     *
     * @return Cube root of <code>x</code>.
     */

    public static Apfloat cbrt(Apfloat x)
        throws ApfloatRuntimeException
    {
        return root(x, 3);
    }

    /**
     * Positive integer root.
     *
     * @param x The argument.
     * @param n Which root to take.
     *
     * @return <code>n</code>:th root of <code>x</code>, that is <code>x<sup>1/n</sup></code>.
     *
     * @exception ArithmeticException If <code>n</code> is zero, or <code>x</code> is negative and <code>n</code> is even.
     */

    public static Apfloat root(Apfloat x, long n)
        throws ArithmeticException, ApfloatRuntimeException
    {
        if (n == 0)
        {
            throw new ArithmeticException("Zeroth root");
        }
        else if (x.signum() == 0)
        {
            return Apfloat.ZEROS[x.radix()];    // Avoid division by zero
        }
        else if (n == 1)
        {
            return x;
        }
        else if (n == 0x8000000000000000L)
        {
            return sqrt(inverseRoot(x, n / -2));
        }
        else if (n < 0)
        {
            return inverseRoot(x, -n);
        }
        else if (n == 2)
        {
            return x.multiply(inverseRoot(x, 2));
        }
        else if (n == 3)
        {
            Apfloat y = x.multiply(x);
            return x.multiply(inverseRoot(y, 3));
        }
        else
        {
            Apfloat y = inverseRoot(x, n);
            return inverseRoot(y, 1);
        }
    }

    /**
     * Inverse positive integer root.
     *
     * @param x The argument.
     * @param n Which inverse root to take.
     *
     * @return Inverse <code>n</code>:th root of <code>x</code>, that is <code>x<sup>-1/n</sup></code>.
     *
     * @exception ArithmeticException If <code>x</code> or <code>n</code> is zero, or <code>x</code> is negative and <code>n</code> is even.
     */

    public static Apfloat inverseRoot(Apfloat x, long n)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return inverseRoot(x, n, x.precision());
    }

    /**
     * Inverse positive integer root.
     *
     * @param x The argument.
     * @param n Which inverse root to take.
     * @param targetPrecision Precision of the desired result.
     *
     * @return Inverse <code>n</code>:th root of <code>x</code>, that is <code>x<sup>-1/n</sup></code>.
     *
     * @exception IllegalArgumentException If <code>targetPrecision &lt;= 0</code>.
     * @exception ArithmeticException If <code>x</code> or <code>n</code> is zero, or <code>x</code> is negative and <code>n</code> is even.
     */

    public static Apfloat inverseRoot(Apfloat x, long n, long targetPrecision)
        throws IllegalArgumentException, ArithmeticException, ApfloatRuntimeException
    {
        return inverseRoot(x, n, targetPrecision, null);
    }

    /**
     * Inverse positive integer root.
     *
     * @param x The argument.
     * @param n Which inverse root to take.
     * @param targetPrecision Precision of the desired result.
     * @param initialGuess Initial guess for the result value, or <code>null</code> if none is available.
     *
     * @return Inverse <code>n</code>:th root of <code>x</code>, that is <code>x<sup>-1/n</sup></code>.
     *
     * @exception IllegalArgumentException If <code>targetPrecision &lt;= 0</code>.
     * @exception ArithmeticException If <code>x</code> or <code>n</code> is zero, or <code>x</code> is negative and <code>n</code> is even.
     */

    public static Apfloat inverseRoot(Apfloat x, long n, long targetPrecision, Apfloat initialGuess)
        throws IllegalArgumentException, ArithmeticException, ApfloatRuntimeException
    {
        return inverseRoot(x, n, targetPrecision, initialGuess, initialGuess == null ? 0 : initialGuess.precision());
    }

    /**
     * Inverse positive integer root.<p>
     *
     * This method is the basis for most of apfloat's non-elementary operations.
     * It is used e.g. in {@link Apfloat#divide(Apfloat)}, {@link #sqrt(Apfloat)}
     * and {@link #root(Apfloat,long)}.
     *
     * @param x The argument.
     * @param n Which inverse root to take.
     * @param targetPrecision Precision of the desired result.
     * @param initialGuess Initial guess for the result value, or <code>null</code> if none is available.
     * @param initialPrecision Precision of the initial guess, if available.
     *
     * @return Inverse <code>n</code>:th root of <code>x</code>, that is <code>x<sup>-1/n</sup></code>.
     *
     * @exception IllegalArgumentException If <code>targetPrecision &lt;= 0</code> or <code>initialPrecision &lt;= 0</code>.
     * @exception ArithmeticException If <code>x</code> or <code>n</code> is zero, or <code>x</code> is negative and <code>n</code> is even.
     */

    public static Apfloat inverseRoot(Apfloat x, long n, long targetPrecision, Apfloat initialGuess, long initialPrecision)
        throws IllegalArgumentException, ArithmeticException, ApfloatRuntimeException
    {
        if (x.signum() == 0)
        {
            throw new ArithmeticException("Inverse root of zero");
        }
        else if (n == 0)
        {
            throw new ArithmeticException("Inverse zeroth root");
        }
        else if ((n & 1) == 0 && x.signum() < 0)
        {
            throw new ArithmeticException("Even root of negative number; result would be complex");
        }
        else if (targetPrecision <= 0)
        {
            throw new IllegalArgumentException("Target precision " + targetPrecision + " is not positive");
        }
        else if (x.equals(Apfloat.ONE))
        {
            // Trivial case
            return x.precision(targetPrecision);
        }
        else if (targetPrecision == Apfloat.INFINITE)
        {
            throw new InfiniteExpansionException("Cannot calculate inverse root to infinite precision");
        }
        else if (n == 0x8000000000000000L)
        {
            Apfloat y = inverseRoot(x, n / -2);
            return inverseRoot(y, 2);
        }
        else if (n < 0)
        {
            Apfloat y = inverseRoot(x, -n);
            return inverseRoot(y, 1);
        }

        long precision,
             doublePrecision = ApfloatHelper.getDoublePrecision(x.radix());
        Apfloat one = new Apfloat(1, Apfloat.INFINITE, x.radix()),
                divisor = new Apfloat(n, Apfloat.INFINITE, x.radix()),
                result;

        if (initialGuess == null || initialPrecision < doublePrecision)
        {
            // Calculate initial guess from x
            long scaleQuot = x.scale() / n,
                 scaleRem = x.scale() - scaleQuot * n;

            result = x.precision(doublePrecision);
            result = scale(result, -result.scale());    // Allow scales in exess of doubles'

            precision = doublePrecision;

            result = new Apfloat((double) result.signum() * Math.pow(Math.abs(result.doubleValue()), -1.0 / (double) n) * Math.pow((double) x.radix(), (double) -scaleRem / (double) n), precision, x.radix());
            result = scale(result, -scaleQuot);
        }
        else
        {
            // Take initial guess as given
            result = initialGuess;
            precision = initialPrecision;
        }

        int iterations = 0;

        // Compute total number of iterations
        for (long maxPrec = precision; maxPrec < targetPrecision; maxPrec <<= 1)
        {
            iterations++;
        }

        int precisingIteration = iterations;

        // Check where the precising iteration should be done
        for (long minPrec = precision; precisingIteration > 0; precisingIteration--, minPrec <<= 1)
        {
            if ((minPrec - Apfloat.EXTRA_PRECISION) << precisingIteration >= targetPrecision)
            {
                break;
            }
        }

        x = ApfloatHelper.extendPrecision(x);

        // Newton's iteration
        while (iterations-- > 0)
        {
            precision *= 2;
            result = result.precision(Math.min(precision, targetPrecision));

            Apfloat t = pow(result, n);
            t = lastIterationExtendPrecision(iterations, precisingIteration, t);
            t = one.subtract(x.multiply(t));
            if (iterations < precisingIteration)
            {
                t = t.precision(precision / 2);
            }

            result = lastIterationExtendPrecision(iterations, precisingIteration, result);
            result = result.add(result.multiply(t).divide(divisor));

            // Precising iteration
            if (iterations == precisingIteration)
            {
                t = pow(result, n);
                t = lastIterationExtendPrecision(iterations, -1, t);

                result = lastIterationExtendPrecision(iterations, -1, result);
                result = result.add(result.multiply(one.subtract(x.multiply(t))).divide(divisor));
            }
        }

        return result.precision(targetPrecision);
    }

    /**
     * Floor function. Returns the largest (closest to positive infinity) value
     * that is not greater than the argument and is equal to a mathematical integer.
     *
     * @param x The argument.
     *
     * @return <code>x</code> rounded towards negative infinity.
     */

    public static Apint floor(Apfloat x)
        throws ApfloatRuntimeException
    {
        return x.floor();
    }

    /**
     * Ceiling function. Returns the smallest (closest to negative infinity) value
     * that is not less than the argument and is equal to a mathematical integer.
     *
     * @param x The argument.
     *
     * @return <code>x</code> rounded towards positive infinity.
     */

    public static Apint ceil(Apfloat x)
        throws ApfloatRuntimeException
    {
        return x.ceil();
    }

    /**
     * Truncates fractional part.
     *
     * @param x The argument.
     *
     * @return <code>x</code> rounded towards zero.
     */

    public static Apint truncate(Apfloat x)
        throws ApfloatRuntimeException
    {
        return x.truncate();
    }

    /**
     * Extracts fractional part.
     *
     * @param x The argument.
     *
     * @return The fractional part of <code>x</code>.
     *
     * @since 1.7.0
     */

    public static Apfloat frac(Apfloat x)
        throws ApfloatRuntimeException
    {
        return x.frac();
    }

    /**
     * Rounds the given number to the specified precision with the specified rounding mode.
     *
     * @deprecated Use {@link #roundToPrecision(Apfloat,long,RoundingMode)}.
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
    public static Apfloat round(Apfloat x, long precision, RoundingMode roundingMode)
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

    public static Apfloat roundToPrecision(Apfloat x, long precision, RoundingMode roundingMode)
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

    public static Apint roundToInteger(Apfloat x, RoundingMode roundingMode)
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

    public static Apfloat roundToPlaces(Apfloat x, long places, RoundingMode roundingMode)
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

    public static Apfloat roundToMultiple(Apfloat x, Apfloat y, RoundingMode roundingMode)
        throws IllegalArgumentException, ArithmeticException, ApfloatRuntimeException
    {
        return RoundingHelper.roundToMultiple(x, y, roundingMode);
    }

    /**
     * Returns an apfloat whose value is <code>-x</code>.
     *
     * @deprecated Use {@link Apfloat#negate()}.
     *
     * @param x The argument.
     *
     * @return <code>-x</code>.
     */

    @Deprecated
    public static Apfloat negate(Apfloat x)
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

    public static Apfloat abs(Apfloat x)
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

    public static Apfloat copySign(Apfloat x, Apfloat y)
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
     *
     * @param x The argument.
     * @param scale The scaling factor.
     *
     * @return <code>x * x.radix()<sup>scale</sup></code>.
     */

    public static Apfloat scale(Apfloat x, long scale)
        throws ApfloatRuntimeException
    {
        if (scale == 0 || x.signum() == 0)
        {
            return x;
        }

        Apfloat radix = new Apfloat(x.radix(), Apfloat.INFINITE, x.radix()),
                result;

        if ((Math.abs(scale) & 0xC000000000000000L) != 0)
        {
            // The exponent might overflow in the string or in intermediate calculations
            Apfloat scaler1 = pow(radix, Math.abs(scale) >>> 1),
                    scaler2 = ((scale & 1) == 0 ? scaler1 : scaler1.multiply(radix));
            result = (scale >= 0 ? x.multiply(scaler1).multiply(scaler2) : x.divide(scaler1).divide(scaler2));
        }
        else if (x.radix() <= 14)
        {
            Apfloat scaler = new Apfloat("1e" + scale, Apfloat.INFINITE, x.radix());
            result = x.multiply(scaler);
        }
        else
        {
            // "e" would be interpreted as a digit
            Apfloat scaler = pow(radix, Math.abs(scale));
            result = (scale >= 0 ? x.multiply(scaler) : x.divide(scaler));
        }

        return result;
    }

    /**
     * Split to integer and fractional parts.
     * The integer part is simply <code>i = floor(x)</code>.
     * For the fractional part <code>f</code> the following is always true:<p>
     *
     * <code>0 &lt;= f &lt; 1</code>
     *
     * @param x The argument.
     *
     * @return An array of two apfloats, <code>[i, f]</code>, the first being the integer part and the last being the fractional part.
     */

    public static Apfloat[] modf(Apfloat x)
        throws ApfloatRuntimeException
    {
        Apfloat[] result = new Apfloat[2];

        result[0] = x.floor();
        result[1] = (x.signum() >= 0 ? x.frac() : x.subtract(result[0]));

        return result;
    }

    /**
     * Returns x modulo y.<p>
     *
     * This function calculates the remainder <code>f</code> of <code>x / y</code>
     * such that <code>x = i * y + f</code>, where <code>i</code> is an integer,
     * <code>f</code> has the same sign as <code>x</code>,
     * and the absolute value of <code>f</code> is less than the absolute value of <code>y</code>.<p>
     *
     * If <code>y</code> is zero, then zero is returned.
     *
     * @param x The dividend.
     * @param y The divisor.
     *
     * @return The remainder when x is divided by y.
     */

    public static Apfloat fmod(Apfloat x, Apfloat y)
        throws ApfloatRuntimeException
    {
        if (y.signum() == 0)
        {
            return y;                           // By definition
        }
        else if (x.signum() == 0)
        {
            // 0 % x = 0
            return x;
        }

        long precision;
        Apfloat t, a, b, tx, ty;

        a = abs(x);
        b = abs(y);

        if (a.compareTo(b) < 0)
        {
            return x;                           // abs(x) < abs(y)
        }
        long scaleDiff = x.scale() - y.scale();                                 // We now know that x.scale() >= y.scale()
        scaleDiff = (scaleDiff < 0 ? Apfloat.INFINITE : scaleDiff);             // Check for overflow
        if (x.precision() <= scaleDiff)                                         // We now know that scaleDiff >= 0
        {
            return Apfloat.ZEROS[x.radix()];    // Degenerate case; not enough precision to make any sense
        }
        else
        {
            precision = ApfloatHelper.extendPrecision(scaleDiff);               // Some extra precision to avoid round-off errors
        }

        tx = x.precision(precision);
        ty = y.precision(precision);

        t = tx.divide(ty).truncate();           // Approximate division

        precision = Math.min(Util.ifFinite(y.precision(), y.precision() + x.scale() - y.scale()), x.precision());

        tx = x.precision(precision);
        ty = y.precision(precision);

        a = abs(tx).subtract(abs(t.multiply(ty)));
        b = abs(ty);

        if (a.compareTo(b) >= 0)                // Fix division round-off error
        {
            a = a.subtract(b);
        }
        else if (a.signum() < 0)                // Fix division round-off error
        {
            a = a.add(b);
        }

        t = copySign(a, x);

        return t;
    }

    /**
     * Fused multiply-add. Calculates <code>a * b + c * d</code>
     * so that the precision used in the multiplications is only
     * what is needed for the end result. Performance can this way
     * be better than by calculating <code>a.multiply(b).add(c.multiply(d))</code>.
     *
     * @param a First argument.
     * @param b Second argument.
     * @param c Third argument.
     * @param d Fourth argument.
     *
     * @return <code>a * b + c * d</code>.
     */

    public static Apfloat multiplyAdd(Apfloat a, Apfloat b, Apfloat c, Apfloat d)
        throws ApfloatRuntimeException
    {
        return multiplyAddOrSubtract(a, b, c, d, false);
    }

    /**
     * Fused multiply-subtract. Calculates <code>a * b - c * d</code>
     * so that the precision used in the multiplications is only
     * what is needed for the end result. Performance can this way
     * be better than by calculating <code>a.multiply(b).subtract(c.multiply(d))</code>.
     *
     * @param a First argument.
     * @param b Second argument.
     * @param c Third argument.
     * @param d Fourth argument.
     *
     * @return <code>a * b - c * d</code>.
     */

    public static Apfloat multiplySubtract(Apfloat a, Apfloat b, Apfloat c, Apfloat d)
        throws ApfloatRuntimeException
    {
        return multiplyAddOrSubtract(a, b, c, d, true);
    }

    private static Apfloat multiplyAddOrSubtract(Apfloat a, Apfloat b, Apfloat c, Apfloat d, boolean subtract)
        throws ApfloatRuntimeException
    {
        long[] precisions;
        Apfloat ab, cd;

        precisions = ApfloatHelper.getMatchingPrecisions(a, b, c, d);
        if (precisions[0] == 0)
        {
            ab = Apfloat.ZEROS[a.radix()];
        }
        else
        {
            a = a.precision(precisions[0]);
            b = b.precision(precisions[0]);
            ab = a.multiply(b);
        }
        if (precisions[1] == 0)
        {
            cd = Apfloat.ZEROS[c.radix()];
        }
        else
        {
            c = c.precision(precisions[1]);
            d = d.precision(precisions[1]);
            cd = c.multiply(d);
        }

        Apfloat result = (subtract ? ab.subtract(cd) : ab.add(cd));

        return (result.signum() == 0 ? result : result.precision(precisions[2]));
    }

    /**
     * Arithmetic-geometric mean.
     *
     * @param a First argument.
     * @param b Second argument.
     *
     * @return Arithmetic-geometric mean of a and b.
     */

    public static Apfloat agm(Apfloat a, Apfloat b)
        throws ApfloatRuntimeException
    {
        if (a.signum() == 0 || b.signum() == 0)         // Would not converge quadratically
        {
            return Apfloat.ZEROS[a.radix()];
        }

        if (abs(a).equals(abs(b)))                      // Would not converge quadratically
        {
            return a.signum() == b.signum() ? a.precision(Math.min(a.precision(), b.precision())) : Apfloat.ZEROS[a.radix()];
        }

        if (a.signum() != b.signum())
        {
            throw new ArithmeticException("Non-real result");
        }

        boolean negate = a.signum() < 0;                // Thanks to Marko Gaspersic for finding several bugs in issue #12
        if (negate)
        {
            a = a.negate();
            b = b.negate();
        }

        long workingPrecision = Math.min(a.precision(), b.precision()),
             targetPrecision = workingPrecision;

        if (workingPrecision == Apfloat.INFINITE)
        {
            throw new InfiniteExpansionException("Cannot calculate agm to infinite precision");
        }

        // Some extra precision is required for the algorithm to work accurately
        workingPrecision = ApfloatHelper.extendPrecision(workingPrecision);
        a = ApfloatHelper.ensurePrecision(a, workingPrecision);
        b = ApfloatHelper.ensurePrecision(b, workingPrecision);

        long precision = 0,
             halfWorkingPrecision = (workingPrecision + 1) / 2;
        final long CONVERGING = 1000;           // Arbitrarily chosen value...
        Apfloat two = new Apfloat(2, Apfloat.INFINITE, a.radix());

        // First check convergence
        while (precision < CONVERGING && precision < halfWorkingPrecision)
        {
            Apfloat t = a.add(b).divide(two);
            b = sqrt(a.multiply(b));
            a = t;

            // Conserve precision in case of accumulating round-off errors
            a = ApfloatHelper.ensurePrecision(a, workingPrecision);
            b = ApfloatHelper.ensurePrecision(b, workingPrecision);

            precision = a.equalDigits(b);
        }

        // Now we know quadratic convergence
        while (precision <= halfWorkingPrecision)
        {
            Apfloat t = a.add(b).divide(two);
            b = sqrt(a.multiply(b));
            a = t;

            // Conserve precision in case of accumulating round-off errors
            a = ApfloatHelper.ensurePrecision(a, workingPrecision);
            b = ApfloatHelper.ensurePrecision(b, workingPrecision);

            precision *= 2;
        }

        Apfloat result = a.add(b).divide(two).precision(targetPrecision);
        return (negate ? result.negate() : result);
    }

    /**
     * Calculates &pi;. Uses default radix.
     *
     * @param precision Number of digits of &pi; to calculate.
     *
     * @return &pi; accurate to <code>precision</code> digits, in the default radix.
     *
     * @exception NumberFormatException If the default radix is not valid.
     * @exception IllegalArgumentException In case the precision is invalid.
     */

    public static Apfloat pi(long precision)
        throws IllegalArgumentException, NumberFormatException, ApfloatRuntimeException
    {
        ApfloatContext ctx = ApfloatContext.getContext();
        int radix = ctx.getDefaultRadix();

        return pi(precision, radix);
    }

    /**
     * Calculates &pi;.
     *
     * @param precision Number of digits of &pi; to calculate.
     * @param radix The radix in which the number should be presented.
     *
     * @return &pi; accurate to <code>precision</code> digits, in base <code>radix</code>.
     *
     * @exception NumberFormatException If the radix is not valid.
     * @exception IllegalArgumentException In case the precision is invalid.
     */

    public static Apfloat pi(long precision, int radix)
        throws IllegalArgumentException, NumberFormatException, ApfloatRuntimeException
    {
        if (precision <= 0)
        {
            throw new IllegalArgumentException("Precision " + precision + " is not positive");
        }
        else if (precision == Apfloat.INFINITE)
        {
            throw new InfiniteExpansionException("Cannot calculate pi to infinite precision");
        }

        // Get synchronization lock - getting the lock is also synchronized
        Object radixKey = getRadixKey(ApfloatMath.radixPiKeys, radix);

        Apfloat pi;

        // Synchronize getting pre-calculated pi by radix key
        // - two threads won't try to calculate it at the same time
        // - doesn't block getting it for other radixes
        synchronized (radixKey)
        {
            pi = ApfloatMath.radixPi.get(radix);

            if (pi == null || pi.precision() < precision)
            {
                pi = calculatePi(precision, radix);
            }
            else
            {
                pi = pi.precision(precision);
            }
        }

        return pi;
    }

    /**
     * Simple JavaBean to hold one apfloat. This class can
     * also be thought of as a pointer to an apfloat.
     */

    static class ApfloatHolder
    {
        public ApfloatHolder()
        {
            this(null);
        }

        public ApfloatHolder(Apfloat apfloat)
        {
            this.apfloat = apfloat;
        }

        public Apfloat getApfloat()
        {
            return this.apfloat;
        }

        public void setApfloat(Apfloat apfloat)
        {
            this.apfloat = apfloat;
        }

        private Apfloat apfloat;
    }

    private static class PiCalculator
    {
        public PiCalculator(int radix)
            throws ApfloatRuntimeException
        {
            this.A = new Apfloat(13591409, Apfloat.INFINITE, radix);
            this.B = new Apfloat(545140134, Apfloat.INFINITE, radix);
            this.J = new Apfloat(10939058860032000L, Apfloat.INFINITE, radix);
            this.ONE = new Apfloat(1, Apfloat.INFINITE, radix);
            this.TWO = new Apfloat(2, Apfloat.INFINITE, radix);
            this.FIVE = new Apfloat(5, Apfloat.INFINITE, radix);
            this.SIX = new Apfloat(6, Apfloat.INFINITE, radix);
            this.radix = radix;
        }

        private Apfloat a(long n)
            throws ApfloatRuntimeException
        {
            Apfloat s = new Apfloat(n, Apfloat.INFINITE, this.radix),
                    v = this.A.add(this.B.multiply(s));

            v = ((n & 1) == 0 ? v : v.negate());

            return v;
        }

        private Apfloat p(long n)
            throws ApfloatRuntimeException
        {
            Apfloat v;

            if (n == 0)
            {
                v = this.ONE;
            }
            else
            {
                Apfloat f = new Apfloat(n, Apfloat.INFINITE, this.radix),
                        sixf = this.SIX.multiply(f);

                v = sixf.subtract(this.ONE).multiply(this.TWO.multiply(f).subtract(this.ONE)).multiply(sixf.subtract(this.FIVE));
            }

            return v;
        }

        private Apfloat q(long n)
            throws ApfloatRuntimeException
        {
            Apfloat v;

            if (n == 0)
            {
                v = this.ONE;
            }
            else
            {
                Apfloat f = new Apfloat(n, Apfloat.INFINITE, this.radix);

                v = this.J.multiply(f).multiply(f).multiply(f);
            }

            return v;
        }

        public void r(long n1, long n2, ApfloatHolder T, ApfloatHolder Q, ApfloatHolder P)
            throws ApfloatRuntimeException
        {
            assert (n1 != n2);
            long length = n2 - n1;

            if (length == 1)
            {
                Apfloat p0 = p(n1);

                T.setApfloat(a(n1).multiply(p0));
                Q.setApfloat(q(n1));
                P.setApfloat(p0);
            }
            else
            {
                long nMiddle = (n1 + n2) / 2;
                ApfloatHolder LT = new ApfloatHolder(),
                              LQ = new ApfloatHolder(),
                              LP = new ApfloatHolder();

                r(n1, nMiddle, LT, LQ, LP);
                r(nMiddle, n2, T, Q, P);

                T.setApfloat(Q.getApfloat().multiply(LT.getApfloat()).add(LP.getApfloat().multiply(T.getApfloat())));
                Q.setApfloat(LQ.getApfloat().multiply(Q.getApfloat()));
                P.setApfloat(LP.getApfloat().multiply(P.getApfloat()));
            }
        }

        private final Apfloat A;
        private final Apfloat B;
        private final Apfloat J;
        private final Apfloat ONE;
        private final Apfloat TWO;
        private final Apfloat FIVE;
        private final Apfloat SIX;
        private int radix;
    }

    // Perform actual calculation of pi for radix, and store the result to pre-calulation maps.
    // Uses the Chudnovskys' binary splitting algorithm.
    // Uses previously calculated terms (if such exist) to improve the precision of the calculation.
    private static Apfloat calculatePi(long precision, int radix)
        throws ApfloatRuntimeException
    {
        PiCalculator piCalculator = ApfloatMath.radixPiCalculator.get(radix);
        if (piCalculator == null)
        {
            piCalculator = new PiCalculator(radix);
            ApfloatMath.radixPiCalculator.put(radix, piCalculator);
        }

        Apfloat LT,
                LQ,
                LP,
                inverseRoot;

        ApfloatHolder RT = new ApfloatHolder(),
                      RQ = new ApfloatHolder(),
                      RP = new ApfloatHolder();

        // Perform the calculation of T, Q and P to infinite precision
        // to make possible to use them later for further calculations

        long neededTerms = (long) ((double) precision * Math.log((double) radix) / 32.65445004177),
             workingPrecision = ApfloatHelper.extendPrecision(precision);   // To avoid cumulative round-off errors

        Long terms = ApfloatMath.radixPiTerms.get(radix);
        LT = ApfloatMath.radixPiT.get(radix);
        LQ = ApfloatMath.radixPiQ.get(radix);
        LP = ApfloatMath.radixPiP.get(radix);
        inverseRoot = ApfloatMath.radixPiInverseRoot.get(radix);

        if (terms != null && LT != null && LQ != null && LP != null && inverseRoot != null)
        {
            // Some terms have been calculated already previously and cached
            long currentTerms = terms;

            // Check if there actually are more needed terms or if the needed
            // extra precision is just a few digits achievable with current terms
            if (currentTerms != neededTerms + 1)
            {
                piCalculator.r(currentTerms, neededTerms + 1, RT, RQ, RP);

                LT = RQ.getApfloat().multiply(LT).add(LP.multiply(RT.getApfloat()));
                LQ = LQ.multiply(RQ.getApfloat());
                LP = LP.multiply(RP.getApfloat());
            }

            // Improve the inverse root value from the current precision
            inverseRoot = inverseRoot(new Apfloat(1823176476672000L, workingPrecision, radix), 2, workingPrecision, inverseRoot);
        }
        else
        {
            piCalculator.r(0, neededTerms + 1, RT, RQ, RP);

            LT = RT.getApfloat();
            LQ = RQ.getApfloat();
            LP = RP.getApfloat();

            inverseRoot = inverseRoot(new Apfloat(1823176476672000L, workingPrecision, radix), 2);
        }

        Apfloat pi = inverseRoot(inverseRoot.multiply(LT), 1).multiply(LQ);

        // Limit precisions to actual after extended working precisions
        inverseRoot = inverseRoot.precision(precision);
        pi = pi.precision(precision);

        // Put the updated values to the caches
        ApfloatMath.radixPiT.put(radix, LT);
        ApfloatMath.radixPiQ.put(radix, LQ);
        ApfloatMath.radixPiP.put(radix, LP);
        ApfloatMath.radixPiInverseRoot.put(radix, inverseRoot);
        ApfloatMath.radixPiTerms.put(radix, neededTerms + 1);
        ApfloatMath.radixPi.put(radix, pi);

        return pi;
    }

    /**
     * Natural logarithm.<p>
     *
     * The logarithm is calculated using the arithmetic-geometric mean.
     * See the Borweins' book for the formula.
     *
     * @param x The argument.
     *
     * @return Natural logarithm of <code>x</code>.
     *
     * @exception ArithmeticException If <code>x &lt;= 0</code>.
     */

    public static Apfloat log(Apfloat x)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return log(x, true);
    }

    /**
     * Logarithm in arbitrary base.<p>
     *
     * The logarithm is calculated using the arithmetic-geometric mean.
     * See the Borweins' book for the formula.
     *
     * @param x The argument.
     * @param b The base.
     *
     * @return Base-<code>b</code> logarithm of <code>x</code>.
     *
     * @exception ArithmeticException If <code>x &lt;= 0</code> or <code>b &lt;= 0</code>.
     *
     * @since 1.6
     */

    public static Apfloat log(Apfloat x, Apfloat b)
        throws ArithmeticException, ApfloatRuntimeException
    {
        long targetPrecision = Math.min(x.precision(), b.precision());

        Apfloat one = new Apfloat(1, Apfloat.INFINITE, x.radix());
        long xPrecision = Util.ifFinite(targetPrecision, targetPrecision + one.equalDigits(x)); // If the log() argument is close to 1, the result is less accurate
        x = x.precision(Math.min(x.precision(), xPrecision));

        long bPrecision = Util.ifFinite(targetPrecision, targetPrecision + one.equalDigits(b));
        b = b.precision(Math.min(b.precision(), bPrecision));

        return log(x, false).divide(log(b, false));
    }

    private static Apfloat log(Apfloat x, boolean multiplyByPi)
        throws ArithmeticException, ApfloatRuntimeException
    {
        if (x.signum() <= 0)
        {
            throw new ArithmeticException("Logarithm of " + (x.signum() == 0 ? "zero" : "negative number; result would be complex"));
        }
        else if (x.equals(Apfloat.ONE))
        {
            return Apfloat.ZEROS[x.radix()];
        }

        // Calculate the log using 1 / radix <= x < 1 and the log addition formula
        // because the agm converges badly for big x.

        long targetPrecision = x.precision();
        Apfloat one = new Apfloat(1, Apfloat.INFINITE, x.radix());
        long finalPrecision = Util.ifFinite(targetPrecision, targetPrecision - one.equalDigits(x));     // If the argument is close to 1, the result is less accurate
        if (x.scale() > 1)
        {
            double logScale = Math.log((double) x.scale() - 1) / Math.log((double) x.radix());
            logScale += Math.ulp(logScale);
            finalPrecision = Util.ifFinite(finalPrecision, finalPrecision + (long) logScale);           // If the argument is very big, the result is more accurate
        }

        long originalScale = x.scale();

        x = scale(x, -originalScale);   // Set x's scale to zero

        Apfloat radixPower;
        if (originalScale == 0)
        {
            radixPower = Apfloat.ZERO;
        }
        else
        {
            Apfloat logRadix = ApfloatHelper.extendPrecision(logRadix(targetPrecision, x.radix(), multiplyByPi));
            radixPower = new Apfloat(originalScale, Apfloat.INFINITE, x.radix()).multiply(logRadix);
        }

        return ApfloatHelper.extendPrecision(rawLog(x, multiplyByPi)).add(radixPower).precision(finalPrecision);
    }

    // Raw logarithm, regardless of x
    // Doesn't work for big x, but is faster if used alone for small numbers
    private static Apfloat rawLog(Apfloat x, boolean multiplyByPi)
        throws ApfloatRuntimeException
    {
        assert (x.signum() > 0);                                        // Must be real logarithm

        long targetPrecision = x.precision();

        if (targetPrecision == Apfloat.INFINITE)
        {
            throw new InfiniteExpansionException("Cannot calculate logarithm to infinite precision");
        }

        Apfloat one = new Apfloat(1, Apfloat.INFINITE, x.radix());

        final int EXTRA_PRECISION = 25;

        long workingPrecision = ApfloatHelper.extendPrecision(targetPrecision),
             n = targetPrecision / 2 + EXTRA_PRECISION;                 // Very rough estimate

        x = ApfloatHelper.extendPrecision(x, EXTRA_PRECISION);

        Apfloat e = one.precision(workingPrecision);
        e = scale(e, -n);
        x = scale(x, -n);

        Apfloat agme = ApfloatHelper.extendPrecision(agm(one, e)),
                agmex = ApfloatHelper.extendPrecision(agm(one, x));

        Apfloat log = agmex.subtract(agme).precision(workingPrecision);
        if (multiplyByPi)
        {
            Apfloat pi = ApfloatHelper.extendPrecision(pi(targetPrecision, x.radix()));
            log = pi.multiply(log);
        }
        log = log.divide(new Apfloat(2, Apfloat.INFINITE, x.radix()).multiply(agme).multiply(agmex));

        return log.precision(targetPrecision);
    }

    /**
     * Gets or calculates logarithm of a radix to required precision.
     * The calculated value is stored in a cache for later usage.
     *
     * @param precision The needed precision.
     * @param radix The radix.
     *
     * @return Natural logarithm of <code>radix</code> to the specified precision.
     *
     * @exception NumberFormatException If the radix is invalid.
     */

    public static Apfloat logRadix(long precision, int radix)
        throws ApfloatRuntimeException
    {
        return logRadix(precision, radix, true);
    }

    private static Apfloat logRadix(long precision, int radix, boolean multiplyByPi)
        throws ApfloatRuntimeException
    {
        // Get synchronization lock - getting the lock is also synchronized
        Object radixKey = getRadixKey(ApfloatMath.radixLogKeys, radix);

        Apfloat logRadix;

        // Synchronize getting pre-calculated log by radix key
        // - two threads won't try to calculate it at the same time
        // - doesn't block getting it for other radixes
        synchronized (radixKey)
        {
            Map<Integer, Apfloat> cache = (multiplyByPi ? ApfloatMath.radixLogPi : ApfloatMath.radixLog);     // Which cache to use, the one multiplied by pi or not
            logRadix = cache.get(radix);

            if (logRadix == null || logRadix.precision() < precision)
            {
                if (multiplyByPi)
                {
                    // We want the multiplied-by-pi version so get first the not-multiplied-by-pi version
                    logRadix = ApfloatHelper.extendPrecision(logRadix(precision, radix, false));
                    Apfloat pi = ApfloatHelper.extendPrecision(pi(precision, radix));
                    logRadix = logRadix.multiply(pi).precision(precision);
                }
                else
                {
                    Apfloat f = new Apfloat("0.1", precision, radix);

                    logRadix = rawLog(f, multiplyByPi).negate();
                }

                cache.put(radix, logRadix);
            }
            else
            {
                logRadix = logRadix.precision(precision);
            }
        }

        return logRadix;
    }

    /**
     * Exponent function.
     * Calculated using Newton's iteration for the inverse of logarithm.
     *
     * @param x The argument.
     *
     * @return <code>e<sup>x</sup></code>.
     */

    public static Apfloat exp(Apfloat x)
        throws ApfloatRuntimeException
    {
        int radix = x.radix();

        if (x.signum() == 0)
        {
            return new Apfloat(1, Apfloat.INFINITE, radix);
        }

        long targetPrecision = x.precision(),
             precision,
             doublePrecision = ApfloatHelper.getDoublePrecision(radix);

        // If the argument is close to 0, the result is more accurate
        if (x.scale() < 1)
        {
            targetPrecision = Util.ifFinite(targetPrecision, targetPrecision + 1 - x.scale());
        }
        // If the argument is very big, the result is less accurate
        long finalPrecision = targetPrecision;
        if (x.scale() > 1)
        {
            if (x.scale() - 1 >= targetPrecision)
            {
                throw new LossOfPrecisionException("Complete loss of accurate digits");
            }
            finalPrecision = Util.ifFinite(targetPrecision, targetPrecision - (x.scale() - 1));
        }

        if (targetPrecision == Apfloat.INFINITE)
        {
            throw new InfiniteExpansionException("Cannot calculate exponent to infinite precision");
        }
        else if (x.compareTo(new Apfloat((double) Long.MAX_VALUE * Math.log((double) radix), doublePrecision, radix)) >= 0)
        {
            throw new OverflowException("Overflow");
        }
        else if (x.compareTo(new Apfloat((double) Long.MIN_VALUE * Math.log((double) radix), doublePrecision, radix)) <= 0)
        {
            // Underflow

            return Apfloat.ZEROS[radix];
        }
        else if (x.scale() <= Long.MIN_VALUE / 2 + Apfloat.EXTRA_PRECISION)
        {
            // Taylor series: exp(x) = 1 + x + x^2/2 + ...

            return new Apfloat(1, Apfloat.INFINITE, radix).add(x).precision(Apfloat.INFINITE);
        }

        Apfloat result;

        if (x.scale() < -doublePrecision / 2)
        {
            // Taylor series: exp(x) = 1 + x + x^2/2 + ...

            precision = -2 * x.scale();
            result = new Apfloat(1, precision, radix).add(x);
        }
        else
        {
            // Approximate starting value for iteration

            // An overflow or underflow should not occur
            long scaledXPrecision = Math.max(0, x.scale()) + doublePrecision;
            Apfloat logRadix = log(new Apfloat((double) radix, scaledXPrecision, radix)),
                    scaledX = x.precision(scaledXPrecision).divide(logRadix),
                    integerPart = scaledX.truncate(),
                    fractionalPart = scaledX.frac();

            result = new Apfloat(Math.pow((double) radix, fractionalPart.doubleValue()), doublePrecision, radix);
            result = scale(result, integerPart.longValue());

            if (result.signum() == 0)
            {
                // Underflow
                return Apfloat.ZEROS[radix];
            }

            precision = doublePrecision;
        }

        int iterations = 0;

        // Compute total number of iterations
        for (long maxPrec = precision; maxPrec < targetPrecision; maxPrec <<= 1)
        {
            iterations++;
        }

        int precisingIteration = iterations;

        // Check where the precising iteration should be done
        for (long minPrec = precision; precisingIteration > 0; precisingIteration--, minPrec <<= 1)
        {
            if ((minPrec - Apfloat.EXTRA_PRECISION) << precisingIteration >= targetPrecision)
            {
                break;
            }
        }

        if (iterations > 0)
        {
            // Precalculate the needed values once to the required precision
            logRadix(targetPrecision, radix);
        }

        x = ApfloatHelper.extendPrecision(x);

        // Newton's iteration
        while (iterations-- > 0)
        {
            precision *= 2;
            result = result.precision(Math.min(precision, targetPrecision));

            Apfloat t = log(result);
            t = lastIterationExtendPrecision(iterations, precisingIteration, t);
            t = x.subtract(t);

            if (iterations < precisingIteration)
            {
                t = t.precision(precision / 2);
            }

            result = lastIterationExtendPrecision(iterations, precisingIteration, result);
            result = result.add(result.multiply(t));

            // Precising iteration
            if (iterations == precisingIteration)
            {
                t = log(result);
                t = lastIterationExtendPrecision(iterations, -1, t);

                result = lastIterationExtendPrecision(iterations, -1, result);
                result = result.add(result.multiply(x.subtract(t)));
            }
        }

        return result.precision(finalPrecision);
    }

    /**
     * Arbitrary power. Calculated using <code>log()</code> and <code>exp()</code>.
     *
     * @param x The base.
     * @param y The exponent.
     *
     * @return <code>x<sup>y</sup></code>.
     *
     * @exception ArithmeticException If both <code>x</code> and <code>y</code> are zero, or <code>x</code> is negative and <code>y</code> is not an integer.
     */

    public static Apfloat pow(Apfloat x, Apfloat y)
        throws ArithmeticException, ApfloatRuntimeException
    {
        long targetPrecision = Math.min(x.precision(), y.precision());

        Apfloat result = ApfloatHelper.checkPow(x, y, targetPrecision);
        if (result != null)
        {
            return result;
        }
        else if (x.signum() < 0 && y.isInteger())
        {
            return ApcomplexMath.pow(x, y).real();
        }

        // Try to precalculate the needed values just once to the required precision,
        // this may not work too efficiently if x is close to 1 or y is close to zero
        logRadix(targetPrecision, x.radix());

        // Limits precision for log() but may be sub-optimal; precision could be limited more
        Apfloat one = new Apfloat(1, Apfloat.INFINITE, x.radix());
        targetPrecision = Util.ifFinite(targetPrecision, targetPrecision + one.equalDigits(x)); // If the log() argument is close to 1, the result is less accurate
        x = x.precision(Math.min(x.precision(), targetPrecision));

        result = log(x);
        long intermediatePrecision = Math.min(y.precision(), result.precision());
        result = ApfloatHelper.extendPrecision(result);
        result = ApfloatHelper.extendPrecision(y).multiply(result);
        result = exp(result.precision(intermediatePrecision));

        return result;
    }

    /**
     * Inverse hyperbolic cosine. Calculated using <code>log()</code>.
     *
     * @param x The argument.
     *
     * @return Inverse hyperbolic cosine of <code>x</code>.
     *
     * @exception ArithmeticException If <code>x &lt; 1</code>.
     */

    public static Apfloat acosh(Apfloat x)
        throws ArithmeticException, ApfloatRuntimeException
    {
        Apfloat one = new Apfloat(1, Apfloat.INFINITE, x.radix());

        return log(x.add(sqrt(x.multiply(x).subtract(one))));
    }

    /**
     * Inverse hyperbolic sine. Calculated using <code>log()</code>.
     *
     * @param x The argument.
     *
     * @return Inverse hyperbolic sine of <code>x</code>.
     */

    public static Apfloat asinh(Apfloat x)
        throws ApfloatRuntimeException
    {
        Apfloat one = new Apfloat(1, Apfloat.INFINITE, x.radix());

        if (x.signum() >= 0)
        {
            return log(sqrt(x.multiply(x).add(one)).add(x));
        }
        else
        {
            return log(sqrt(x.multiply(x).add(one)).subtract(x)).negate();
        }
    }

    /**
     * Inverse hyperbolic tangent. Calculated using <code>log()</code>.
     *
     * @param x The argument.
     *
     * @return Inverse hyperbolic tangent of <code>x</code>.
     *
     * @exception ArithmeticException If <code>abs(x) &gt;= 1</code>.
     */

    public static Apfloat atanh(Apfloat x)
        throws ArithmeticException, ApfloatRuntimeException
    {
        Apfloat one = new Apfloat(1, Apfloat.INFINITE, x.radix()),
                two = new Apfloat(2, Apfloat.INFINITE, x.radix());

        return log(one.add(x).divide(one.subtract(x))).divide(two);
    }

    /**
     * Hyperbolic cosine. Calculated using <code>exp()</code>.
     *
     * @param x The argument.
     *
     * @return Hyperbolic cosine of <code>x</code>.
     */

    public static Apfloat cosh(Apfloat x)
        throws ApfloatRuntimeException
    {
        Apfloat y = exp(x),
                one = new Apfloat(1, Apfloat.INFINITE, x.radix()),
                two = new Apfloat(2, Apfloat.INFINITE, x.radix());

        return y.add(one.divide(y)).divide(two);
    }

    /**
     * Hyperbolic sine. Calculated using <code>exp()</code>.
     *
     * @param x The argument.
     *
     * @return Hyperbolic sine of <code>x</code>.
     */

    public static Apfloat sinh(Apfloat x)
        throws ApfloatRuntimeException
    {
        Apfloat y = exp(x),
                one = new Apfloat(1, Apfloat.INFINITE, x.radix()),
                two = new Apfloat(2, Apfloat.INFINITE, x.radix());

        return y.subtract(one.divide(y)).divide(two);
    }

    /**
     * Hyperbolic tangent. Calculated using <code>exp()</code>.
     *
     * @param x The argument.
     *
     * @return Hyperbolic tangent of <code>x</code>.
     */

    public static Apfloat tanh(Apfloat x)
        throws ApfloatRuntimeException
    {
        return tanh(x, x.signum() > 0);
    }

    static Apfloat tanhFixedPrecision(Apfloat x)
        throws ApfloatRuntimeException
    {
        return tanh(x, x.signum() < 0);
    }

    private static Apfloat tanh(Apfloat x, boolean negate)
        throws ApfloatRuntimeException
    {
        x = (negate ? x.negate() : x);

        Apfloat one = new Apfloat(1, Apfloat.INFINITE, x.radix()),
                two = new Apfloat(2, Apfloat.INFINITE, x.radix()),
                y = exp(two.multiply(x));

        y = y.subtract(one).divide(y.add(one));

        return (negate ? y.negate() : y);
    }

    /**
     * Inverse cosine. Calculated using complex functions.
     *
     * @param x The argument.
     *
     * @return Inverse cosine of <code>x</code>.
     *
     * @exception ArithmeticException If <code>abs(x) &gt; 1</code>.
     */

    public static Apfloat acos(Apfloat x)
        throws ArithmeticException, ApfloatRuntimeException
    {
        Apfloat one = new Apfloat(1, Apfloat.INFINITE, x.radix());
        Apcomplex i = new Apcomplex(Apfloat.ZERO, one);

        return ApcomplexMath.log(x.add(i.multiply(sqrt(one.subtract(x.multiply(x)))))).imag();
    }

    /**
     * Inverse sine. Calculated using complex functions.
     *
     * @param x The argument.
     *
     * @return Inverse sine of <code>x</code>.
     *
     * @exception ArithmeticException If <code>abs(x) &gt; 1</code>.
     */

    public static Apfloat asin(Apfloat x)
        throws ArithmeticException, ApfloatRuntimeException
    {
        Apfloat one = new Apfloat(1, Apfloat.INFINITE, x.radix());
        Apcomplex i = new Apcomplex(Apfloat.ZERO, one);

        return ApcomplexMath.log(sqrt(one.subtract(x.multiply(x))).subtract(i.multiply(x))).imag().negate();
    }

    /**
     * Inverse tangent. Calculated using complex functions.
     *
     * @param x The argument.
     *
     * @return Inverse tangent of <code>x</code>.
     */

    public static Apfloat atan(Apfloat x)
        throws ApfloatRuntimeException
    {
        Apfloat one = new Apfloat(1, Apfloat.INFINITE, x.radix()),
                two = new Apfloat(2, Apfloat.INFINITE, x.radix());
        Apcomplex i = new Apcomplex(Apfloat.ZERO, one);

        return ApcomplexMath.log(i.subtract(x).divide(i.add(x))).imag().divide(two);
    }

    /**
     * Converts cartesian coordinates to polar coordinates. Calculated using complex functions.<p>
     *
     * Computes the phase angle by computing an arc tangent of <code>y/x</code> in the range of -&pi; &lt; angle &lt;= &pi;.
     *
     * @param y The argument.
     * @param x The argument.
     *
     * @return The angle of the point <code>(x, y)</code> in the plane.
     *
     * @exception ArithmeticException If <code>y</code> and <code>x</code> are both zero.
     */

    public static Apfloat atan2(Apfloat y, Apfloat x)
        throws ArithmeticException, ApfloatRuntimeException
    {
        if (x.signum() == 0)
        {
            if (y.signum() == 0)
            {
                throw new ArithmeticException("Angle of (0, 0)");
            }

            Apfloat pi = pi(y.precision(), y.radix()),
                    two = new Apfloat(2, Apfloat.INFINITE, y.radix());

            return new Apfloat(y.signum(), Apfloat.INFINITE, y.radix()).multiply(pi).divide(two);
        }
        else if (y.signum() == 0)
        {
            if (x.signum() > 0)
            {
                return Apfloat.ZEROS[x.radix()];
            }

            return pi(x.precision(), x.radix());
        }
        else if (Math.min(y.precision(), x.precision()) == Apfloat.INFINITE)
        {
            throw new InfiniteExpansionException("Cannot calculate atan2 to infinite precision");
        }
        else if (x.signum() > 0 && y.scale() < x.scale())
        {
            // The log formula below is inaccurate if y is small in magnitude compared to x
            return atan(y.divide(x));
        }
        else
        {
            long maxScale = Math.max(y.scale(), x.scale());

            y = scale(y, -maxScale);    // Now neither y nor x is zero
            x = scale(x, -maxScale);

            return ApcomplexMath.log(new Apcomplex(x, y)).imag();
        }
    }

    /**
     * Cosine. Calculated using complex functions.
     *
     * @param x The argument (in radians).
     *
     * @return Cosine of <code>x</code>.
     */

    public static Apfloat cos(Apfloat x)
        throws ApfloatRuntimeException
    {
        return ApcomplexMath.exp(new Apcomplex(Apfloat.ZERO, x)).real();
    }

    /**
     * Sine. Calculated using complex functions.
     *
     * @param x The argument (in radians).
     *
     * @return Sine of <code>x</code>.
     */

    public static Apfloat sin(Apfloat x)
        throws ApfloatRuntimeException
    {
        return ApcomplexMath.exp(new Apcomplex(Apfloat.ZERO, x)).imag();
    }

    /**
     * Tangent. Calculated using complex functions.
     *
     * @param x The argument (in radians).
     *
     * @return Tangent of <code>x</code>.
     *
     * @exception ArithmeticException If <code>x</code> is &pi;/2 + n &pi; where n is an integer.
     */

    public static Apfloat tan(Apfloat x)
        throws ArithmeticException, ApfloatRuntimeException
    {
        Apcomplex w = ApcomplexMath.exp(new Apcomplex(Apfloat.ZERO, x));

        return w.imag().divide(w.real());
    }

    /**
     * Lambert W function. The W function gives the solution to the equation
     * <code>W e<sup>W</sup> = x</code>. Also known as the product logarithm.<p>
     *
     * This function only gives the solution to the principal branch, W<sub>0</sub>.
     * For the real-valued W<sub>-1</sub> branch, use {@link ApcomplexMath#w(Apcomplex,long)}.
     *
     * @param x The argument.
     *
     * @return <code>W<sub>0</sub>(x)</code>.
     *
     * @exception ArithmeticException If <code>x</code> is less than -1/e.
     *
     * @since 1.8.0
     */

    public static Apfloat w(Apfloat x)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return LambertWHelper.w(x);
    }

    /**
     * Converts an angle measured in radians to degrees.<p>
     *
     * @param x The angle, in radians.
     *
     * @return The angle in degrees.
     *
     * @since 1.8.0
     */

    public static Apfloat toDegrees(Apfloat x)
        throws ApfloatRuntimeException
    {
        return x.signum() == 0 ? x : x.multiply(new Apfloat(180, Apfloat.INFINITE, x.radix())).divide(pi(x.precision(), x.radix()));    // Thanks to Marko Gaspersic for finding the bug in issue #11
    }

    /**
     * Converts an angle measured in degrees to radians.<p>
     *
     * @param x The angle, in degrees.
     *
     * @return The angle in radians.
     *
     * @since 1.8.0
     */

    public static Apfloat toRadians(Apfloat x)
        throws ApfloatRuntimeException
    {
        return x.signum() == 0 ? x : x.divide(new Apfloat(180, Apfloat.INFINITE, x.radix())).multiply(pi(x.precision(), x.radix()));    // Thanks to Marko Gaspersic for finding the bug in issue #11
    }

    /**
     * Product of numbers.
     * The precision used in the multiplications is only
     * what is needed for the end result. This method may
     * perform significantly better than simply multiplying
     * the numbers sequentially.<p>
     *
     * If there are no arguments, the return value is <code>1</code>.
     *
     * @param x The argument(s).
     *
     * @return The product of the given numbers.
     *
     * @since 1.3
     */

    public static Apfloat product(Apfloat... x)
        throws ApfloatRuntimeException
    {
        if (x.length == 0)
        {
            return Apfloat.ONE;
        }

        // Determine working precision
        long maxPrec = Apfloat.INFINITE;
        for (int i = 0; i < x.length; i++)
        {
            if (x[i].signum() == 0)
            {
                return Apfloat.ZEROS[x[i].radix()];
            }
            maxPrec = Math.min(maxPrec, x[i].precision());
        }

        // Do not use x.clone() as the array might be of some subclass type, resulting in ArrayStoreException later
        Apfloat[] tmp = new Apfloat[x.length];

        // Add sqrt length digits for round-off errors
        long extraPrec = (long) Math.sqrt((double) x.length),
             destPrec = ApfloatHelper.extendPrecision(maxPrec, extraPrec);
        for (int i = 0; i < x.length; i++)
        {
            tmp[i] = x[i].precision(destPrec);
        }
        x = tmp;

        // Create a heap, ordered by size
        Queue<Apfloat> heap = new PriorityQueue<>(x.length, Comparator.comparing(Apfloat::size));

        // Perform the multiplications in parallel
        ParallelHelper.ProductKernel<Apfloat> kernel = (h) ->
        {
            Apfloat a = h.remove();
            Apfloat b = h.remove();
            Apfloat c = a.multiply(b);
            h.add(c);
        };
        ParallelHelper.parallelProduct(x, heap, kernel);

        return heap.remove().precision(maxPrec);
    }

    /**
     * Sum of numbers.
     * The precision used in the additions is only
     * what is needed for the end result. This method may
     * perform significantly better than simply adding
     * the numbers sequentially.<p>
     *
     * If there are no arguments, the return value is <code>0</code>.
     *
     * @param x The argument(s).
     *
     * @return The sum of the given numbers.
     *
     * @since 1.3
     */

    public static Apfloat sum(Apfloat... x)
        throws ApfloatRuntimeException
    {
        if (x.length == 0)
        {
            return Apfloat.ZERO;
        }

        // Determine working precision
        long maxScale = -Apfloat.INFINITE,
             maxPrec = Apfloat.INFINITE;
        for (int i = 0; i < x.length; i++)
        {
            long oldScale = maxScale,
                 oldPrec = maxPrec,
                 newScale = x[i].scale(),
                 newPrec = x[i].precision();
            maxScale = Math.max(oldScale, newScale);
            long oldScaleDiff = (maxScale - oldScale < 0 ? Apfloat.INFINITE : maxScale - oldScale),
                 newScaleDiff = (maxScale - newScale < 0 ? Apfloat.INFINITE : maxScale - newScale);
            maxPrec = Math.min(Util.ifFinite(oldPrec, oldPrec + oldScaleDiff),
                               Util.ifFinite(newPrec, newPrec + newScaleDiff));
        }

        // Do not use x.clone() as the array might be of some subclass type, resulting in ArrayStoreException later
        Apfloat[] tmp = new Apfloat[x.length];

        for (int i = 0; i < x.length; i++)
        {
            long scale = x[i].scale(),
                 scaleDiff = (maxScale - scale < 0 ? Apfloat.INFINITE : maxScale - scale),
                 destPrec = (maxPrec - scaleDiff <= 0 ? 0 : Util.ifFinite(maxPrec, maxPrec - scaleDiff));
            if (destPrec > 0)
            {
                tmp[i] = x[i].precision(destPrec);
            }
            else
            {
                tmp[i] = Apfloat.ZERO;
            }
        }
        x = tmp;

        // Sort by scale (might be mostly equal to size)
        Comparator<Apfloat> comparator = Comparator.comparing(Apfloat::scale);
        Arrays.sort(x, comparator);

        // The list of numbers to be added
        List<Apfloat> list;

        // If there are lots of numbers then use a fully parallel algorithm, for small sums the overhead is not worth it
        // Also note that memory (or worse - disk) bandwidth is likely a bottleneck, preventing efficient parallelization
        if (x.length >= 1000)
        {
            // Only add in parallel numbers, which are (probably) below the memory threshold in size
            ApfloatContext ctx = ApfloatContext.getContext();
            long maxSize = (long) (ctx.getMemoryThreshold() * 5.0 / Math.log((double) ctx.getDefaultRadix()));

            // Create a queue of small numbers where the parallel algorithm can add and remove elements
            Queue<Apfloat> queue = new ConcurrentLinkedQueue<>();

            // The large numbers go to the list where they will be added using a single thread algorithm
            list = new ArrayList<>();

            // Put all the numbers to either the parallel queue or single thread list
            for (Apfloat a : x)
            {
                (a.size() <= maxSize ? queue : list).add(a);
            }

            Runnable runnable = () ->
            {
                // Add numbers as long as there are any left in the queue
                Apfloat s = Apfloat.ZERO,
                        a;
                while ((a = queue.poll()) != null)
                {
                    s = s.add(a);
                }
                // Finally, put the sub-sum back in the queue
                queue.add(s);
            };

            // Run the runnable in multiple threads
            ParallelHelper.runParallel(runnable);

            // Put the remaining sub-sums to the list to be added once more
            list.addAll(queue);

            // Sort again the list as it has been now mixed up
            Collections.sort(list, comparator);
        }
        else
        {
            // Single thread case - just add all the numbers
            list = Arrays.asList(x);
        }

        // Add the remaining elements in the queue (all, for the single-thread case, and sub-sums for the parallel case)
        Apfloat s = Apfloat.ZERO;
        for (Apfloat a : list)
        {
            s = s.add(a);
        }

        return s;
    }

    /**
     * Calculates <i>e</i>. Uses default radix.
     *
     * @param precision Number of digits of <i>e</i> to calculate.
     *
     * @return <i>e</i> accurate to <code>precision</code> digits, in the default radix.
     *
     * @throws NumberFormatException If the default radix is not valid.
     * @throws IllegalArgumentException In case the precision is invalid.
     *
     * @since 1.11.0
     */

    public static Apfloat e(long precision)
        throws IllegalArgumentException, NumberFormatException, ApfloatRuntimeException
    {
        ApfloatContext ctx = ApfloatContext.getContext();
        int radix = ctx.getDefaultRadix();

        return e(precision, radix);
    }

    /**
     * Calculates <i>e</i>.
     *
     * @param precision Number of digits of <i>e</i> to calculate.
     * @param radix The radix in which the number should be presented.
     *
     * @return <i>e</i> accurate to <code>precision</code> digits, in base <code>radix</code>.
     *
     * @throws NumberFormatException If the radix is not valid.
     * @throws IllegalArgumentException In case the precision is invalid.
     *
     * @since 1.11.0
     */

    public static Apfloat e(long precision, int radix)
        throws IllegalArgumentException, NumberFormatException, ApfloatRuntimeException
    {
        if (precision <= 0)
        {
            throw new IllegalArgumentException("Precision " + precision + " is not positive");
        }
        else if (precision == Apfloat.INFINITE)
        {
            throw new InfiniteExpansionException("Cannot calculate e to infinite precision");
        }

        long terms = inverseFactorial(precision, radix);
        Apfloat[] pq = e(1, terms, precision, radix);
        return pq[0].divide(pq[1]).add(Apfloat.ONES[radix]);
    }

    // Rough approximation of log(n!) = n log n - n
    private static long inverseFactorial(long precision, int radix)
    {
        double x = precision * Math.log(radix) + 7, // Does not work with extremely low precision
               n = x,
               p;
        do
        {
            p = n;
            n = x / (Math.log(n) - 1);
        } while ((long) p != (long) n);
        return (long) Math.ceil(n);
    }

    private static Apfloat[] e(long start, long end, long precision, int radix)
    {
        if (end - start == 1)
        {
            Apfloat[] pq = { Apfloat.ONES[radix], new Apfloat(start, precision, radix) };
            return pq;
        }

        long mid = start + end >>> 1;
        Apfloat[] first = e(start, mid, precision, radix),
                  last = e(mid, end, precision, radix),
                  pq = { first[0].multiply(last[1]).add(last[0]), first[1].multiply(last[1]) };
        return pq;
    }

    /**
     * Calculates &gamma;, the Euler-Mascheroni constant. Uses default radix.
     *
     * @param precision Number of digits of &gamma; to calculate.
     *
     * @return &gamma; accurate to <code>precision</code> digits, in the default radix.
     *
     * @exception NumberFormatException If the default radix is not valid.
     * @exception IllegalArgumentException In case the precision is invalid.
     *
     * @since 1.10.0
     */

    public static Apfloat euler(long precision)
        throws IllegalArgumentException, NumberFormatException, ApfloatRuntimeException
    {
        ApfloatContext ctx = ApfloatContext.getContext();
        int radix = ctx.getDefaultRadix();

        return euler(precision, radix);
    }

    /**
     * Calculates &gamma;, the Euler-Mascheroni constant.
     *
     * @param precision Number of digits of &gamma; to calculate.
     * @param radix The radix in which the number should be presented.
     *
     * @return &gamma; accurate to <code>precision</code> digits, in base <code>radix</code>.
     *
     * @exception NumberFormatException If the radix is not valid.
     * @exception IllegalArgumentException In case the precision is invalid.
     *
     * @since 1.10.0
     */

    public static Apfloat euler(long precision, int radix)
        throws IllegalArgumentException, NumberFormatException, ApfloatRuntimeException
    {
        if (precision <= 0)
        {
            throw new IllegalArgumentException("Precision " + precision + " is not positive");
        }
        else if (precision == Apfloat.INFINITE)
        {
            throw new InfiniteExpansionException("Cannot calculate Euler gamma to infinite precision");
        }

        return (precision <= 2000 ? eulerSmall(precision, radix) : EulerHelper.euler(precision, radix));
    }

    static Apfloat eulerSmall(long precision, int radix)
        throws IllegalArgumentException, NumberFormatException, ApfloatRuntimeException
    {
        // See https://www.ams.org/journals/mcom/1980-34-149/S0025-5718-1980-0551307-4/S0025-5718-1980-0551307-4.pdf
        // Mathematics of Computation, volume 34, number 149, January 1980, pages 305-312
        // "Some new algorithms for high-precision computation of Euler's constant" by Richard P. Brent and Edwin M. McMillan
        long n = (long) (Apfloat.EXTRA_PRECISION + 0.25 * Math.log(radix) * precision),
             workingPrecision = ApfloatHelper.extendPrecision(precision),
             targetPrecision = ApfloatHelper.extendPrecision(precision, Apfloat.EXTRA_PRECISION / 2);
        Apfloat a = log(new Apfloat(n, workingPrecision, radix)).negate(),
                b = new Apfloat(1, workingPrecision, radix),
                u = a,
                v = b,
                ou,
                ov;
        Apint one = new Apint(1, radix),
              k = one,
              n2 = ApintMath.pow(new Apint(n, radix), 2);
        do
        {
            ou = u;
            ov = v;
            b = b.multiply(n2).divide(pow(k, 2));
            a = a.multiply(n2).divide(k).add(b).divide(k);
            u = u.add(a);
            v = v.add(b);
            k = k.add(one);
        } while (u.equalDigits(ou) < targetPrecision || v.equalDigits(ov) < targetPrecision);
        return u.divide(v).precision(precision);
    }

    /**
     * Calculates Catalan's constant, <i>G</i>. Uses the default radix.<p>
     *
     * @implNote
     * This implementation is <i>slow</i>.
     *
     * @param precision Number of digits of <i>G</i> to calculate.
     *
     * @return <i>G</i> accurate to <code>precision</code> digits, in the default radix.
     *
     * @exception NumberFormatException If the default radix is not valid.
     * @exception IllegalArgumentException In case the precision is invalid.
     *
     * @since 1.11.0
     */

    public static Apfloat catalan(long precision)
        throws IllegalArgumentException, NumberFormatException, ApfloatRuntimeException
    {
        ApfloatContext ctx = ApfloatContext.getContext();
        int radix = ctx.getDefaultRadix();

        return catalan(precision, radix);
    }

    /**
     * Calculates Catalan's constant, <i>G</i>. Uses the specified radix.<p>
     *
     * @implNote
     * This implementation is <i>slow</i>.
     *
     * @param precision Number of digits of <i>G</i> to calculate.
     * @param radix The radix in which the number should be presented.
     *
     * @return <i>G</i> accurate to <code>precision</code> digits, in base <code>radix</code>.
     *
     * @exception NumberFormatException If the radix is not valid.
     * @exception IllegalArgumentException In case the precision is invalid.
     *
     * @since 1.11.0
     */

    public static Apfloat catalan(long precision, int radix)
        throws IllegalArgumentException, NumberFormatException, ApfloatRuntimeException
    {
        if (precision <= 0)
        {
            throw new IllegalArgumentException("Precision " + precision + " is not positive");
        }
        else if (precision == Apfloat.INFINITE)
        {
            throw new InfiniteExpansionException("Cannot calculate C to infinite precision");
        }

        long workingPrecision = ApfloatHelper.extendPrecision(precision);
        Apfloat one = new Apfloat(1, workingPrecision, radix),
                two = new Apfloat(2, workingPrecision, radix),
                three = new Apfloat(3, workingPrecision, radix),
                four = new Apfloat(4, workingPrecision, radix);
        return zeta(two, one.divide(four)).subtract(zeta(two, three.divide(four))).divide(new Apint(16, radix)).precision(precision);
    }

    /**
     * Calculates the Glaisher‐Kinkelin constant, <i>A</i>. Uses the default radix.<p>
     *
     * @implNote
     * This implementation is <i>slow</i>. At the time of implementation no
     * efficient algorithm is known for the Glaisher‐Kinkelin constant.
     *
     * @param precision Number of digits of <i>A</i> to calculate.
     *
     * @return <i>A</i> accurate to <code>precision</code> digits, in the default radix.
     *
     * @exception NumberFormatException If the default radix is not valid.
     * @exception IllegalArgumentException In case the precision is invalid.
     *
     * @since 1.11.0
     */

    public static Apfloat glaisher(long precision)
        throws IllegalArgumentException, NumberFormatException, ApfloatRuntimeException
    {
        ApfloatContext ctx = ApfloatContext.getContext();
        int radix = ctx.getDefaultRadix();

        return glaisher(precision, radix);
    }

    /**
     * Calculates the Glaisher‐Kinkelin constant, <i>A</i>. Uses the specified radix.<p>
     *
     * @implNote
     * This implementation is <i>slow</i>. At the time of implementation no
     * efficient algorithm is known for the Glaisher‐Kinkelin constant.
     *
     * @param precision Number of digits of <i>A</i> to calculate.
     * @param radix The radix in which the number should be presented.
     *
     * @return <i>A</i> accurate to <code>precision</code> digits, in base <code>radix</code>.
     *
     * @exception NumberFormatException If the radix is not valid.
     * @exception IllegalArgumentException In case the precision is invalid.
     *
     * @since 1.11.0
     */

    public static Apfloat glaisher(long precision, int radix)
        throws IllegalArgumentException, NumberFormatException, ApfloatRuntimeException
    {
        if (precision <= 0)
        {
            throw new IllegalArgumentException("Precision " + precision + " is not positive");
        }
        else if (precision == Apfloat.INFINITE)
        {
            throw new InfiniteExpansionException("Cannot calculate A to infinite precision");
        }

        // Calculated using A = exp(euler/12 - zeta'(2)/(2 pi^2)) (2 pi)^(1/12)
        // The tricky part is the derivative of the zeta function
        // See: An Efficient Algorithm for the Riemann Zeta Function (1995) by P. Borwein, http://www.cecm.sfu.ca/~pborwein/PAPERS/P155.pdf
        // d_k = n sum((n + i - 1)! 4^i / ((n - i)! (2i)!), i=0..k)
        // zeta'(2) = 1/d_n sum((-1)^(k+1) (d_n - d_k) (log(4) + 2 log(1 + k))/(1 + k)^2, k=0..n-1)
        // d_n - d_k = n sum((n + i - 1)! 4^i / ((n - i)! (2i)!), i=k+1..n)
        long workingPrecision = ApfloatHelper.extendPrecision(precision),
             n = (long) Math.ceil(workingPrecision * Math.log(radix) / Math.log(3 + Math.sqrt(8)));
        Apfloat two = new Apfloat(2, workingPrecision, radix),
                four = new Apfloat(4, workingPrecision, radix),
                log4 = log(four),
                pi = pi(workingPrecision, radix),
                d = pow(two, Math.multiplyExact(2,  n) - 1),
                dnk = d,
                z = Apfloat.ZERO;
        for (long k = n - 1; k >= 0; k--)
        {
            Apfloat k1 = new Apfloat(k + 1, workingPrecision, radix),
                    term = dnk.multiply(log4.add(two.multiply(log(k1)))).divide(k1.multiply(k1));
            z = (k & 1) == 0 ? z.subtract(term): z.add(term);
            d = d.multiply(new Apint(2 * k + 2, radix)).multiply(new Apint(2 * k + 1, radix)).divide(four.multiply(new Apint(n + k, radix)).multiply(new Apint(n - k, radix)));
            dnk = dnk.add(d);
        }
        z = z.divide(dnk);
        return exp(euler(workingPrecision, radix).divide(new Apint(12, radix)).subtract(z.divide(two.multiply(pi).multiply(pi)))).multiply(root(two.multiply(pi), 12)).precision(precision);
    }

    /**
     * Calculates Khinchin's constant, <i>K</i>.Uses the default radix.<p>
     *
     * @implNote
     * This implementation is <i>slow</i>. At the time of implementation no
     * efficient algorithm is known for Khinchin's constant.
     *
     * @param precision Number of digits of <i>K</i> to calculate.
     *
     * @return <i>K</i> accurate to <code>precision</code> digits, in the default radix.
     *
     * @exception NumberFormatException If the default radix is not valid.
     * @exception IllegalArgumentException In case the precision is invalid.
     *
     * @since 1.11.0
     */

    public static Apfloat khinchin(long precision)
        throws IllegalArgumentException, NumberFormatException, ApfloatRuntimeException
    {
        ApfloatContext ctx = ApfloatContext.getContext();
        int radix = ctx.getDefaultRadix();

        return khinchin(precision, radix);
    }

    /**
     * Calculates Khinchin's constant, <i>K</i>. Uses the specified radix.<p>
     *
     * @implNote
     * This implementation is <i>slow</i>. At the time of implementation no
     * efficient algorithm is known for Khinchin's constant.
     *
     * @param precision Number of digits of <i>K</i> to calculate.
     * @param radix The radix in which the number should be presented.
     *
     * @return <i>K</i> accurate to <code>precision</code> digits, in base <code>radix</code>.
     *
     * @exception NumberFormatException If the radix is not valid.
     * @exception IllegalArgumentException In case the precision is invalid.
     *
     * @since 1.11.0
     */

    public static Apfloat khinchin(long precision, int radix)
        throws IllegalArgumentException, NumberFormatException, ApfloatRuntimeException
    {
        if (precision <= 0)
        {
            throw new IllegalArgumentException("Precision " + precision + " is not positive");
        }
        else if (precision == Apfloat.INFINITE)
        {
            throw new InfiniteExpansionException("Cannot calculate K to infinite precision");
        }

        // log(K) = 1/log(2) sum((zeta(2n) - 1) / n sum((-1)^k / k, k=1..2n-1), n=1..infinity)
        // zeta(2n) = (-1)^(n+1) B_2n (2 pi)^2n / (2 (2n)!) 
        long workingPrecision = ApfloatHelper.extendPrecision(precision);
        Apint one = Apfloat.ONES[radix],
              two = new Apint(2, radix);
        Apfloat twopi2 = pow(pi(workingPrecision, radix).multiply(two), 2),
                f = new Aprational(one, two),
                s = Apfloat.ZERO;
        Iterator<Aprational> bernoullis2 = AprationalMath.bernoullis2Small(radix);
        for (long n = 1; ; n++)
        {
            f = f.multiply(twopi2).divide(new Apint(Math.multiplyExact(2, n) - 1, radix).multiply(new Apint(2 * n, radix)));
            Apfloat z = abs(bernoullis2.next()).multiply(f).subtract(one);
            if (z.scale() < -precision)
            {
                break;
            }
            Apfloat a = Apfloat.ZERO;
            for (long k = 1; k < 2 * n; k++)
            {
                a = a.add(((k & 1) == 1 ? one : one.negate()).divide(new Apfloat(k, workingPrecision, radix)));
            }
            s = s.add(z.divide(new Apfloat(n, workingPrecision, radix)).multiply(a));
        }
        return exp(s.divide(log(new Apfloat(2, workingPrecision, radix)))).precision(precision);
    }

    /**
     * Gamma function.<p>
     *
     * @implNote
     * This implementation is <i>slow</i>, meaning that it isn't a <i>fast algorithm</i>.
     * The asymptotic complexity is at least O(n<sup>2</sup>log&nbsp;n) and it is
     * impractically slow beyond a precision of a few thousand digits. At the time of
     * implementation no generic fast algorithm is known for the gamma function.
     *
     * @param x The argument.
     *
     * @return <code>&Gamma;(x)</code>
     *
     * @throws ArithmeticException If <code>x</code> is a nonpositive integer.
     *
     * @since 1.9.0
     */

    public static Apfloat gamma(Apfloat x)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return ApcomplexMath.gamma(x).real();
    }

    /**
     * Incomplete gamma function.<p>
     *
     * @implNote
     * This implementation is <i>slow</i>, meaning that it isn't a <i>fast algorithm</i>.
     * The asymptotic complexity is at least O(n<sup>2</sup>log&nbsp;n) and it is
     * impractically slow beyond a precision of a few thousand digits. At the time of
     * implementation no generic fast algorithm is known for the gamma function.
     *
     * @param a The first argument.
     * @param x The second argument.
     *
     * @return <code>&Gamma;(a, x)</code>
     *
     * @throws ArithmeticException If <code>a</code> is not a positive integer and <code>x</code> is nonpositive.
     *
     * @since 1.10.0
     */

    public static Apfloat gamma(Apfloat a, Apfloat x)
        throws ArithmeticException, ApfloatRuntimeException
    {
        if (x.signum() < 0 && !(a.signum() > 0 && a.isInteger()))
        {
            // For a real result, in the case x < 0, a must be a positive integer
            throw new ArithmeticException("Non-real result");
        }
        return ApcomplexMath.gamma(a, x).real();
    }

    /**
     * Generalized incomplete gamma function.<p>
     *
     * This function is defined as: <code>&Gamma;(a, x0, x1) = &Gamma;(a, x0) - &Gamma;(a, x1)</code><p>
     *
     * The lower gamma function can be calculated with: <code>&gamma;(a, x) = &Gamma;(a, 0, x)</code><p>
     *
     * @implNote
     * This implementation is <i>slow</i>, meaning that it isn't a <i>fast algorithm</i>.
     * The asymptotic complexity is at least O(n<sup>2</sup>log&nbsp;n) and it is
     * impractically slow beyond a precision of a few thousand digits. At the time of
     * implementation no generic fast algorithm is known for the gamma function.
     *
     * @param a The first argument.
     * @param x0 The second argument.
     * @param x1 The third argument.
     *
     * @return <code>&Gamma;(a, x0, x1)</code>
     *
     * @throws ArithmeticException If <code>a</code> is not a positive integer and either <code>x0</code> or <code>x1</code> is nonpositive.
     *
     * @since 1.10.0
     */

    public static Apfloat gamma(Apfloat a, Apfloat x0, Apfloat x1)
        throws ArithmeticException, ApfloatRuntimeException
    {
        if ((x0.signum() < 0 || x1.signum() < 0) && !(a.signum() > 0 && a.isInteger()))
        {
            // For a real result, in the case x < 0, a must be a positive integer
            throw new ArithmeticException("Non-real result");
        }
        return ApcomplexMath.gamma(a, x0, x1).real();
    }

    /**
     * Logarithm of the gamma function.<p>
     *
     * @implNote
     * This implementation is <i>slow</i>, meaning that it isn't a <i>fast algorithm</i>.
     * The asymptotic complexity is at least O(n<sup>2</sup>log&nbsp;n) and it is
     * impractically slow beyond a precision of a few thousand digits. At the time of
     * implementation no generic fast algorithm is known for the gamma function.
     *
     * @param x The argument.
     *
     * @return <code>log&Gamma;(x)</code>
     *
     * @throws ArithmeticException If <code>x</code> is nonpositive.
     *
     * @since 1.11.0
     */

    public static Apfloat logGamma(Apfloat x)
        throws ArithmeticException, ApfloatRuntimeException
    {
        if (x.signum() < 0)
        {
            throw new ArithmeticException("Result would be complex");
        }
        return ApcomplexMath.logGamma(x).real();
    }

    /**
     * Digamma function.<p>
     *
     * @implNote
     * This implementation is <i>slow</i>, meaning that it isn't a <i>fast algorithm</i>.
     * The asymptotic complexity is at least O(n<sup>2</sup>log&nbsp;n) and it is
     * impractically slow beyond a precision of a few thousand digits. At the time of
     * implementation no generic fast algorithm is known for the digamma function.
     *
     * @param x The argument.
     *
     * @return <code>&psi;(x)</code>
     *
     * @throws ArithmeticException If <code>x</code> is a nonpositive integer.
     *
     * @since 1.11.0
     */

    public static Apfloat digamma(Apfloat x)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return ApcomplexMath.digamma(x).real();
    }

    /**
     * Binomial coefficient. Calculated using the {@link #gamma(Apfloat)} function.
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
     * @throws ArithmeticException If <code>n</code> is a negative integer and <code>k</code> is noninteger.
     *
     * @since 1.11.0
     */

    public static Apfloat binomial(Apfloat n, Apfloat k)
        throws ArithmeticException, ApfloatRuntimeException
    {
        if (n.isInteger() && k.isInteger())
        {
            return ApintMath.binomial(n.truncate(), k.truncate()).precision(Math.min(n.precision(), k.precision()));
        }
        Apfloat nk = n.subtract(k);
        if (k.isInteger() && k.signum() < 0 ||
            nk.isInteger() && nk.signum() < 0)
        {
            // The divisor is infinity (but the dividend isn't) so we get zero
            return Apcomplex.ZEROS[n.radix()];
        }
        Apint one = Apint.ONES[n.radix()];
        return gamma(n.add(one)).divide(gamma(k.add(one)).multiply(gamma(nk.add(one))));
    }

    /**
     * Riemann zeta function.<p>
     *
     * @implNote
     * This implementation is <i>slow</i>, meaning that it isn't a <i>fast algorithm</i>.
     * It is impractically slow beyond a precision of a few hundred digits. At the time of
     * implementation no generic fast algorithm is known for the zeta function.
     *
     * @param s The argument.
     *
     * @return <code>&zeta;(s)</code>
     *
     * @throws ArithmeticException If <code>s</code> is <code>1</code>.
     *
     * @since 1.11.0
     */

    public static Apfloat zeta(Apfloat s)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return ZetaHelper.zeta(s).real();
    }

    /**
     * Hurwitz zeta function.<p>
     *
     * @implNote
     * This implementation is <i>slow</i>, meaning that it isn't a <i>fast algorithm</i>.
     * It is impractically slow beyond a precision of a few hundred digits. At the time of
     * implementation no generic fast algorithm is known for the zeta function.
     *
     * @param s The first argument.
     * @param a The second argument.
     *
     * @return <code>&zeta;(s, a)</code>
     *
     * @throws ArithmeticException If <code>s</code> is <code>1</code> or if <code>a</code> is a nonpositive integer or if <code>s</code> is not an integer and <code>a</code> is nonpositive.
     *
     * @since 1.11.0
     */

    public static Apfloat zeta(Apfloat s, Apfloat a)
        throws ArithmeticException, ApfloatRuntimeException
    {
        if (!s.isInteger() && a.signum() < 0)
        {
            throw new ArithmeticException("Result would be complex");
        }
        return HurwitzZetaHelper.zeta(s, a).real();
    }

    /**
     * Confluent hypergeometric function <i><sub>0</sub>F<sub>1</sub></i>.<p>
     *
     * @implNote
     * This implementation is <i>slow</i>, meaning that it isn't a <i>fast algorithm</i>.
     * It is impractically slow beyond a precision of a few thousand digits. At the time of
     * implementation no generic fast algorithm is known for the function.
     *
     * @param a The first argument.
     * @param x The second argument.
     *
     * @return <i><sub>0</sub>F<sub>1</sub>(; a; x)</i>
     *
     * @throws ArithmeticException If the function value is not finite.
     *
     * @since 1.11.0
     */

    public static Apfloat hypergeometric0F1(Apfloat a, Apfloat x)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return HypergeometricHelper.hypergeometricPFQ(new Apcomplex[0], new Apcomplex[] { a }, x).real();
    }

    /**
     * Kummer confluent hypergeometric function <i><sub>1</sub>F<sub>1</sub></i>.
     * Also known as the confluent hypergeometric function of the first kind.<p>
     *
     * @implNote
     * This implementation is <i>slow</i>, meaning that it isn't a <i>fast algorithm</i>.
     * It is impractically slow beyond a precision of a few thousand digits. At the time of
     * implementation no generic fast algorithm is known for the function.
     *
     * @param a The first argument.
     * @param b The second argument.
     * @param x The third argument.
     *
     * @return <i><sub>1</sub>F<sub>1</sub>(a; b; x)</i>
     *
     * @throws ArithmeticException If the function value is not finite.
     *
     * @since 1.11.0
     */

    public static Apfloat hypergeometric1F1(Apfloat a, Apfloat b, Apfloat x)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return HypergeometricHelper.hypergeometricPFQ(new Apcomplex[] { a }, new Apcomplex[] { b }, x).real();
    }

    /**
     * Hypergeometric function <i><sub>2</sub>F<sub>1</sub></i>.
     * Also known as the Gaussian or ordinary hypergeometric function.<p>
     *
     * @implNote
     * This implementation is <i>slow</i>, meaning that it isn't a <i>fast algorithm</i>.
     * It is impractically slow beyond a precision of a few thousand digits. At the time of
     * implementation no generic fast algorithm is known for the function.
     *
     * @param a The first argument.
     * @param b The second argument.
     * @param c The third argument.
     * @param x The fourth argument.
     *
     * @return <i><sub>2</sub>F<sub>1</sub>(a, b; c; x)</i>
     *
     * @throws ArithmeticException If the function value is not finite or real.
     *
     * @since 1.11.0
     */

    public static Apfloat hypergeometric2F1(Apfloat a, Apfloat b, Apfloat c, Apfloat x)
        throws ArithmeticException, ApfloatRuntimeException
    {
        // With real a, b and c the result is real if z <= 1 except if it's a polynomial, in which case it's always real (nb. additional checks might throw an exception later)
        Apint one = Apint.ONES[x.radix()];
        if (x.compareTo(one) > 0 && HypergeometricHelper.minNonPositiveInteger(a, b) == null)
        {
            throw new ArithmeticException("Result would be complex");
        }
        return HypergeometricHelper.hypergeometricPFQ(new Apcomplex[] { a, b }, new Apcomplex[] { c }, x).real();
    }

    /**
     * Generates a random number. Uses the default radix.
     * Returned values are chosen pseudorandomly with (approximately)
     * uniform distribution from the range <code>0 &le; x &lt; 1</code>.
     * The generated random numbers may have leading zeros and may thus not
     * always have exactly the requested number of significant digits.
     * The precision of the numbers is the requested number of digits minus
     * the number of leading zeros. Trailing zeros do not affect the precision.
     *
     * @param digits Maximum number of digits in the number.
     *
     * @return A random number, uniformly distributed between <code>0 &le; x &lt; 1</code>.
     *
     * @exception NumberFormatException If the default radix is not valid.
     * @exception IllegalArgumentException In case the number of specified digits is invalid.
     *
     * @since 1.9.0
     */

    public static Apfloat random(long digits)
    {
        ApfloatContext ctx = ApfloatContext.getContext();
        int radix = ctx.getDefaultRadix();

        return random(digits, radix);
    }

    /**
     * Generates a random number.
     * Returned values are chosen pseudorandomly with (approximately)
     * uniform distribution from the range <code>0 &le; x &lt; 1</code>.
     * The generated random numbers may have leading zeros and may thus not
     * always have exactly the requested number of significant digits.
     * The precision of the numbers is the requested number of digits minus
     * the number of leading zeros. Trailing zeros do not affect the precision.
     *
     * @param digits Maximum number of digits in the number.
     * @param radix The radix in which the number should be generated.
     *
     * @return A random number, uniformly distributed between <code>0 &le; x &lt; 1</code>, in base <code>radix</code>.
     *
     * @exception NumberFormatException If the radix is not valid.
     * @exception IllegalArgumentException In case the number of specified digits is invalid.
     *
     * @since 1.9.0
     */

    public static Apfloat random(long digits, int radix)
    {
        Apfloat random = ApintMath.random(digits, radix);
        if (random.signum() != 0)
        {
            random = random.precision(random.scale());
        }
        return scale(random, -digits);
    }

    /**
     * Generates a random, Gaussian ("normally") distributed
     * number value with mean 0 and standard deviation 1.
     * Uses the default radix.
     *
     * @param digits Maximum number of digits in the number.
     *
     * @return A random number, Gaussian ("normally") distributed with mean 0 and standard deviation 1.
     *
     * @exception NumberFormatException If the default radix is not valid.
     * @exception IllegalArgumentException In case the number of specified digits is invalid.
     *
     * @since 1.9.0
     */

    public static Apfloat randomGaussian(long digits)
    {
        ApfloatContext ctx = ApfloatContext.getContext();
        int radix = ctx.getDefaultRadix();

        return randomGaussian(digits, radix);
    }

    /**
     * Generates a random, Gaussian ("normally") distributed
     * number value with mean 0 and standard deviation 1.
     * Uses the default radix.
     *
     * @param digits Maximum number of digits in the number.
     * @param radix The radix in which the number should be generated.
     *
     * @return A random number, Gaussian ("normally") distributed with mean 0 and standard deviation 1.
     *
     * @exception NumberFormatException If the radix is not valid.
     * @exception IllegalArgumentException In case the number of specified digits is invalid.
     *
     * @since 1.9.0
     */

    public static Apfloat randomGaussian(long digits, int radix)
    {
        // Get synchronization lock - getting the lock is also synchronized
        Object radixKey = getRadixKey(ApfloatMath.radixGaussianKeys, radix);

        synchronized (radixKey)
        {
            Apfloat nextGaussian = ApfloatMath.nextGaussian.remove(radix);
            Long nextGaussianPrecision = ApfloatMath.nextGaussianPrecision.remove(radix);
            if (nextGaussian != null && nextGaussianPrecision == digits)
            {
                return nextGaussian;
            }
            else
            {
                Apint one = new Apint(1, radix),
                      two = new Apint(2, radix);
                Apfloat v1, v2, s;
                do
                {
                    v1 = two.multiply(random(digits, radix)).subtract(one).precision(digits);
                    v2 = two.multiply(random(digits, radix)).subtract(one).precision(digits);
                    s = multiplyAdd(v1, v1, v2, v2);
                } while (s.compareTo(one) >= 1 || s.signum() == 0);
                Apfloat multiplier = sqrt(two.negate().multiply(log(s)).divide(s));
                nextGaussian = v2.multiply(multiplier);
                ApfloatMath.nextGaussian.put(radix, nextGaussian);
                ApfloatMath.nextGaussianPrecision.put(radix, digits);
                return v1.multiply(multiplier);
            }
        }
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

    public static Apfloat max(Apfloat x, Apfloat y)
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

    public static Apfloat min(Apfloat x, Apfloat y)
    {
        return (x.compareTo(y) < 0 ? x : y);
    }

    /**
     * Returns the number adjacent to the first argument in the direction of
     * the second argument, considering the scale and precision of the first
     * argument. If the precision of the first argument is infinite, the
     * first argument is returned. If both arguments compare as equal then
     * the first argument is returned.
     *
     * @param start The starting value.
     * @param direction Value indicating which of <code>start</code>'s neighbors or <code>start</code> should be returned.
     *
     * @return The number adjacent to <code>start</code> in the direction of <code>direction</code>.
     *
     * @since 1.10.0
     */

    public static Apfloat nextAfter(Apfloat start, Apfloat direction)
    {
        return nextInDirection(start, direction.compareTo(start));
    }

    /**
     * Returns the number adjacent to the argument in the direction of
     * positive infinity, considering the scale and precision of the
     * argument. If the precision of the argument is infinite, the
     * argument is returned.
     *
     * @param x The starting value.
     *
     * @return The adjacent value closer to positive infinity.
     *
     * @since 1.10.0
     */

    public static Apfloat nextUp(Apfloat x)
    {
        return nextInDirection(x, 1);
    }

    /**
     * Returns the number adjacent to the argument in the direction of
     * negative infinity, considering the scale and precision of the
     * argument. If the precision of the argument is infinite, the
     * argument is returned.
     *
     * @param x The starting value.
     *
     * @return The adjacent value closer to negative infinity.
     *
     * @since 1.10.0
     */

    public static Apfloat nextDown(Apfloat x)
    {
        return nextInDirection(x, -1);
    }

    /**
     * Returns the unit in the last place of the argument, considering the
     * scale and precision. This is same as the difference between the argument
     * and the value returned from {@link #nextUp(Apfloat)}.
     * If the precision of the argument is infinite, zero is returned.<p>
     *
     * For example, ulp of <code>1.</code> is <code>1</code>, ulp of <code>1.1</code> is <code>0.1</code>
     * and ulp of <code>1.001</code> is <code>0.001</code> (considering significant digits only).
     *
     * @param x The argument.
     *
     * @return The ulp of the argument.
     *
     * @since 1.10.0
     */

    public static Apfloat ulp(Apfloat x)
    {
        return ulp(x, 1);
    }

    private static Apfloat nextInDirection(Apfloat x, int direction)
    {
        return x.add(ulp(x, direction));
    }

    private static Apfloat ulp(Apfloat x, int direction)
    {
        long scale = x.scale() - x.precision();
        if (x.precision() == Apfloat.INFINITE || x.scale() < 0 && scale >= 0)   // Detect overflow
        {
            return Apfloat.ZEROS[x.radix()];
        }
        return scale(new Apfloat(direction, 1, x.radix()), scale);
    }

    // Extend the precision on last iteration
    private static Apfloat lastIterationExtendPrecision(int iterations, int precisingIteration, Apfloat x)
        throws ApfloatRuntimeException
    {
        return (iterations == 0 && precisingIteration != 0 ? ApfloatHelper.extendPrecision(x) : x);
    }

    // Get shared radix key for synchronizing getting and calculating something per radix
    private static Object getRadixKey(Map<Integer, Object> radixKeys, int radix)
    {
        Object value = new Object();
        Object radixKey = radixKeys.putIfAbsent(radix, value);
        if (radixKey == null)
        {
            radixKey = value;
        }

        return radixKey;
    }

    static Apfloat factorial(long n, long precision)
        throws ArithmeticException, NumberFormatException, ApfloatRuntimeException
    {
        ApfloatContext ctx = ApfloatContext.getContext();
        int radix = ctx.getDefaultRadix();

        return factorial(n, precision, radix);
    }

    static Apfloat factorial(long n, long precision, int radix)
        throws ArithmeticException, NumberFormatException, ApfloatRuntimeException
    {
        if (n < 0)
        {
            throw new ArithmeticException("Factorial of negative number");
        }
        else if (n < 2)
        {
            return new Apfloat(1, precision, radix);
        }

        long targetPrecision = precision;
        precision = ApfloatHelper.extendPrecision(precision);

        // Thanks to Peter Luschny for the improved algorithm.
        // The idea is to split the factorial to two parts:
        // a product of odd numbers, and a power of two.
        // This saves some operations, as squaring is more
        // efficient than multiplication, in the power of two.
        // For any n, factorial(n) = oddProduct(n) * factorial(m) * 2^m,
        // where m = n >>> 1, which gives the following algorithm.
        Apfloat oddProduct = new Apfloat(1, precision, radix),
                factorialProduct = oddProduct;
        long exponentOfTwo = 0;

        for (int i = 62 - Long.numberOfLeadingZeros(n); i >= 0; i--)
        {
            long m = n >>> i,
                 k = m >>> 1;
            exponentOfTwo += k;
            oddProduct = oddProduct.multiply(oddProduct(k + 1, m, precision, radix));
            factorialProduct = factorialProduct.multiply(oddProduct);
        }

        return factorialProduct.multiply(pow(new Apfloat(2, precision, radix), exponentOfTwo)).precision(targetPrecision);
    }

    private static Apfloat oddProduct(long n, long m, long precision, int radix)
        throws ApfloatRuntimeException
    {
        n = n | 1;       // Round n up to the next odd number
        m = (m - 1) | 1; // Round m down to the next odd number

        if (n > m)
        {
            return new Apfloat(1, precision, radix);
        }
        else if (n == m)
        {
            return new Apfloat(n, precision, radix);
        }
        else
        {
            long k = (n + m) >>> 1;
            return oddProduct(n, k, precision, radix).multiply(oddProduct(k + 1, m, precision, radix));
        }
    }

    // Clean up static maps at shutdown, to allow garbage collecting temporary files
    static void cleanUp()
    {
        ApfloatMath.radixPi = SHUTDOWN_MAP;
        ApfloatMath.radixPiT = SHUTDOWN_MAP;
        ApfloatMath.radixPiQ = SHUTDOWN_MAP;
        ApfloatMath.radixPiP = SHUTDOWN_MAP;
        ApfloatMath.radixPiInverseRoot = SHUTDOWN_MAP;
        ApfloatMath.radixLog = SHUTDOWN_MAP;
        ApfloatMath.radixLogPi = SHUTDOWN_MAP;
        ApfloatMath.nextGaussian = SHUTDOWN_MAP;
    }

    // Map that always throws ApfloatRuntimeException, to be used after clean-up has been initiated
    private static final Map<Integer, Apfloat> SHUTDOWN_MAP = new ShutdownMap<>();

    // Synchronization keys for pi calculation
    private static ConcurrentMap<Integer, Object> radixPiKeys = new ConcurrentHashMap<>();

    // Shared cached values related to pi for different radixes
    private static Map<Integer, Apfloat> radixPi = new ConcurrentSoftHashMap<>();
    private static Map<Integer, PiCalculator> radixPiCalculator = new Hashtable<>();
    private static Map<Integer, Apfloat> radixPiT = new ConcurrentSoftHashMap<>();
    private static Map<Integer, Apfloat> radixPiQ = new ConcurrentSoftHashMap<>();
    private static Map<Integer, Apfloat> radixPiP = new ConcurrentSoftHashMap<>();
    private static Map<Integer, Apfloat> radixPiInverseRoot = new ConcurrentSoftHashMap<>();
    private static Map<Integer, Long> radixPiTerms = new Hashtable<>();

    // Synchronization keys for logarithm calculation
    private static ConcurrentMap<Integer, Object> radixLogKeys = new ConcurrentHashMap<>();

    // Shared cached values related to logarithm for different radixes
    private static Map<Integer, Apfloat> radixLog = new ConcurrentHashMap<>();
    private static Map<Integer, Apfloat> radixLogPi = new ConcurrentHashMap<>();

    // Synchronization keys for random Gaussian calculation
    private static ConcurrentMap<Integer, Object> radixGaussianKeys = new ConcurrentHashMap<>();

    // Used by randomGaussian
    private static Map<Integer, Apfloat> nextGaussian = new ConcurrentHashMap<>();
    private static Map<Integer, Long> nextGaussianPrecision = new ConcurrentHashMap<>();
}
