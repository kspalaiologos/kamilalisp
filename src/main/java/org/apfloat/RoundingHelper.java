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

import static org.apfloat.ApfloatMath.abs;

/**
 * Helper class for rounding functions.
 *
 * @since 1.7.0
 * @version 1.11.0
 * @author Mikko Tommila
 */

class RoundingHelper
{
    private RoundingHelper()
    {
    }

    public static Apfloat roundToMultiple(Apfloat x, Apfloat y, RoundingMode roundingMode)
        throws IllegalArgumentException, ArithmeticException, ApfloatRuntimeException
    {
        if (x.signum() == 0)
        {
            return x;
        }
        else if (y.signum() == 0)
        {
            throw new ArithmeticException("Non-zero as multiple of zero");
        }

        // Get rid of residual digits
        int signum = x.signum();
        x = roundToPrecision(abs(x), x.precision(), RoundingMode.UNNECESSARY);
        y = roundToPrecision(abs(y), y.precision(), RoundingMode.UNNECESSARY);

        long precision;
        if (x.compareTo(y) < 0)
        {
            precision = Apfloat.EXTRA_PRECISION;                                // abs(x) < abs(y)
        }
        else
        {
            long scaleDiff = x.scale() - y.scale();                             // We now know that x.scale() >= y.scale()
            scaleDiff = (scaleDiff < 0 ? Apfloat.INFINITE : scaleDiff);         // Check for overflow
            precision = ApfloatHelper.extendPrecision(scaleDiff);               // Some extra precision to avoid round-off errors
        }

        Apfloat i = x.precision(precision).divide(y.precision(precision));
        Apint r = roundToInteger(i, RoundingMode.HALF_UP),
              two = new Apint(2, x.radix());
        if (r.multiply(y.precision(Apfloat.INFINITE)).equals(x.precision(Apfloat.INFINITE)))
        {
            // x / y is an integer
            i = r;
        }
        else if ((r = roundToInteger(i.multiply(two), RoundingMode.HALF_UP)).multiply(y.precision(Apfloat.INFINITE)).equals(x.precision(Apfloat.INFINITE).multiply(two)))
        {
            // x / y is a half-integer
            i = new Aprational(r, two); // In an odd radix you can't represent half with an exact expansion like 0.5 in decimal
        }

        i = (signum < 0 ? i.negate() : i);
        i = roundToInteger(i, roundingMode);

        i = i.multiply(y);

        return i;
    }

    public static Aprational roundToMultiple(Aprational x, Aprational y, RoundingMode roundingMode)
        throws IllegalArgumentException, ArithmeticException, ApfloatRuntimeException
    {
        if (x.signum() == 0)
        {
            return x;
        }
        else if (y.signum() == 0)
        {
            throw new ArithmeticException("Non-zero as multiple of zero");
        }

        y = AprationalMath.abs(y);

        Aprational i = roundToInteger(x.divide(y), roundingMode);

        i = i.multiply(y);

        return i;
    }

    public static Apfloat roundToPlaces(Apfloat x, long places, RoundingMode roundingMode)
        throws IllegalArgumentException, ArithmeticException, ApfloatRuntimeException
    {
        if (x.signum() == 0)
        {
            return x;
        }

        x = x.scale(places);

        if (x.signum() == 0)
        {
            // Underflow now, and might overflow later
            throw new OverflowException("Underflow / overflow");
        }

        x = roundToInteger(x, roundingMode);

        if (places == Long.MIN_VALUE)
        {
            x = ApfloatMath.scale(x, Long.MIN_VALUE >>> 1);
            x = ApfloatMath.scale(x, Long.MIN_VALUE >>> 1);
        }
        else
        {
            x = ApfloatMath.scale(x, -places);
        }
        return x;
    }

    public static Apfloat roundToPrecision(Apfloat x, long precision, RoundingMode roundingMode)
        throws IllegalArgumentException, ArithmeticException, ApfloatRuntimeException
    {
        if (precision <= 0)
        {
            throw new IllegalArgumentException("Invalid precision: " + precision);
        }
        if (x.signum() == 0 || precision == Apfloat.INFINITE)
        {
            return x.precision(precision);
        }

        long targetPrecision = precision;
        precision = Math.min(precision, x.size());  // To get rid of any residual digits

        // Can't optimize by checking x.size() <= precision as the number might have hidden residual digits
        long scale = x.scale();
        boolean overflow = (scale - precision >= scale);
        if (overflow)
        {
            // Avoid overflow of longs, do scaling in two parts
            x = x.scale(-scale);
            x = x.scale(precision);
        }
        else
        {
            x = x.scale(precision - scale);
        }

        x = roundToInteger(x, roundingMode);

        if (overflow)
        {
            // Avoid overflow of longs, do scaling in two parts
            x = ApfloatMath.scale(x, -precision);
            x = ApfloatMath.scale(x, scale);
        }
        else
        {
            x = ApfloatMath.scale(x, scale - precision);
        }
        return x.precision(targetPrecision);
    }

    public static Apint roundToInteger(Apfloat x, RoundingMode roundingMode)
        throws IllegalArgumentException, ArithmeticException, ApfloatRuntimeException
    {
        Apint i;
        switch (roundingMode)
        {
            case UP:
                i = x.roundAway();
                break;
            case DOWN:
                i = x.truncate();
                break;
            case CEILING:
                i = x.ceil();
                break;
            case FLOOR:
                i = x.floor();
                break;
            case HALF_UP:
            case HALF_DOWN:
            case HALF_EVEN:
                Apint whole = x.truncate();
                Apfloat fraction = x.frac().abs();
                int comparison = fraction.compareToHalf();
                if (comparison < 0 || comparison == 0 && roundingMode.equals(RoundingMode.HALF_DOWN))
                {
                    i = x.truncate();
                }
                else if (comparison > 0 || comparison == 0 && roundingMode.equals(RoundingMode.HALF_UP))
                {
                    i = x.roundAway();
                }
                else
                {
                    i = (isEven(whole) ? x.truncate() : x.roundAway());
                }
                break;
            case UNNECESSARY:
                if (x.size() > x.scale())
                {
                    throw new ArithmeticException("Rounding necessary");
                }
                i = x.truncate();   // To get rid of any residual digits
                break;
            default:
                throw new IllegalArgumentException("Unknown rounding mode: " + roundingMode);
        }
        return i;
    }

    public static int compareToHalf(Apfloat x)
    {
        int comparison;
        if (x.radix() % 2 == 0)
        {
            comparison = x.compareTo(new Apfloat("0." + Character.forDigit(x.radix() / 2, x.radix()), Apfloat.INFINITE, x.radix()));
        }
        else
        {
            // In an odd radix, half has an infinite digit expansion
            Apint one = new Apint(1, x.radix());
            Apint two = new Apint(2, x.radix());
            comparison = x.precision(Apfloat.INFINITE).multiply(two).compareTo(one);
        }
        return comparison;
    }

    public static int compareToHalf(Aprational x)
    {
        Aprational half = new Aprational(new Apint(1, x.radix()), new Apint(2, x.radix()));
        int comparison = x.compareTo(half);
        return comparison;
    }

    private static boolean isEven(Apint x)
    {
        // This could be further optimized if the radix is even
        // Note that any fractional part can never be exactly half when the radix is odd as a float, only as a rational
        Apint two = new Apint(2, x.radix());
        return (x.mod(two).signum() == 0);
    }
}
