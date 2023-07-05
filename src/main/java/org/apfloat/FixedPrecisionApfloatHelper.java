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

import org.apfloat.spi.Util;

/**
 * Fixed-precision mathematical functions for floating-point numbers.<p>
 *
 * All results of the mathematical operations are set to have the specified precision.
 * Also all input arguments are set to the specified precision before the operation.
 * If the specified precision is not infinite, this helper class also avoids 
 * <code>InfiniteExpansionException</code> e.g. in case where it would happen with
 * <code>ApfloatMath.acos(Apfloat.ZERO)</code>.
 *
 * @since 1.5
 * @version 1.11.0
 * @author Mikko Tommila
 */

public class FixedPrecisionApfloatHelper
    extends FixedPrecisionApcomplexHelper
{
    /**
     * Constructs an apfloat fixed-precison helper with the specified precision.
     * The results of all mathematical operations are set to the specified precision.
     *
     * @param precision The precision of the results.
     *
     * @exception IllegalArgumentException In case the precision is invalid.
     */

    public FixedPrecisionApfloatHelper(long precision)
        throws IllegalArgumentException
    {
        super(precision);
    }

    /**
     * Returns the value with the specified precision.
     *
     * @param x The value.
     *
     * @return The value with to the specified precision.
     */

    @Override
    public Apfloat valueOf(Apfloat x)
    {
        return super.valueOf(x);
    }

    /**
     * Negation.
     *
     * @param x The value to negate.
     *
     * @return <code>-x</code>.
     */

    public Apfloat negate(Apfloat x)
        throws ApfloatRuntimeException
    {
        return valueOf(x).negate();
    }

    /**
     * Addition.
     *
     * @param x The first operand.
     * @param y The second operand.
     *
     * @return <code>x + y</code>.
     */

    public Apfloat add(Apfloat x, Apfloat y)
        throws ApfloatRuntimeException
    {
        return valueOf(setPrecision(x).add(valueOf(y)));
    }

    /**
     * Subtraction.
     *
     * @param x The first operand.
     * @param y The second operand.
     *
     * @return <code>x - y</code>.
     */

    public Apfloat subtract(Apfloat x, Apfloat y)
        throws ApfloatRuntimeException
    {
        return valueOf(setPrecision(x).subtract(setPrecision(y)));
    }

    /**
     * Multiplication.
     *
     * @param x The first operand.
     * @param y The second operand.
     *
     * @return <code>x * y</code>.
     */

    public Apfloat multiply(Apfloat x, Apfloat y)
        throws ApfloatRuntimeException
    {
        return valueOf(setPrecision(x).multiply(setPrecision(y)));
    }

    /**
     * Division.
     *
     * @param x The first operand.
     * @param y The second operand.
     *
     * @return <code>x / y</code>.
     *
     * @exception ArithmeticException If <code>y</code> is zero.
     */

    public Apfloat divide(Apfloat x, Apfloat y)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return valueOf(setPrecision(x).divide(setPrecision(y)));
    }

    /**
     * Power.
     *
     * @param x The first operand.
     * @param y The second operand.
     *
     * @return <code>x<sup>y</sup></code>.
     *
     * @exception ArithmeticException If <code>x</code> and <code>y</code> are zero, or <code>x</code> is negative and <code>y</code> is not an integer.
     */

    public Apfloat pow(Apfloat x, Apfloat y)
        throws ArithmeticException, ApfloatRuntimeException
    {
        Apfloat result = ApfloatHelper.checkPow(x, y, precision());
        if (result != null)
        {
            return valueOf(result);
        }
        else if (x.signum() < 0 && y.isInteger())
        {
            return valueOf(pow((Apcomplex) x, (Apcomplex) y).real());
        }
        return exp(multiply(log(x), y));
    }

    /**
     * Integer power.
     *
     * @param x The first operand.
     * @param n The second operand.
     *
     * @return <code>x<sup>n</sup></code>.
     *
     * @exception ArithmeticException If <code>x</code> and <code>n</code> are zero, or <code>x</code> is zero and <code>n</code> is negative.
     */

    public Apfloat pow(Apfloat x, long n)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return valueOf(ApfloatMath.pow(setPrecision(x), n));
    }

    /**
     * Absolute value.
     *
     * @param x The operand.
     *
     * @return The absolute value of <code>x</code>.
     */

    public Apfloat abs(Apfloat x)
        throws ApfloatRuntimeException
    {
        return ApfloatMath.abs(valueOf(x));
    }

    /**
     * Arc cosine.
     *
     * @param x The operand.
     *
     * @return The arc cosine of <code>x</code>.
     *
     * @exception ArithmeticException If the absolute value of <code>x</code> is more than one.
     */

    public Apfloat acos(Apfloat x)
        throws ArithmeticException, ApfloatRuntimeException
    {
        if (x.signum() == 0)
        {
            // Zero always has infinite precision so when zero input causes nonzero output special care must be taken
            return divide(pi(x.radix()), new Apfloat(2, precision(), x.radix()));
        }
        return valueOf(ApfloatMath.acos(setPrecision(x)));
    }

    /**
     * Hyperbolic arc cosine.
     *
     * @param x The operand.
     *
     * @return The hyperbolic arc cosine of <code>x</code>.
     *
     * @exception ArithmeticException If the <code>x</code> is less than one.
     */

    public Apfloat acosh(Apfloat x)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return valueOf(ApfloatMath.acosh(setPrecision(x)));
    }

    /**
     * Arc sine.
     *
     * @param x The operand.
     *
     * @return The arc sine of <code>x</code>.
     *
     * @exception ArithmeticException If the absolute value of <code>x</code> is more than one.
     */

    public Apfloat asin(Apfloat x)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return valueOf(ApfloatMath.asin(setPrecision(x)));
    }

    /**
     * Hyperbolic arc sine.
     *
     * @param x The operand.
     *
     * @return The hyperbolic arc sine of <code>x</code>.
     */

    public Apfloat asinh(Apfloat x)
        throws ApfloatRuntimeException
    {
        return valueOf(ApfloatMath.asinh(setPrecision(x)));
    }

    /**
     * Arc tangent.
     *
     * @param x The operand.
     *
     * @return The arc tangent of <code>x</code>.
     */

    public Apfloat atan(Apfloat x)
        throws ApfloatRuntimeException
    {
        return valueOf(ApfloatMath.atan(setPrecision(x)));
    }

    /**
     * Hyperbolic arc tangent.
     *
     * @param x The operand.
     *
     * @return The hyperbolic arc tangent of <code>x</code>.
     *
     * @exception ArithmeticException If the absolute value of <code>x</code> is equal to or more than one.
     */

    public Apfloat atanh(Apfloat x)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return valueOf(ApfloatMath.atanh(setPrecision(x)));
    }

    /**
     * Cube root.
     *
     * @param x The operand.
     *
     * @return The cube root of <code>x</code>.
     */

    public Apfloat cbrt(Apfloat x)
        throws ApfloatRuntimeException
    {
        return valueOf(ApfloatMath.cbrt(setPrecision(x)));
    }

    /**
     * Cosine.
     *
     * @param x The operand.
     *
     * @return The cosine of <code>x</code>.
     */

    public Apfloat cos(Apfloat x)
        throws ApfloatRuntimeException
    {
        return valueOf(ApfloatMath.cos(setTrigonometricPrecision(x)));
    }

    /**
     * Hyperbolic cosine.
     *
     * @param x The operand.
     *
     * @return The hyperbolic cosine of <code>x</code>.
     */

    public Apfloat cosh(Apfloat x)
        throws ApfloatRuntimeException
    {
        return valueOf(ApfloatMath.cosh(setExponentialPrecision(x)));
    }

    /**
     * Exponential function.
     *
     * @param x The operand.
     *
     * @return <code>e<sup>x</sup></code>.
     */

    public Apfloat exp(Apfloat x)
        throws ApfloatRuntimeException
    {
        return valueOf(ApfloatMath.exp(setExponentialPrecision(x)));
    }

    /**
     * Natural logarithm.
     *
     * @param x The operand.
     *
     * @return The natural logarithm of <code>x</code>.
     *
     * @exception ArithmeticException If <code>x</code> is less than or equal to zero.
     */

    public Apfloat log(Apfloat x)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return valueOf(ApfloatMath.log(setLogarithmicPrecision(x)));
    }

    /**
     * Logarithm in specified base.
     *
     * @param x The operand.
     * @param b The base.
     *
     * @return The base-<code>b</code> logarithm of <code>x</code>.
     *
     * @exception ArithmeticException If <code>x</code> or <code>b</code> is less than or equal to zero.
     *
     * @since 1.6
     */

    public Apfloat log(Apfloat x, Apfloat b)
        throws ArithmeticException, ApfloatRuntimeException
    {
        // If x or b is close to one then result will actually have limited accuracy
        // So, if the argument would have more precision, it could be used, however checking for
        // this as well as the computation itself could be very time-consuming so we don't do it
        return valueOf(ApfloatMath.log(setPrecision(x), setPrecision(b)));
    }

    /**
     * Sine.
     *
     * @param x The operand.
     *
     * @return The sine of <code>x</code>.
     */

    public Apfloat sin(Apfloat x)
        throws ApfloatRuntimeException
    {
        Apfloat result = checkSmallLinear(x);
        if (result != null)
        {
            return result;
        }
        return valueOf(ApfloatMath.sin(setTrigonometricPrecision(x)));
    }

    /**
     * Hyperbolic sine.
     *
     * @param x The operand.
     *
     * @return The hyperbolic sine of <code>x</code>.
     */

    public Apfloat sinh(Apfloat x)
        throws ApfloatRuntimeException
    {
        Apfloat result = checkSmallLinear(x);
        if (result != null)
        {
            return result;
        }
        return valueOf(ApfloatMath.sinh(setExponentialPrecision(x)));
    }

    /**
     * Square root.
     *
     * @param x The operand.
     *
     * @return The square root of <code>x</code>.
     *
     * @exception ArithmeticException If <code>x</code> is negative.
     */

    public Apfloat sqrt(Apfloat x)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return valueOf(ApfloatMath.sqrt(setPrecision(x)));
    }

    /**
     * Tangent.
     *
     * @param x The operand.
     *
     * @return The tangent of <code>x</code>.
     *
     * @exception ArithmeticException If <code>x</code> is &pi;/2 + n &pi; where n is an integer.
     */

    public Apfloat tan(Apfloat x)
        throws ArithmeticException, ApfloatRuntimeException
    {
        Apfloat result = checkSmallLinear(x);
        if (result != null)
        {
            return result;
        }
        return valueOf(ApfloatMath.tan(setTrigonometricPrecision(x)));
    }

    /**
     * Hyperbolic tangent.
     *
     * @param x The operand.
     *
     * @return The hyperbolic tangent of <code>x</code>.
     */

    public Apfloat tanh(Apfloat x)
        throws ApfloatRuntimeException
    {
        Apfloat result = checkSmallLinear(x);
        if (result != null)
        {
            return result;
        }
        return valueOf(ApfloatMath.tanhFixedPrecision(setExponentialPrecision(x)));
    }

    /**
     * Arithmetic-geometric mean.
     *
     * @param a The first operand.
     * @param b The first operand.
     *
     * @return The arithmetic-geometric mean of <code>a</code> and <code>b</code>.
     */

    public Apfloat agm(Apfloat a, Apfloat b)
        throws ApfloatRuntimeException
    {
        return valueOf(ApfloatMath.agm(setPrecision(a), setPrecision(b)));
    }

    /**
     * Inverse root.
     *
     * @param x The operand.
     * @param n Which inverse root to take.
     *
     * @return <code>x<sup>-1/n</sup></code>.
     *
     * @exception ArithmeticException If <code>x</code> or <code>n</code> is zero, or <code>x</code> is negative and <code>n</code> is even.
     */

    public Apfloat inverseRoot(Apfloat x, long n)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return valueOf(ApfloatMath.inverseRoot(setPrecision(x), n));
    }

    /**
     * Root.
     *
     * @param x The operand.
     * @param n Which root to take.
     *
     * @return <code>x<sup>1/n</sup></code>.
     *
     * @exception ArithmeticException If <code>n</code> is zero, or <code>x</code> is negative and <code>n</code> is even.
     */

    public Apfloat root(Apfloat x, long n)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return valueOf(ApfloatMath.root(setPrecision(x), n));
    }

    /**
     * Move the radix point.
     *
     * @param x The operand.
     * @param scale The amount to move the radix point.
     *
     * @return <code>x * x.radix()<sup>scale</sup></code>.
     */

    public Apfloat scale(Apfloat x, long scale)
        throws ApfloatRuntimeException
    {
        return ApfloatMath.scale(valueOf(x), scale);
    }

    /**
     * Modulus.
     *
     * @param x The first operand.
     * @param y The second operand.
     *
     * @return <code>x % y</code>.
     */

    public Apfloat mod(Apfloat x, Apfloat y)
        throws ApfloatRuntimeException
    {
        return fmod(x, y);
    }

    /**
     * Ceiling function.
     *
     * @param x The operand.
     *
     * @return The nearest integer greater than or equal to <code>x</code>.
     */

    public Apfloat ceil(Apfloat x)
        throws ApfloatRuntimeException
    {
        return valueOf(ApfloatMath.ceil(setPrecision(x)));
    }

    /**
     * Floor function.
     *
     * @param x The operand.
     *
     * @return The nearest integer less than or equal to <code>x</code>.
     */

    public Apfloat floor(Apfloat x)
        throws ApfloatRuntimeException
    {
        return valueOf(ApfloatMath.floor(setPrecision(x)));
    }

    /**
     * Truncate fractional part.
     *
     * @param x The operand.
     *
     * @return The nearest integer rounded towards zero from <code>x</code>.
     */

    public Apfloat truncate(Apfloat x)
        throws ApfloatRuntimeException
    {
        return valueOf(ApfloatMath.truncate(setPrecision(x)));
    }

    /**
     * Extract fractional part.
     *
     * @param x The operand.
     *
     * @return The fractional part of <code>x</code>.
     *
     * @since 1.7.0
     */

    public Apfloat frac(Apfloat x)
        throws ApfloatRuntimeException
    {
        return valueOf(ApfloatMath.frac(x));
    }

    /**
     * Round with specified rounding mode.
     *
     * @deprecated Use {@link #roundToPrecision(Apfloat,RoundingMode)}.
     *
     * @param x The operand.
     * @param roundingMode The rounding mode.
     *
     * @return <code>x</code> rounded with the specified rounding mode.
     *
     * @since 1.7.0
     */

    @Deprecated
    public Apfloat round(Apfloat x, RoundingMode roundingMode)
        throws ApfloatRuntimeException
    {
        return roundToPrecision(x, roundingMode);
    }

    /**
     * Round to precision with specified rounding mode.
     *
     * @param x The operand.
     * @param roundingMode The rounding mode.
     *
     * @return <code>x</code> rounded to the precision of this helper with the specified rounding mode.
     *
     * @exception ArithmeticException If rounding is necessary (result is not exact) and rounding mode is {@link RoundingMode#UNNECESSARY}.
     *
     * @since 1.11.0
     */

    public Apfloat roundToPrecision(Apfloat x, RoundingMode roundingMode)
        throws ApfloatRuntimeException
    {
        return ApfloatMath.roundToPrecision(x, precision(), roundingMode);
    }

    /**
     * Round to integer with specified rounding mode.
     *
     * @param x The operand.
     * @param roundingMode The rounding mode.
     *
     * @return <code>x</code> rounded to integer with the specified rounding mode.
     *
     * @exception ArithmeticException If rounding is necessary (result is not exact) and rounding mode is {@link RoundingMode#UNNECESSARY}.
     *
     * @since 1.11.0
     */

    public Apfloat roundToInteger(Apfloat x, RoundingMode roundingMode)
        throws ApfloatRuntimeException, ArithmeticException
    {
        return valueOf(ApfloatMath.roundToInteger(x, roundingMode));
    }

    /**
     * Round to specified number of places with specified rounding mode.
     *
     * @param x The operand.
     * @param places The number of places.
     * @param roundingMode The rounding mode.
     *
     * @return <code>x</code> rounded to the specified number of places with the specified rounding mode.
     *
     * @exception ArithmeticException If rounding is necessary (result is not exact) and rounding mode is {@link RoundingMode#UNNECESSARY}.
     *
     * @since 1.11.0
     */

    public Apfloat roundToPlaces(Apfloat x, long places, RoundingMode roundingMode)
        throws ApfloatRuntimeException, ArithmeticException
    {
        return valueOf(ApfloatMath.roundToPlaces(x, places, roundingMode));
    }

    /**
     * Round to multiple with specified rounding mode.
     *
     * @param x The number to round.
     * @param y The integer multiple to round to.
     * @param roundingMode The rounding mode.
     *
     * @exception ArithmeticException If rounding is necessary (result is not exact) and rounding mode is {@link RoundingMode#UNNECESSARY}.
     *
     * @return <code>x</code> rounded to the nearest multiple of <code>y</code> with the specified rounding mode.
     *
     * @since 1.11.0
     */

    public Apfloat roundToMultiple(Apfloat x, Apfloat y, RoundingMode roundingMode)
        throws ApfloatRuntimeException, ArithmeticException
    {
        return valueOf(ApfloatMath.roundToMultiple(x, y, roundingMode));
    }

    /**
     * Lambert W function.
     *
     * @param x The operand.
     *
     * @return <code>W<sub>0</sub>(x)</code>.
     *
     * @since 1.8.0
     */

    public Apfloat w(Apfloat x)
        throws ApfloatRuntimeException
    {
        return valueOf(ApfloatMath.w(setPrecision(x)));
    }

    /**
     * Convert radians to degrees.
     *
     * @param x The angle in radians.
     *
     * @return <code>x</code> converted to degrees.
     *
     * @since 1.8.0
     */

    public Apfloat toDegrees(Apfloat x)
        throws ApfloatRuntimeException
    {
        return valueOf(ApfloatMath.toDegrees(setPrecision(x)));
    }

    /**
     * Convert degrees to radians.
     *
     * @param x The angle in degrees.
     *
     * @return <code>x</code> converted to radians.
     *
     * @since 1.8.0
     */

    public Apfloat toRadians(Apfloat x)
        throws ApfloatRuntimeException
    {
        return valueOf(ApfloatMath.toRadians(setPrecision(x)));
    }

    /**
     * Angle of point.
     *
     * @param x The operand.
     * @param y The operand.
     *
     * @return The angle of the point <code>(y, x)</code>.
     *
     * @exception ArithmeticException If <code>x</code> and <code>y</code> are zero.
     */

    public Apfloat atan2(Apfloat x, Apfloat y)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return valueOf(ApfloatMath.atan2(setPrecision(x), setPrecision(y)));
    }

    /**
     * Copies the sign from one number to another.
     *
     * @param x The number to copy the sign to.
     * @param y The number to copy the sign from.
     *
     * @return <code>x</code> with the sign of <code>y</code>.
     */

    public Apfloat copySign(Apfloat x, Apfloat y)
        throws ApfloatRuntimeException
    {
        return ApfloatMath.copySign(valueOf(x), y);
    }

    /**
     * Modulus.
     *
     * @param x The first operand.
     * @param y The second operand.
     *
     * @return <code>x % y</code>.
     */

    public Apfloat fmod(Apfloat x, Apfloat y)
        throws ApfloatRuntimeException
    {
        return valueOf(ApfloatMath.fmod(x, setPrecision(y)));     // Since x might be much larger in scale we do not limit precision yet here
    }

    /**
     * Split to integer and fractional parts.
     *
     * @param x The operand.
     *
     * @return An array of two numbers <code>[i, f]</code> where <code>i</code> is <code>floor(x)</code> and <code>f</code> is <code>x - floor(x)</code>.
     */

    public Apfloat[] modf(Apfloat x)
        throws ApfloatRuntimeException
    {
        if (x.scale() > 0)
        {
            long precision = Util.ifFinite(precision(), precision() + x.scale());
            x = x.precision(precision);
        }
        else
        {
            x = setPrecision(x);
        }
        Apfloat[] modfs = ApfloatMath.modf(x);
        modfs[0] = valueOf(modfs[0]);
        modfs[1] = valueOf(modfs[1]);
        return modfs;
    }

    /**
     * Factorial.
     *
     * @param n The operand.
     *
     * @return <code>n!</code>.
     */

    public Apfloat factorial(long n)
        throws ApfloatRuntimeException
    {
        // For low precision and high n the result could be approximated faster with Stirling's formula
        return valueOf(ApfloatMath.factorial(n, precision()));
    }

    /**
     * Factorial.
     *
     * @param n The operand.
     * @param radix The radix of the result.
     *
     * @return <code>n!</code>.
     */

    public Apfloat factorial(long n, int radix)
        throws ApfloatRuntimeException
    {
        // For low precision and high n the result could be approximated faster with Stirling's formula
        return valueOf(ApfloatMath.factorial(n, precision(), radix));
    }

    /**
     * &pi;.
     *
     * @return <code>&pi;</code>.
     */

    @Override
    public Apfloat pi()
        throws ApfloatRuntimeException
    {
        return super.pi();
    }

    /**
     * &pi;.
     *
     * @param radix The radix of the result.
     *
     * @return <code>&pi;</code>.
     *
     * @exception NumberFormatException If the radix is invalid.
     */

    @Override
    public Apfloat pi(int radix)
        throws NumberFormatException, ApfloatRuntimeException
    {
        return super.pi(radix);
    }

    /**
     * Logarithm.
     *
     * @param radix The radix of the result.
     *
     * @return <code>log(radix)</code>.
     *
     * @exception NumberFormatException If the radix is invalid.
     */

    public Apfloat logRadix(int radix)
        throws NumberFormatException, ApfloatRuntimeException
    {
        return ApfloatMath.logRadix(precision(), radix);
    }

    /**
     * Fused multiply-add.
     *
     * @param a The first operand.
     * @param b The second operand.
     * @param c The third operand.
     * @param d The fourth operand.
     *
     * @return <code>a * b + c * d</code>.
     */

    public Apfloat multiplyAdd(Apfloat a, Apfloat b, Apfloat c, Apfloat d)
        throws ApfloatRuntimeException
    {
        return valueOf(ApfloatMath.multiplyAdd(setPrecision(a), setPrecision(b), setPrecision(c), setPrecision(d)));
    }

    /**
     * Fused multiply-subtract.
     *
     * @param a The first operand.
     * @param b The second operand.
     * @param c The third operand.
     * @param d The fourth operand.
     *
     * @return <code>a * b - c * d</code>.
     */

    public Apfloat multiplySubtract(Apfloat a, Apfloat b, Apfloat c, Apfloat d)
        throws ApfloatRuntimeException
    {
        return valueOf(ApfloatMath.multiplySubtract(setPrecision(a), setPrecision(b), setPrecision(c), setPrecision(d)));
    }

    /**
     * Product.
     *
     * @param x The operand(s).
     *
     * @return The product of the operands.
     */

    public Apfloat product(Apfloat... x)
        throws ApfloatRuntimeException
    {
        return valueOf(ApfloatMath.product(setPrecision(x)));
    }

    /**
     * Sum.
     *
     * @param x The operand(s).
     *
     * @return The sum of the operands.
     */

    public Apfloat sum(Apfloat... x)
        throws ApfloatRuntimeException
    {
        return valueOf(ApfloatMath.sum(setPrecision(x)));
    }

    /**
     * Gamma function.
     *
     * @param x The operand.
     *
     * @return <code>&Gamma;(x)</code>.
     *
     * @throws ArithmeticException If <code>x</code> is a nonpositive integer.
     *
     * @since 1.9.0
     */

    public Apfloat gamma(Apfloat x)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return valueOf(ApfloatMath.gamma(setGammaPrecision(x)));
    }

    /**
     * Incomplete gamma function.
     *
     * @param a The first operand.
     * @param x The second operand.
     *
     * @return <code>&Gamma;(a, x)</code>.
     *
     * @throws ArithmeticException If <code>a</code> is not a positive integer and <code>x</code> is nonpositive.
     *
     * @since 1.10.0
     */

    public Apfloat gamma(Apfloat a, Apfloat x)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return valueOf(ApfloatMath.gamma(setGammaPrecision(a), setPrecision(x)));
    }

    /**
     * Generalized incomplete gamma function.
     *
     * @param a The first operand.
     * @param x0 The second operand.
     * @param x1 The third operand.
     *
     * @return <code>&Gamma;(a, x0) - &Gamma;(a, x1)</code>.
     *
     * @throws ArithmeticException If <code>a</code> is not a positive integer and either <code>x0</code> or <code>x1</code> is nonpositive.
     *
     * @since 1.10.0
     */

    public Apfloat gamma(Apfloat a, Apfloat x0, Apfloat x1)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return valueOf(ApfloatMath.gamma(setGammaPrecision(a), setPrecision(x0), setPrecision(x1)));
    }

    /**
     * Logarithm of the gamma function.
     *
     * @param x The argument.
     *
     * @return <code>log&Gamma;(x)</code>
     *
     * @throws ArithmeticException If <code>x</code> is nonpositive.
     *
     * @since 1.11.0
     */

    public Apfloat logGamma(Apfloat x)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return valueOf(ApfloatMath.logGamma(setPrecision(x)));
    }

    /**
     * Digamma function.
     *
     * @param x The argument.
     *
     * @return <code>&psi;(x)</code>
     *
     * @throws ArithmeticException If <code>x</code> is a nonpositive integer.
     *
     * @since 1.11.0
     */

    public Apfloat digamma(Apfloat x)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return valueOf(ApfloatMath.digamma(setPrecision(x)));
    }

    /**
     * Binomial coefficient.
     *
     * @param n The argument.
     * @param k The argument.
     *
     * @return The binomial coefficient.
     *
     * @throws ArithmeticException If <code>n</code>, <code>k</code> or <code>n - k</code> is a nonpositive integer.
     *
     * @since 1.11.0
     */

    public Apfloat binomial(Apfloat n, Apfloat k)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return valueOf(ApfloatMath.binomial(setGammaPrecision(n), setGammaPrecision(k)));
    }

    /**
     * Riemann zeta function.
     *
     * @param s The argument.
     *
     * @return <code>&zeta;(s)</code>
     *
     * @throws ArithmeticException If <code>s</code> is <code>1</code>.
     *
     * @since 1.11.0
     */

    public Apfloat zeta(Apfloat s)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return valueOf(ApfloatMath.zeta(setZetaPrecision(s)));
    }

    /**
     * Hurwitz zeta function.
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

    public Apfloat zeta(Apfloat s, Apfloat a)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return valueOf(ApfloatMath.zeta(setZetaPrecision(s), setPrecision(a)));
    }

    /**
     * Confluent hypergeometric function <i><sub>0</sub>F<sub>1</sub></i>.
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

    public Apfloat hypergeometric0F1(Apfloat a, Apfloat x)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return valueOf(ApfloatMath.hypergeometric0F1(setPrecision(a), setPrecision(x)));
    }

    /**
     * Kummer confluent hypergeometric function <i><sub>1</sub>F<sub>1</sub></i>.
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

    public Apfloat hypergeometric1F1(Apfloat a, Apfloat b, Apfloat x)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return valueOf(ApfloatMath.hypergeometric1F1(setPrecision(a), setPrecision(b), setPrecision(x)));
    }

    /**
     * Hypergeometric function <i><sub>2</sub>F<sub>1</sub></i>.
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

    public Apfloat hypergeometric2F1(Apfloat a, Apfloat b, Apfloat c, Apfloat x)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return valueOf(ApfloatMath.hypergeometric2F1(setPrecision(a), setPrecision(b), setPrecision(c), setPrecision(x)));
    }

    /**
     * Return a uniformly distributed random number <code>0 &le; x &lt; 1</code>.
     *
     * @return A random number.
     *
     * @since 1.9.0
     */

    public Apfloat random()
        throws ApfloatRuntimeException
    {
        return valueOf(ApfloatMath.random(precision()));
    }

    /**
     * Return a uniformly distributed random number <code>0 &le; x &lt; 1</code>.
     *
     * @param radix The radix of the number.
     *
     * @return A random number.
     *
     * @exception NumberFormatException If the radix is invalid.
     *
     * @since 1.9.0
     */

    public Apfloat random(int radix)
        throws NumberFormatException, ApfloatRuntimeException
    {
        return valueOf(ApfloatMath.random(precision(), radix));
    }

    /**
     * Return a normally distributed random number with mean 0 and standard deviation 1.
     *
     * @return A random number.
     *
     * @since 1.9.0
     */

    public Apfloat randomGaussian()
        throws ApfloatRuntimeException
    {
        return valueOf(ApfloatMath.randomGaussian(precision()));
    }

    /**
     * Return a normally distributed random number with mean 0 and standard deviation 1.
     *
     * @param radix The radix of the number.
     *
     * @return A random number.
     *
     * @exception NumberFormatException If the radix is invalid.
     *
     * @since 1.9.0
     */

    public Apfloat randomGaussian(int radix)
        throws NumberFormatException, ApfloatRuntimeException
    {
        return valueOf(ApfloatMath.randomGaussian(precision(), radix));
    }

    /**
     * Maximum value.
     *
     * @param x The first operand.
     * @param y The second operand.
     *
     * @return The maximum of <code>x</code> and <code>y</code>.
     *
     * @since 1.9.0
     */

    public Apfloat max(Apfloat x, Apfloat y)
        throws ApfloatRuntimeException
    {
        return valueOf(ApfloatMath.max(setPrecision(x), setPrecision(y)));
    }

    /**
     * Minimum value.
     *
     * @param x The first operand.
     * @param y The second operand.
     *
     * @return The minimum of <code>x</code> and <code>y</code>.
     *
     * @since 1.9.0
     */

    public Apfloat min(Apfloat x, Apfloat y)
        throws ApfloatRuntimeException
    {
        return valueOf(ApfloatMath.min(setPrecision(x), setPrecision(y)));
    }

    /**
     * The number adjacent to the first argument in the direction of the second argument.
     *
     * @param x The first operand.
     * @param y The second operand.
     *
     * @return The number adjacent to the first argument in the direction of the second argument.
     *
     * @since 1.10.0
     */

    public Apfloat nextAfter(Apfloat x, Apfloat y)
        throws ApfloatRuntimeException
    {
        return valueOf(ApfloatMath.nextAfter(setPrecision(x), setPrecision(y)));
    }

    /**
     * The adjacent value closer to negative infinity.
     *
     * @param x The operand.
     *
     * @return The adjacent value closer to negative infinity.
     *
     * @since 1.10.0
     */

    public Apfloat nextDown(Apfloat x)
        throws ApfloatRuntimeException
    {
        return valueOf(ApfloatMath.nextDown(setPrecision(x)));
    }

    /**
     * The adjacent value closer to positive infinity.
     *
     * @param x The operand.
     *
     * @return The adjacent value closer to positive infinity.
     *
     * @since 1.10.0
     */

    public Apfloat nextUp(Apfloat x)
        throws ApfloatRuntimeException
    {
        return valueOf(ApfloatMath.nextUp(setPrecision(x)));
    }

    /**
     * Unit in the last place.
     *
     * @param x The operand.
     *
     * @return The unit in the last place.
     *
     * @since 1.10.0
     */

    public Apfloat ulp(Apfloat x)
        throws ApfloatRuntimeException
    {
        return valueOf(ApfloatMath.ulp(setPrecision(x)));
    }

    private Apfloat setPrecision(Apfloat x)
        throws ApfloatRuntimeException
    {
        return x.precision(precision());
    }

    private Apfloat[] setPrecision(Apfloat[] x)
        throws ApfloatRuntimeException
    {
        Apfloat[] tmp = new Apfloat[x.length];
        for (int i = 0; i < x.length; i++)
        {
            tmp[i] = setPrecision(x[i]);
        }
        return tmp;
    }

    private Apfloat checkSmallLinear(Apfloat x)
    {
        if (x.scale() <= -precision())
        {
            return setPrecision(x);
        }
        return null;
    }
}
