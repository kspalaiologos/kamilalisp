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

import org.apfloat.spi.Util;

/**
 * Fixed-precision mathematical functions for complex numbers.<p>
 *
 * All results of the mathematical operations are set to have the specified precision.
 * Also all input arguments are set to the specified precision before the operation.
 * If the specified precision is not infinite, this helper class also avoids 
 * <code>InfiniteExpansionException</code> e.g. in case where it would happen with
 * <code>ApcomplexMath.acos(Apcomplex.ZERO)</code>.
 *
 * @since 1.5
 * @version 1.11.0
 * @author Mikko Tommila
 */

public class FixedPrecisionApcomplexHelper
{
    /**
     * Constructs an apcomplex fixed-precison helper with the specified precision.
     * The results of all mathematical operations are set to the specified precision.
     *
     * @param precision The precision of the results.
     *
     * @exception IllegalArgumentException In case the precision is invalid.
     */

    public FixedPrecisionApcomplexHelper(long precision)
        throws IllegalArgumentException
    {
        ApfloatHelper.checkPrecision(precision);
        this.precision = precision;
    }

    /**
     * Returns the value with the specified precision.
     *
     * @param z The value.
     *
     * @return The value with to the specified precision.
     */

    public Apcomplex valueOf(Apcomplex z)
        throws ApfloatRuntimeException
    {
        return z.precision(precision());
    }

    /**
     * Negation.
     *
     * @param z The value to negate.
     *
     * @return <code>-z</code>.
     */

    public Apcomplex negate(Apcomplex z)
        throws ApfloatRuntimeException
    {
        return valueOf(z).negate();
    }

    /**
     * Complex conjugate.
     *
     * @param z The operand.
     *
     * @return <code>x - i y</code> where <code>z</code> is <code>x + i y</code>.
     */

    public Apcomplex conj(Apcomplex z)
        throws ApfloatRuntimeException
    {
        return valueOf(z).conj();
    }

    /**
     * Addition.
     *
     * @param z The first operand.
     * @param w The second operand.
     *
     * @return <code>z + w</code>.
     */

    public Apcomplex add(Apcomplex z, Apcomplex w)
        throws ApfloatRuntimeException
    {
        return valueOf(setPrecision(z).add(setPrecision(w)));
    }

    /**
     * Subtraction.
     *
     * @param z The first operand.
     * @param w The second operand.
     *
     * @return <code>z - w</code>.
     */

    public Apcomplex subtract(Apcomplex z, Apcomplex w)
        throws ApfloatRuntimeException
    {
        return valueOf(setPrecision(z).subtract(setPrecision(w)));
    }

    /**
     * Multiplication.
     *
     * @param z The first operand.
     * @param w The second operand.
     *
     * @return <code>z * w</code>.
     */

    public Apcomplex multiply(Apcomplex z, Apcomplex w)
        throws ApfloatRuntimeException
    {
        return valueOf(setPrecision(z).multiply(setPrecision(w)));
    }

    /**
     * Division.
     *
     * @param z The first operand.
     * @param w The second operand.
     *
     * @return <code>z / w</code>.
     *
     * @exception ArithmeticException If <code>w</code> is zero.
     */

    public Apcomplex divide(Apcomplex z, Apcomplex w)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return valueOf(setPrecision(z).divide(setPrecision(w)));
    }

    /**
     * Power.
     *
     * @param z The first operand.
     * @param w The second operand.
     *
     * @return <code>z<sup>w</sup></code>.
     *
     * @exception ArithmeticException If <code>z</code> and <code>w</code> are zero.
     */

    public Apcomplex pow(Apcomplex z, Apcomplex w)
        throws ArithmeticException, ApfloatRuntimeException
    {
        Apcomplex result = ApfloatHelper.checkPow(z, w, precision());
        if (result != null)
        {
            return valueOf(result);
        }
        return exp(multiply(log(z), w));
    }

    /**
     * Integer power.
     *
     * @param z The first operand.
     * @param n The first operand.
     *
     * @return <code>z<sup>n</sup></code>.
     *
     * @exception ArithmeticException If <code>z</code> and <code>n</code> are zero, or <code>z</code> is zero and <code>n</code> is negative.
     */

    public Apcomplex pow(Apcomplex z, long n)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return valueOf(ApcomplexMath.pow(setPrecision(z), n));
    }

    /**
     * Complex angle.
     *
     * @param z The operand.
     *
     * @return The angle of <code>z</code> on the complex plane.
     *
     * @exception ArithmeticException If <code>z</code> is zero.
     */

    public Apfloat arg(Apcomplex z)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return valueOf(ApcomplexMath.arg(setPrecision(z)));
    }

    /**
     * Imaginary part.
     *
     * @param z The operand.
     *
     * @return The imaginary part of <code>z</code>.
     */

    public Apfloat imag(Apcomplex z)
    {
        return valueOf(z.imag());
    }

    /**
     * Real part.
     *
     * @param z The operand.
     *
     * @return The real part of <code>z</code>.
     */

    public Apfloat real(Apcomplex z)
    {
        return valueOf(z.real());
    }

    /**
     * Absolute value.
     *
     * @param z The operand.
     *
     * @return The absolute value of <code>z</code>.
     */

    public Apfloat abs(Apcomplex z)
        throws ApfloatRuntimeException
    {
        return valueOf(ApcomplexMath.abs(setPrecision(z)));
    }

    /**
     * Norm.
     *
     * @param z The operand.
     *
     * @return <code>x<sup>2</sup> + y<sup>2</sup></code> where <code>z</code> is <code>x + i y</code>.
     */

    public Apfloat norm(Apcomplex z)
        throws ApfloatRuntimeException
    {
        return valueOf(ApcomplexMath.norm(setPrecision(z)));
    }

    /**
     * Arc cosine.
     *
     * @param z The operand.
     *
     * @return The arc cosine of <code>z</code>.
     */

    public Apcomplex acos(Apcomplex z)
        throws ApfloatRuntimeException
    {
        if (z.real().signum() == 0 && z.imag().signum() == 0)
        {
            // Zero always has infinite precision so when zero input causes nonzero output special care must be taken
            return divide(pi(z.radix()), new Apfloat(2, precision(), z.radix()));
        }
        return valueOf(ApcomplexMath.acos(setPrecision(z)));
    }

    /**
     * Hyperbolic arc cosine.
     *
     * @param z The operand.
     *
     * @return The hyperbolic arc cosine of <code>z</code>.
     */

    public Apcomplex acosh(Apcomplex z)
        throws ApfloatRuntimeException
    {
        if (z.real().signum() == 0 && z.imag().signum() == 0)
        {
            // Zero always has infinite precision so when zero input causes nonzero output special care must be taken
            return valueOf(new Apcomplex(Apfloat.ZEROS[z.radix()], pi(z.radix()).divide(new Apfloat(2, precision(), z.radix()))));
        }
        return valueOf(ApcomplexMath.acosh(setPrecision(z)));
    }

    /**
     * Arc sine.
     *
     * @param z The operand.
     *
     * @return The arc sine of <code>z</code>.
     */

    public Apcomplex asin(Apcomplex z)
        throws ApfloatRuntimeException
    {
        return valueOf(ApcomplexMath.asin(setPrecision(z)));
    }

    /**
     * Hyperbolic arc sine.
     *
     * @param z The operand.
     *
     * @return The hyperbolic arc sine of <code>z</code>.
     */

    public Apcomplex asinh(Apcomplex z)
        throws ApfloatRuntimeException
    {
        return valueOf(ApcomplexMath.asinh(setPrecision(z)));
    }

    /**
     * Arc tangent.
     *
     * @param z The operand.
     *
     * @return The arc tangent of <code>z</code>.
     *
     * @exception ArithmeticException If <code>z</code> is <code>i</code>.
     */

    public Apcomplex atan(Apcomplex z)
        throws ApfloatRuntimeException
    {
        return valueOf(ApcomplexMath.atan(setPrecision(z)));
    }

    /**
     * Hyperbolic arc tangent.
     *
     * @param z The operand.
     *
     * @return The hyperbolic arc tangent of <code>z</code>.
     *
     * @exception ArithmeticException If <code>z</code> is 1 or -1.
     */

    public Apcomplex atanh(Apcomplex z)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return valueOf(ApcomplexMath.atanh(setPrecision(z)));
    }

    /**
     * Cube root.
     *
     * @param z The operand.
     *
     * @return The cube root of <code>z</code>.
     */

    public Apcomplex cbrt(Apcomplex z)
        throws ApfloatRuntimeException
    {
        return valueOf(ApcomplexMath.cbrt(setPrecision(z)));
    }

    /**
     * Cosine.
     *
     * @param z The operand.
     *
     * @return The cosine of <code>z</code>.
     */

    public Apcomplex cos(Apcomplex z)
        throws ApfloatRuntimeException
    {
        return valueOf(ApcomplexMath.cos(setTrigExpPrecision(z)));
    }

    /**
     * Hyperbolic cosine.
     *
     * @param z The operand.
     *
     * @return The hyperbolic cosine of <code>z</code>.
     */

    public Apcomplex cosh(Apcomplex z)
        throws ApfloatRuntimeException
    {
        return valueOf(ApcomplexMath.cosh(setExpTrigPrecision(z)));
    }

    /**
     * Exponential function.
     *
     * @param z The operand.
     *
     * @return <code>e<sup>z</sup></code>.
     */

    public Apcomplex exp(Apcomplex z)
        throws ApfloatRuntimeException
    {
        return valueOf(ApcomplexMath.exp(setExpTrigPrecision(z)));
    }

    /**
     * Natural logarithm.
     *
     * @param z The operand.
     *
     * @return The natural logarithm of <code>z</code>.
     *
     * @exception ArithmeticException If <code>z</code> is zero.
     */

    public Apcomplex log(Apcomplex z)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return valueOf(ApcomplexMath.log(setLogarithmicPrecision(z)));
    }

    /**
     * Logarithm in specified base.
     *
     * @param z The operand.
     * @param w The base.
     *
     * @return The base-<code>w</code> logarithm of <code>z</code>.
     *
     * @exception ArithmeticException If <code>z</code> or <code>w</code> is zero.
     *
     * @since 1.6
     */

    public Apcomplex log(Apcomplex z, Apcomplex w)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return valueOf(ApcomplexMath.log(setPrecision(z), setPrecision(w)));
    }

    /**
     * Sine.
     *
     * @param z The operand.
     *
     * @return The sine of <code>z</code>.
     */

    public Apcomplex sin(Apcomplex z)
        throws ApfloatRuntimeException
    {
        Apcomplex result = checkSmallLinear(z);
        if (result != null)
        {
            return result;
        }
        return valueOf(ApcomplexMath.sin(setTrigExpPrecision(z)));
    }

    /**
     * Hyperbolic sine.
     *
     * @param z The operand.
     *
     * @return The hyperbolic sine of <code>z</code>.
     */

    public Apcomplex sinh(Apcomplex z)
        throws ApfloatRuntimeException
    {
        Apcomplex result = checkSmallLinear(z);
        if (result != null)
        {
            return result;
        }
        return valueOf(ApcomplexMath.sinh(setExpTrigPrecision(z)));
    }

    /**
     * Square root.
     *
     * @param z The operand.
     *
     * @return The square root of <code>z</code>.
     */

    public Apcomplex sqrt(Apcomplex z)
        throws ApfloatRuntimeException
    {
        return valueOf(ApcomplexMath.sqrt(setPrecision(z)));
    }

    /**
     * Tangent.
     *
     * @param z The operand.
     *
     * @return The tangent of <code>z</code>.
     *
     * @exception ArithmeticException If <code>z</code> is &pi;/2 + n &pi; where n is an integer.
     */

    public Apcomplex tan(Apcomplex z)
        throws ArithmeticException, ApfloatRuntimeException
    {
        Apcomplex result = checkSmallLinear(z);
        if (result != null)
        {
            return result;
        }
        return valueOf(ApcomplexMath.tanFixedPrecision(setTrigExpPrecision(z)));
    }

    /**
     * Hyperbolic tangent.
     *
     * @param z The operand.
     *
     * @return The hyperbolic tangent of <code>z</code>.
     *
     * @exception ArithmeticException If <code>z</code> is i (&pi;/2 + n &pi;) where n is an integer.
     */

    public Apcomplex tanh(Apcomplex z)
        throws ArithmeticException, ApfloatRuntimeException
    {
        Apcomplex result = checkSmallLinear(z);
        if (result != null)
        {
            return result;
        }
        return valueOf(ApcomplexMath.tanhFixedPrecision(setExpTrigPrecision(z)));
    }

    /**
     * Arithmetic-geometric mean.
     *
     * @param a The first operand.
     * @param b The first operand.
     *
     * @return The arithmetic-geometric mean of <code>a</code> and <code>b</code>.
     */

    public Apcomplex agm(Apcomplex a, Apcomplex b)
        throws ApfloatRuntimeException
    {
        return valueOf(ApcomplexMath.agm(setPrecision(a), setPrecision(b)));
    }

    /**
     * Inverse root.
     *
     * @param z The operand.
     * @param n Which inverse root to take.
     *
     * @return <code>z<sup>-1/n</sup></code>.
     *
     * @exception ArithmeticException If <code>z</code> or <code>n</code> is zero.
     */

    public Apcomplex inverseRoot(Apcomplex z, long n)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return valueOf(ApcomplexMath.inverseRoot(setPrecision(z), n));
    }

    /**
     * Inverse root with branch.
     *
     * @param z The operand.
     * @param n Which inverse root to take.
     * @param k Which branch to take.
     *
     * @return <code>z<sup>-1/n</sup>e<sup>-i2&pi;k/n</sup></code>.
     *
     * @exception ArithmeticException If <code>z</code> or <code>n</code> is zero.
     */

    public Apcomplex inverseRoot(Apcomplex z, long n, long k)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return valueOf(ApcomplexMath.inverseRoot(setPrecision(z), n, k));
    }

    /**
     * Root.
     *
     * @param z The operand.
     * @param n Which root to take.
     *
     * @return <code>z<sup>1/n</sup></code>.
     *
     * @exception ArithmeticException If <code>n</code> is zero, or <code>z</code> is zero and <code>n</code> is negative.
     */

    public Apcomplex root(Apcomplex z, long n)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return valueOf(ApcomplexMath.root(setPrecision(z), n));
    }

    /**
     * Root with branch.
     *
     * @param z The operand.
     * @param n Which root to take.
     * @param k Which branch to take.
     *
     * @return <code>z<sup>1/n</sup>e<sup>i2&pi;sk/n</sup></code> where <code>s</code> is the signum of the imaginary part of <code>z</code>.
     *
     * @exception ArithmeticException If <code>n</code> is zero, or <code>z</code> is zero and <code>n</code> is negative.
     */

    public Apcomplex root(Apcomplex z, long n, long k)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return valueOf(ApcomplexMath.root(setPrecision(z), n, k));
    }

    /**
     * All branches of a root.
     *
     * @param z The operand.
     * @param n Which root to take.
     *
     * @return <code>z<sup>1/n</sup></code>.
     *
     * @exception ArithmeticException If <code>n</code> is zero, or <code>z</code> is zero and <code>n</code> is negative.
     */

    public Apcomplex[] allRoots(Apcomplex z, int n)
        throws ArithmeticException, ApfloatRuntimeException
    {
        Apcomplex[] allRoots = ApcomplexMath.allRoots(setPrecision(z), n);
        for (int i = 0; i < allRoots.length; i++)
        {
            allRoots[i] = valueOf(allRoots[i]);
        }
        return allRoots;
    }

    /**
     * Move the radix point.
     *
     * @param z The operand.
     * @param scale The amount to move the radix point.
     *
     * @return <code>z * z.radix()<sup>scale</sup></code>.
     */

    public Apcomplex scale(Apcomplex z, long scale)
        throws ApfloatRuntimeException
    {
        return ApcomplexMath.scale(valueOf(z), scale);
    }

    /**
     * Lambert W function.
     *
     * @param z The operand.
     *
     * @return <code>W<sub>0</sub>(z)</code>.
     *
     * @since 1.8.0
     */

    public Apcomplex w(Apcomplex z)
        throws ApfloatRuntimeException
    {
        return valueOf(ApcomplexMath.w(setPrecision(z)));
    }

    /**
     * Lambert W function for the specified branch.
     *
     * @param z The operand.
     * @param k The branch.
     *
     * @return <code>W<sub>k</sub>(z)</code>.
     *
     * @since 1.8.0
     */

    public Apcomplex w(Apcomplex z, long k)
        throws ApfloatRuntimeException
    {
        return valueOf(ApcomplexMath.w(setPrecision(z), k));
    }

    /**
     * Product.
     *
     * @param z The operand(s).
     *
     * @return The product of the operands.
     */

    public Apcomplex product(Apcomplex... z)
        throws ApfloatRuntimeException
    {
        return valueOf(ApcomplexMath.product(setPrecision(z)));
    }

    /**
     * Sum.
     *
     * @param z The operand(s).
     *
     * @return The sum of the operands.
     */

    public Apcomplex sum(Apcomplex... z)
        throws ApfloatRuntimeException
    {
        // This is not entirely optimal as the real and imaginary parts might have different scales and one of them could have thus reduced precision
        return valueOf(ApcomplexMath.sum(setPrecision(z)));
    }

    /**
     * <i>e</i>.
     *
     * @return <i>e</i>.
     *
     * @since 1.11.0
     */

    public Apfloat e()
        throws ApfloatRuntimeException
    {
        return ApfloatMath.e(precision());
    }

    /**
     * <i>e</i>.
     *
     * @param radix The radix of the result.
     *
     * @return <i>e</i>.
     *
     * @throws NumberFormatException If the radix is invalid.
     *
     * @since 1.11.0
     */

    public Apfloat e(int radix)
        throws NumberFormatException, ApfloatRuntimeException
    {
        return ApfloatMath.e(precision(), radix);
    }

    /**
     * &gamma;, the Euler-Mascheroni constant.
     *
     * @return <code>&gamma;</code>.
     *
     * @since 1.11.0
     */

    public Apfloat euler()
        throws ApfloatRuntimeException
    {
        return ApfloatMath.euler(precision());
    }

    /**
     * &gamma;, the Euler-Mascheroni constant.
     *
     * @param radix The radix of the result.
     *
     * @return <code>&gamma;</code>.
     *
     * @throws NumberFormatException If the radix is invalid.
     *
     * @since 1.11.0
     */

    public Apfloat euler(int radix)
        throws NumberFormatException, ApfloatRuntimeException
    {
        return ApfloatMath.euler(precision(), radix);
    }

    /**
     * Catalan's constant <i>G</i>.
     *
     * @return <i>G</i>.
     *
     * @since 1.11.0
     */

    public Apfloat catalan()
        throws ApfloatRuntimeException
    {
        return ApfloatMath.catalan(precision());
    }

    /**
     * Catalan's constant <i>G</i>.
     *
     * @param radix The radix of the result.
     *
     * @return <i>G</i>.
     *
     * @throws NumberFormatException If the radix is invalid.
     *
     * @since 1.11.0
     */

    public Apfloat catalan(int radix)
        throws NumberFormatException, ApfloatRuntimeException
    {
        return ApfloatMath.catalan(precision(), radix);
    }

    /**
     * The Glaisher-Kinkelin constant <i>A</i>.
     *
     * @return <i>A</i>.
     *
     * @since 1.11.0
     */

    public Apfloat glaisher()
        throws ApfloatRuntimeException
    {
        return ApfloatMath.glaisher(precision());
    }

    /**
     * The Glaisher-Kinkelin constant <i>A</i>.
     *
     * @param radix The radix of the result.
     *
     * @return <i>A</i>.
     *
     * @throws NumberFormatException If the radix is invalid.
     *
     * @since 1.11.0
     */

    public Apfloat glaisher(int radix)
        throws NumberFormatException, ApfloatRuntimeException
    {
        return ApfloatMath.glaisher(precision(), radix);
    }

    /**
     * Khinchin's constant <i>K</i>.
     *
     * @return <i>K</i>.
     *
     * @since 1.11.0
     */

    public Apfloat khinchin()
        throws ApfloatRuntimeException
    {
        return ApfloatMath.khinchin(precision());
    }

    /**
     * Khinchin's constant <i>K</i>.
     *
     * @param radix The radix of the result.
     *
     * @return <i>K</i>.
     *
     * @throws NumberFormatException If the radix is invalid.
     *
     * @since 1.11.0
     */

    public Apfloat khinchin(int radix)
        throws NumberFormatException, ApfloatRuntimeException
    {
        return ApfloatMath.khinchin(precision(), radix);
    }

    /**
     * Gamma function.
     *
     * @param z The operand.
     *
     * @return <code>&Gamma;(z)</code>.
     *
     * @throws ArithmeticException If <code>z</code> is a nonpositive integer.
     *
     * @since 1.9.0
     */

    public Apcomplex gamma(Apcomplex z)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return valueOf(ApcomplexMath.gamma(setGammaPrecision(z)));
    }

    /**
     * Incomplete gamma function.
     *
     * @param a The first operand.
     * @param z The second operand.
     *
     * @return <code>&Gamma;(a, z)</code>.
     *
     * @throws ArithmeticException If <code>a</code> is a nonpositive integer and <code>z</code> is zero.
     *
     * @since 1.10.0
     */

    public Apcomplex gamma(Apcomplex a, Apcomplex z)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return valueOf(ApcomplexMath.gamma(setGammaPrecision(a), setPrecision(z)));
    }

    /**
     * Generalized incomplete gamma function.
     *
     * @param a The first operand.
     * @param z0 The second operand.
     * @param z1 The third operand.
     *
     * @return <code>&Gamma;(a, z0)</code> - <code>&Gamma;(a, z1)</code>.
     *
     * @throws ArithmeticException If <code>a</code> is a nonpositive integer and either <code>z0</code> or <code>z1</code> is zero.
     *
     * @since 1.10.0
     */

    public Apcomplex gamma(Apcomplex a, Apcomplex z0, Apcomplex z1)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return valueOf(ApcomplexMath.gamma(setGammaPrecision(a), setPrecision(z0), setPrecision(z1)));
    }

    /**
     * Logarithm of the gamma function.
     *
     * @param z The argument.
     *
     * @return <code>log&Gamma;(z)</code>
     *
     * @throws ArithmeticException If <code>z</code> is a nonpositive integer.
     *
     * @since 1.11.0
     */

    public Apcomplex logGamma(Apcomplex z)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return valueOf(ApcomplexMath.logGamma(setPrecision(z)));
    }

    /**
     * Digamma function.
     *
     * @param z The argument.
     *
     * @return <code>&psi;(z)</code>
     *
     * @throws ArithmeticException If <code>z</code> is a nonpositive integer.
     *
     * @since 1.11.0
     */

    public Apcomplex digamma(Apcomplex z)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return valueOf(ApcomplexMath.digamma(setPrecision(z)));
    }

    /**
     * Binomial coefficient.
     *
     * @param n The argument.
     * @param k The argument.
     *
     * @return The binomial coefficient.
     *
     * @throws ArithmeticException If <code>n</code> or <code>k</code> is negative.
     *
     * @since 1.11.0
     */

    public Apfloat binomial(long n, long k)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return valueOf(ApintMath.binomial(n, k));
    }

    /**
     * Binomial coefficient.
     *
     * @param n The argument.
     * @param k The argument.
     * @param radix The radix.
     *
     * @return The binomial coefficient.
     *
     * @throws ArithmeticException If <code>n</code> or <code>k</code> is negative.
     * @throws NumberFormatException If the radix is not valid.
     *
     * @since 1.11.0
     */

    public Apfloat binomial(long n, long k, int radix)
        throws ArithmeticException, NumberFormatException, ApfloatRuntimeException
    {
        return valueOf(ApintMath.binomial(n, k, radix));
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

    public Apcomplex binomial(Apcomplex n, Apcomplex k)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return valueOf(ApcomplexMath.binomial(setGammaPrecision(n), setGammaPrecision(k)));
    }

    /**
     * Bernoulli number.
     *
     * @param n The argument.
     *
     * @return <code>B<sub>n</sub></code>
     *
     * @throws IllegalArgumentException If <code>n &lt; 0</code>.
     *
     * @since 1.11.0
     */

    public Apfloat bernoulli(long n)
        throws IllegalArgumentException, ApfloatRuntimeException
    {
        return valueOf(AprationalMath.bernoulli(n));
    }

    /**
     * Bernoulli number.
     *
     * @param n The argument.
     * @param radix The radix.
     *
     * @return <code>B<sub>n</sub></code>
     *
     * @throws IllegalArgumentException If <code>n &lt; 0</code>.
     * @throws NumberFormatException If the radix is not valid.
     *
     * @since 1.11.0
     */

    public Apfloat bernoulli(long n, int radix)
        throws IllegalArgumentException, NumberFormatException, ApfloatRuntimeException
    {
        return valueOf(AprationalMath.bernoulli(n, radix));
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

    public Apcomplex zeta(Apcomplex s)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return valueOf(ApcomplexMath.zeta(setZetaPrecision(s)));
    }

    /**
     * Hurwitz zeta function.
     *
     * @param s The first argument.
     * @param a The second argument.
     *
     * @return <code>&zeta;(s, a)</code>
     *
     * @throws ArithmeticException If <code>s</code> is <code>1</code> or if <code>a</code> is a nonpositive integer.
     *
     * @since 1.11.0
     */

    public Apcomplex zeta(Apcomplex s, Apcomplex a)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return valueOf(ApcomplexMath.zeta(setZetaPrecision(s), setPrecision(a)));
    }

    /**
     * Confluent hypergeometric function <i><sub>0</sub>F<sub>1</sub></i>.
     *
     * @param a The first argument.
     * @param z The second argument.
     *
     * @return <i><sub>0</sub>F<sub>1</sub>(; a; z)</i>
     *
     * @throws ArithmeticException If the function value is not finite.
     *
     * @since 1.11.0
     */

    public Apcomplex hypergeometric0F1(Apcomplex a, Apcomplex z)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return valueOf(ApcomplexMath.hypergeometric0F1(setPrecision(a), setPrecision(z)));
    }

    /**
     * Kummer confluent hypergeometric function <i><sub>1</sub>F<sub>1</sub></i>.
     *
     * @param a The first argument.
     * @param b The second argument.
     * @param z The third argument.
     *
     * @return <i><sub>1</sub>F<sub>1</sub>(a; b; z)</i>
     *
     * @throws ArithmeticException If the function value is not finite.
     *
     * @since 1.11.0
     */

    public Apcomplex hypergeometric1F1(Apcomplex a, Apcomplex b, Apcomplex z)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return valueOf(ApcomplexMath.hypergeometric1F1(setPrecision(a), setPrecision(b), setPrecision(z)));
    }

    /**
     * Hypergeometric function <i><sub>2</sub>F<sub>1</sub></i>.
     *
     * @param a The first argument.
     * @param b The second argument.
     * @param c The third argument.
     * @param z The fourth argument.
     *
     * @return <i><sub>2</sub>F<sub>1</sub>(a, b; c; z)</i>
     *
     * @throws ArithmeticException If the function value is not finite.
     *
     * @since 1.11.0
     */

    public Apcomplex hypergeometric2F1(Apcomplex a, Apcomplex b, Apcomplex c, Apcomplex z)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return valueOf(ApcomplexMath.hypergeometric2F1(setPrecision(a), setPrecision(b), setPrecision(c), setPrecision(z)));
    }

    /**
     * Unit in the last place.
     *
     * @param z The operand.
     *
     * @return The unit in the last place.
     *
     * @since 1.10.0
     */

    public Apfloat ulp(Apcomplex z)
        throws ApfloatRuntimeException
    {
        return valueOf(ApcomplexMath.ulp(setPrecision(z)));
    }

    /**
     * Returns the precision, which is used for the results.
     *
     * @return The precision of the results.
     */

    public long precision()
    {
        return this.precision;
    }

    Apfloat valueOf(Apfloat x)
        throws ApfloatRuntimeException
    {
        return x.precision(precision());
    }

    Apfloat pi()
        throws ApfloatRuntimeException
    {
        return ApfloatMath.pi(precision());
    }

    Apfloat pi(int radix)
        throws NumberFormatException, ApfloatRuntimeException
    {
        return ApfloatMath.pi(precision(), radix);
    }

    Apfloat setTrigonometricPrecision(Apfloat x)
        throws ApfloatRuntimeException
    {
        long precision = ApfloatHelper.extendPrecision(precision(), Math.max(0, x.scale()));
        return x.precision(precision);
    }

    Apfloat setExponentialPrecision(Apfloat x)
        throws ApfloatRuntimeException
    {
        if (x.scale() <= -precision())
        {
            // Result will be rounded to one so avoid heavy high-precision calculation
            x = new Apfloat(0, Apfloat.DEFAULT, x.radix());
        }
        else if (x.scale() < 0)
        {
            // Taylor series would increase precision, thus reduce it
            long precision = Util.ifFinite(precision(), precision() + x.scale());
            x = x.precision(precision);
        }
        else if (x.scale() > 1)
        {
            // Very large inputs have decreased precision, thus increase it
            long precision = Util.ifFinite(precision(), precision() + x.scale() - 1);
            x = x.precision(precision);
        }
        else
        {
            x = x.precision(precision());
        }
        return x;
    }

    Apfloat setLogarithmicPrecision(Apfloat x)
        throws ApfloatRuntimeException
    {
        long precision = ApfloatHelper.extendPrecision(precision(), x.equalDigits(new Apfloat(1, Apfloat.INFINITE, x.radix())));
        return x.precision(precision);
    }

    Apfloat setGammaPrecision(Apfloat x)
    {
        return setTrigonometricPrecision(x);
    }

    Apfloat setZetaPrecision(Apfloat x)
    {
        return setTrigonometricPrecision(x);
    }

    private Apcomplex setPrecision(Apcomplex z)
        throws ApfloatRuntimeException
    {
        return z.precision(precision());
    }

    private Apcomplex[] setPrecision(Apcomplex[] z)
        throws ApfloatRuntimeException
    {
        Apcomplex[] tmp = new Apcomplex[z.length];
        for (int i = 0; i < z.length; i++)
        {
            tmp[i] = setPrecision(z[i]);
        }
        return tmp;
    }

    private Apcomplex setExpTrigPrecision(Apcomplex z)
    {
        return new Apcomplex(setExponentialPrecision(z.real()), setTrigonometricPrecision(z.imag()));
    }

    private Apcomplex setTrigExpPrecision(Apcomplex z)
    {
        return new Apcomplex(setTrigonometricPrecision(z.real()), setExponentialPrecision(z.imag()));
    }

    private Apcomplex setLogarithmicPrecision(Apcomplex z)
    {
        long precision = ApfloatHelper.extendPrecision(precision(), abs(z).equalDigits(new Apfloat(1, Apfloat.INFINITE, z.radix())));
        return z.precision(precision);
    }

    private Apcomplex setGammaPrecision(Apcomplex z)
    {
        long precision = ApfloatHelper.extendPrecision(precision(), Math.max(0, z.scale()));
        return z.precision(precision);
    }

    private Apcomplex setZetaPrecision(Apcomplex z)
    {
        return new Apcomplex(setZetaPrecision(z.real()), setTrigonometricPrecision(z.imag()));
    }

    private Apcomplex checkSmallLinear(Apcomplex z)
    {
        if (z.scale() <= -precision())
        {
            return setPrecision(z);
        }
        return null;
    }

    private long precision;
}
