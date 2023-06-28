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
import java.util.Comparator;
import java.util.Iterator;
import java.util.Queue;
import java.util.PriorityQueue;

import org.apfloat.spi.Util;

/**
 * Various mathematical functions for arbitrary precision complex numbers.
 *
 * @see ApfloatMath
 *
 * @version 1.11.0
 * @author Mikko Tommila
 */

public class ApcomplexMath
{
    private ApcomplexMath()
    {
    }

    /**
     * Negative value.
     *
     * @deprecated Use {@link Apcomplex#negate()}.
     *
     * @param z The argument.
     *
     * @return <code>-z</code>.
     */

    @Deprecated
    public static Apcomplex negate(Apcomplex z)
        throws ApfloatRuntimeException
    {
        return z.negate();
    }

    /**
     * Absolute value.
     *
     * @param z The argument.
     *
     * @return <code>sqrt(x<sup>2</sup> + y<sup>2</sup>)</code>, where <code>z = x + <i>i</i> y</code>.
     */

    public static Apfloat abs(Apcomplex z)
        throws ApfloatRuntimeException
    {
        if (z.real().signum() == 0)
        {
             return ApfloatMath.abs(z.imag());
        }
        else if (z.imag().signum() == 0)
        {
             return ApfloatMath.abs(z.real());
        }
        else
        {
             return ApfloatMath.sqrt(norm(z));
        }
    }

    /**
     * Norm. Square of the magnitude.
     *
     * @param z The argument.
     *
     * @return <code>x<sup>2</sup> + y<sup>2</sup></code>, where <code>z = x + <i>i</i> y</code>.
     */

    public static Apfloat norm(Apcomplex z)
        throws ApfloatRuntimeException
    {
        return ApfloatMath.multiplyAdd(z.real(), z.real(), z.imag(), z.imag());
    }

    /**
     * Angle of the complex vector in the complex plane.
     *
     * @param z The argument.
     *
     * @return <code>arctan(y / x)</code> from the appropriate branch, where <code>z = x + <i>i</i> y</code>.
     *
     * @exception ArithmeticException If <code>z</code> is zero.
     */

    public static Apfloat arg(Apcomplex z)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return ApfloatMath.atan2(z.imag(), z.real());
    }

    /**
     * Multiply by a power of the radix.
     *
     * @param z The argument.
     * @param scale The scaling factor.
     *
     * @return <code>z * z.radix()<sup>scale</sup></code>.
     */

    public static Apcomplex scale(Apcomplex z, long scale)
        throws ApfloatRuntimeException
    {
        return new Apcomplex(ApfloatMath.scale(z.real(), scale),
                             ApfloatMath.scale(z.imag(), scale));
    }

    /**
     * Integer power.
     *
     * @param z Base of the power operator.
     * @param n Exponent of the power operator.
     *
     * @return <code>z</code> to the <code>n</code>:th power, that is <code>z<sup>n</sup></code>.
     *
     * @exception ArithmeticException If both <code>z</code> and <code>n</code> are zero.
     */

    public static Apcomplex pow(Apcomplex z, long n)
        throws ArithmeticException, ApfloatRuntimeException
    {
        if (n == 0)
        {
            if (z.real().signum() == 0 && z.imag().signum() == 0)
            {
                throw new ArithmeticException("Zero to power zero");
            }

            return new Apcomplex(new Apfloat(1, Apfloat.INFINITE, z.radix()));
        }
        else if (n < 0)
        {
            z = Apcomplex.ONES[z.radix()].divide(z);
            n = -n;
        }

        return powAbs(z, n);
    }

    // Absolute value of n used
    private static Apcomplex powAbs(Apcomplex z, long n)
        throws ArithmeticException, ApfloatRuntimeException
    {
        long precision = z.precision();
        z = ApfloatHelper.extendPrecision(z);   // Big exponents will accumulate round-off errors

        // Algorithm improvements by Bernd Kellner
        int b2pow = 0;

        while ((n & 1) == 0)
        {
            b2pow++;
            n >>>= 1;
        }

        Apcomplex r = z;

        while ((n >>>= 1) > 0)
        {
            z = z.multiply(z);
            if ((n & 1) != 0)
            {
                r = r.multiply(z);
            }
        }

        while (b2pow-- > 0)
        {
            r = r.multiply(r);
        }

        return ApfloatHelper.setPrecision(r, precision);
    }

    /**
     * Square root.
     *
     * @param z The argument.
     *
     * @return Square root of <code>z</code>.
     */

    public static Apcomplex sqrt(Apcomplex z)
        throws ApfloatRuntimeException
    {
        return root(z, 2);
    }

    /**
     * Cube root.
     *
     * @param z The argument.
     *
     * @return Cube root of <code>z</code>.
     */

    public static Apcomplex cbrt(Apcomplex z)
        throws ApfloatRuntimeException
    {
        return root(z, 3);
    }

    /**
     * Positive integer root. The branch that has the smallest angle
     * and same sign of imaginary part as <code>z</code> is always chosen.
     *
     * @param z The argument.
     * @param n Which root to take.
     *
     * @return <code>n</code>:th root of <code>z</code>, that is <code>z<sup>1/n</sup></code>.
     *
     * @exception ArithmeticException If <code>n</code> is zero.
     */

    public static Apcomplex root(Apcomplex z, long n)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return root(z, n, 0);
    }

    /**
     * Positive integer root. The specified branch counting from the smallest angle
     * and same sign of imaginary part as <code>z</code> is chosen.
     *
     * @param z The argument.
     * @param n Which root to take.
     * @param k Which branch to take.
     *
     * @return <code>n</code>:th root of <code>z</code>, that is <code>z<sup>1/n</sup>e<sup>i2&pi;sk/n</sup></code> where <code>s</code> is the signum of the imaginary part of <code>z</code>.
     *
     * @exception ArithmeticException If <code>n</code> is zero.
     *
     * @since 1.5
     */

    public static Apcomplex root(Apcomplex z, long n, long k)
        throws ArithmeticException, ApfloatRuntimeException
    {
        if (n == 0)
        {
            throw new ArithmeticException("Zeroth root");
        }
        else if (z.real().signum() == 0 && z.imag().signum() == 0)
        {
            if (n < 0)
            {
                throw new ArithmeticException("Inverse root of zero");
            }
            return Apcomplex.ZEROS[z.radix()];  // Avoid division by zero
        }
        else if (n == 1)
        {
            return z;
        }
        k %= n;
        if (z.imag().signum() == 0 && z.real().signum() > 0 && k == 0)
        {
            return new Apcomplex(ApfloatMath.root(z.real(), n));
        }
        else if (n < 0)                         // Also correctly handles 0x8000000000000000L
        {
            return inverseRootAbs(z, -n, k);
        }
        else if (n == 2)
        {
            return z.multiply(inverseRootAbs(z, 2, k));
        }
        else if (n == 3)
        {
            // Choose the correct branch
            if (z.real().signum() < 0)
            {
                k = (z.imag().signum() == 0 ? 1 - k : k - 1);
                k %= n;
            }
            else
            {
                k = -k;
            }
            Apcomplex w = z.multiply(z);
            return z.multiply(inverseRootAbs(w, 3, k));
        }
        else
        {
            return inverseRootAbs(inverseRootAbs(z, n, k), 1, 0);
        }
    }

    /**
     * Inverse positive integer root. The branch that has the smallest angle
     * and different sign of imaginary part than <code>z</code> is always chosen.
     *
     * @param z The argument.
     * @param n Which inverse root to take.
     *
     * @return Inverse <code>n</code>:th root of <code>z</code>, that is <code>z<sup>-1/n</sup></code>.
     *
     * @exception ArithmeticException If <code>z</code> or <code>n</code> is zero.
     */

    public static Apcomplex inverseRoot(Apcomplex z, long n)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return inverseRoot(z, n, 0);
    }

    /**
     * Inverse positive integer root. The specified branch counting from the smallest angle
     * and different sign of imaginary part than <code>z</code> is chosen.
     *
     * @param z The argument.
     * @param n Which inverse root to take.
     * @param k Which branch to take.
     *
     * @return Inverse <code>n</code>:th root of <code>z</code>, that is <code>z<sup>-1/n</sup>e<sup>-i2&pi;k/n</sup></code>.
     *
     * @exception ArithmeticException If <code>z</code> or <code>n</code> is zero.
     */

    public static Apcomplex inverseRoot(Apcomplex z, long n, long k)
        throws ArithmeticException, ApfloatRuntimeException
    {
        if (z.real().signum() == 0 && z.imag().signum() == 0)
        {
            throw new ArithmeticException("Inverse root of zero");
        }
        else if (n == 0)
        {
            throw new ArithmeticException("Inverse zeroth root");
        }
        k %= n;
        if (z.imag().signum() == 0 && z.real().signum() > 0 && k == 0)
        {
            return new Apcomplex(ApfloatMath.inverseRoot(z.real(), n));
        }
        else if (n < 0)
        {
            return inverseRootAbs(inverseRootAbs(z, -n, k), 1, 0);      // Also correctly handles 0x8000000000000000L
        }

        return inverseRootAbs(z, n, k);
    }

    // Absolute value of n used
    private static Apcomplex inverseRootAbs(Apcomplex z, long n, long k)
        throws ArithmeticException, ApfloatRuntimeException
    {
        if (z.equals(Apcomplex.ONE) && k == 0)
        {
            // Trivial case
            return z;
        }
        else if (n == 2 && z.imag().signum() == 0 && z.real().signum() < 0)
        {
            // Avoid round-off errors and produce a pure imaginary result
            Apfloat y = ApfloatMath.inverseRoot(z.real().negate(), n);
            return new Apcomplex(Apfloat.ZEROS[z.radix()], k == 0 ? y.negate() : y);
        }

        long targetPrecision = z.precision();

        if (targetPrecision == Apfloat.INFINITE)
        {
            throw new InfiniteExpansionException("Cannot calculate inverse root to infinite precision");
        }

        Apfloat one = new Apfloat(1, Apfloat.INFINITE, z.radix()),
                divisor = ApfloatMath.abs(new Apfloat(n, Apfloat.INFINITE, z.radix()));

        double doubleReal,
               doubleImag,
               magnitude,
               angle,
               doubleN = Math.abs((double) n);

        long realScale = z.real().scale(),
             imagScale = z.imag().scale(),
             scale = Math.max(realScale, imagScale),
             scaleDiff = scale - Math.min(realScale, imagScale),
             doublePrecision = ApfloatHelper.getDoublePrecision(z.radix()),
             precision = doublePrecision,       // Accuracy of initial guess
             scaleQuot = scale / n,             // If n is 0x8000000000000000 then this will be zero
             scaleRem = scale - scaleQuot * n;
        double scaleRemFactor = Math.pow((double) z.radix(), (double) -scaleRem / doubleN);

        Apcomplex result;

        // Calculate initial guess from z
        if (z.imag().signum() == 0 ||
            (scaleDiff > doublePrecision / 2 || scaleDiff < 0) && realScale > imagScale)        // Detect overflow
        {
            // z.real() is a lot bigger in magnitude than z.imag()
            Apfloat tmpReal = z.real().precision(doublePrecision),
                    tmpImag = z.imag().precision(doublePrecision);
            Apcomplex tweak = new Apcomplex(Apfloat.ZERO,
                                            tmpImag.divide(divisor.multiply(tmpReal)));

            tmpReal = ApfloatMath.scale(tmpReal, -tmpReal.scale());     // Allow exponents in excess of doubles'

            if ((magnitude = tmpReal.doubleValue()) >= 0.0)
            {
                doubleReal = Math.pow(magnitude, -1.0 / doubleN) * scaleRemFactor;
                doubleImag = 0.0;
            }
            else
            {
                magnitude = Math.pow(-magnitude, -1.0 / doubleN) * scaleRemFactor;
                angle = (tmpImag.signum() >= 0 ? -Math.PI : Math.PI) / doubleN;
                doubleReal = magnitude * Math.cos(angle);
                doubleImag = magnitude * Math.sin(angle);
            }

            tmpReal = ApfloatMath.scale(new Apfloat(doubleReal, doublePrecision, z.radix()), -scaleQuot);
            tmpImag = ApfloatMath.scale(new Apfloat(doubleImag, doublePrecision, z.radix()), -scaleQuot);
            result = new Apcomplex(tmpReal, tmpImag);
            result = result.subtract(result.multiply(tweak));               // Must not be real
        }
        else if (z.real().signum() == 0 ||
                 (scaleDiff > doublePrecision / 2 || scaleDiff < 0) && imagScale > realScale)        // Detect overflow
        {
            // z.imag() is a lot bigger in magnitude than z.real()
            Apfloat tmpReal = z.real().precision(doublePrecision),
                    tmpImag = z.imag().precision(doublePrecision);
            Apcomplex tweak = new Apcomplex(Apfloat.ZERO,
                                            tmpReal.divide(divisor.multiply(tmpImag)));

            tmpImag = ApfloatMath.scale(tmpImag, -tmpImag.scale());     // Allow exponents in exess of doubles'

            if ((magnitude = tmpImag.doubleValue()) >= 0.0)
            {
                magnitude = Math.pow(magnitude, -1.0 / doubleN) * scaleRemFactor;
                angle = -Math.PI / (2.0 * doubleN);
            }
            else
            {
                magnitude = Math.pow(-magnitude, -1.0 / doubleN) * scaleRemFactor;
                angle = Math.PI / (2.0 * doubleN);
            }

            doubleReal = magnitude * Math.cos(angle);
            doubleImag = magnitude * Math.sin(angle);

            tmpReal = ApfloatMath.scale(new Apfloat(doubleReal, doublePrecision, z.radix()), -scaleQuot);
            tmpImag = ApfloatMath.scale(new Apfloat(doubleImag, doublePrecision, z.radix()), -scaleQuot);
            result = new Apcomplex(tmpReal, tmpImag);
            result = result.add(result.multiply(tweak));               // Must not be pure imaginary
        }
        else
        {
            // z.imag() and z.real() approximately the same in magnitude
            Apfloat tmpReal = z.real().precision(doublePrecision),
                    tmpImag = z.imag().precision(doublePrecision);

            tmpReal = ApfloatMath.scale(tmpReal, -scale);       // Allow exponents in exess of doubles'
            tmpImag = ApfloatMath.scale(tmpImag, -scale);       // Allow exponents in exess of doubles'

            doubleReal = tmpReal.doubleValue();
            doubleImag = tmpImag.doubleValue();

            magnitude = Math.pow(doubleReal * doubleReal + doubleImag * doubleImag, -1.0 / (2.0 * doubleN)) * scaleRemFactor;
            angle = -Math.atan2(doubleImag, doubleReal) / doubleN;

            doubleReal = magnitude * Math.cos(angle);
            doubleImag = magnitude * Math.sin(angle);

            tmpReal = ApfloatMath.scale(new Apfloat(doubleReal, doublePrecision, z.radix()), -scaleQuot);
            tmpImag = ApfloatMath.scale(new Apfloat(doubleImag, doublePrecision, z.radix()), -scaleQuot);
            result = new Apcomplex(tmpReal, tmpImag);
        }

        // Alter the angle by the branch chosen
        if (k != 0)
        {
            Apcomplex branch;
            // Handle exact cases
            k = (k < 0 ? k + n : k);
            if (n % 4 == 0 && (n >>> 2) == k)
            {
                branch = new Apcomplex(Apfloat.ZERO, one);
            }
            else if (n % 4 == 0 && (n >>> 2) * 3 == k)
            {
                branch = new Apcomplex(Apfloat.ZERO, one.negate());
            }
            else if (n % 2 == 0 && (n >>> 1) == k)
            {
                branch = one.negate();
            }
            else
            {
                angle = 2.0 * Math.PI * (double) k / doubleN;
                doubleReal = Math.cos(angle);
                doubleImag = Math.sin(angle);
                Apfloat tmpReal = new Apfloat(doubleReal, doublePrecision, z.radix());
                Apfloat tmpImag = new Apfloat(doubleImag, doublePrecision, z.radix());
                branch = new Apcomplex(tmpReal, tmpImag);
            }
            result = result.multiply(z.imag().signum() >= 0 ? branch.conj() : branch);
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
            if ((minPrec - Apcomplex.EXTRA_PRECISION) << precisingIteration >= targetPrecision)
            {
                break;
            }
        }

        z = ApfloatHelper.extendPrecision(z);

        // Newton's iteration
        while (iterations-- > 0)
        {
            precision *= 2;
            result = ApfloatHelper.setPrecision(result, Math.min(precision, targetPrecision));

            Apcomplex t = powAbs(result, n);
            t = lastIterationExtendPrecision(iterations, precisingIteration, t);
            t = one.subtract(z.multiply(t));
            if (iterations < precisingIteration)
            {
                t = new Apcomplex(t.real().precision(precision / 2),
                                  t.imag().precision(precision / 2));
            }

            result = lastIterationExtendPrecision(iterations, precisingIteration, result);
            result = result.add(result.multiply(t).divide(divisor));

            // Precising iteration
            if (iterations == precisingIteration)
            {
                t = powAbs(result, n);
                t = lastIterationExtendPrecision(iterations, -1, t);

                result = lastIterationExtendPrecision(iterations, -1, result);
                result = result.add(result.multiply(one.subtract(z.multiply(t))).divide(divisor));
            }
        }

        return ApfloatHelper.setPrecision(result, targetPrecision);
    }

    /**
     * All values of the positive integer root.<p>
     *
     * Returns all of the <code>n</code> values of the root, in the order
     * of the angle, starting from the smallest angle and same sign of
     * imaginary part as <code>z</code>.
     *
     * @param z The argument.
     * @param n Which root to take.
     *
     * @return All values of the <code>n</code>:th root of <code>z</code>, that is <code>z<sup>1/n</sup></code>, in the order of the angle.
     *
     * @exception ArithmeticException If <code>n</code> is zero.
     *
     * @since 1.5
     */

    public static Apcomplex[] allRoots(Apcomplex z, int n)
        throws ArithmeticException, ApfloatRuntimeException
    {
        if (n == 0)
        {
            throw new ArithmeticException("Zeroth root");
        }
        else if (n == 1)
        {
            return new Apcomplex[] { z };
        }
        else if (n == 0x80000000)
        {
            throw new ApfloatRuntimeException("Maximum array size exceeded");
        }
        else if (z.real().signum() == 0 && z.imag().signum() == 0)
        {
            if (n < 0)
            {
                throw new ArithmeticException("Inverse root of zero");
            }
            Apcomplex[] allRoots = new Apcomplex[n];
            Arrays.fill(allRoots, Apcomplex.ZEROS[z.radix()]);
            return allRoots;                                    // Avoid division by zero
        }

        boolean inverse = (n < 0);
        n = Math.abs(n);

        long precision = z.precision();
        z = ApfloatHelper.extendPrecision(z);                   // Big roots will accumulate round-off errors

        Apcomplex w = inverseRootAbs(new Apfloat(1, precision, z.radix()), n, 1);
        w = (z.imag().signum() >= 0 ^ inverse ? w.conj() : w);  // Complex n:th root of unity

        Apcomplex[] allRoots = new Apcomplex[n];
        Apcomplex root = (inverse ? inverseRootAbs(z, n, 0) : root(z, n));
        allRoots[0] = ApfloatHelper.setPrecision(root, precision);
        for (int i = 1; i < n; i++)
        {
            root = root.multiply(w);
            allRoots[i] = ApfloatHelper.setPrecision(root, precision);
        }
        return allRoots;
    }

    /**
     * Arithmetic-geometric mean.
     *
     * @param a First argument.
     * @param b Second argument.
     *
     * @return Arithmetic-geometric mean of <code>a</code> and <code>b</code>.
     */

    public static Apcomplex agm(Apcomplex a, Apcomplex b)
        throws ApfloatRuntimeException
    {
        if (a.real().signum() == 0 && a.imag().signum() == 0 ||
            b.real().signum() == 0 && b.imag().signum() == 0)         // Would not converge quadratically
        {
            return Apcomplex.ZEROS[a.radix()];
        }

        if (a.real().signum() == b.real().signum() &&
            a.imag().signum() == 0 &&
            b.imag().signum() == 0)
        {
            return ApfloatMath.agm(a.real(), b.real());
        }

        if (a.equals(b))                                              // Thanks to Marko Gaspersic for finding several bugs in issue #12
        {
            return a.precision(Math.min(a.precision(), b.precision()));
        }

        if (a.equals(b.negate()))                                     // Would not converge quadratically
        {
            return Apcomplex.ZEROS[a.radix()];
        }

        long workingPrecision = Math.min(a.precision(), b.precision()),
             targetPrecision = workingPrecision;

        if (workingPrecision == Apfloat.INFINITE)
        {
            throw new InfiniteExpansionException("Cannot calculate agm to infinite precision");
        }

        // Some minimum precision is required for the algorithm to work
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
            Apcomplex t = limitPrecision(a.add(b)).divide(two);
            b = rightSqrt(a.multiply(b), t);
            a = t;

            // Conserve precision in case of accumulating round-off errors
            a = ApfloatHelper.ensurePrecision(a, workingPrecision);
            b = ApfloatHelper.ensurePrecision(b, workingPrecision);

            precision = a.equalDigits(b);
        }

        // Now we know quadratic convergence
        while (precision <= halfWorkingPrecision)
        {
            Apcomplex t = a.add(b).divide(two);
            b = rightSqrt(a.multiply(b), t);
            a = t;

            // Conserve precision in case of accumulating round-off errors
            a = ApfloatHelper.ensurePrecision(a, workingPrecision);
            b = ApfloatHelper.ensurePrecision(b, workingPrecision);

            precision *= 2;
        }

        return ApfloatHelper.setPrecision(a.add(b).divide(two), targetPrecision);
    }

    private static Apcomplex limitPrecision(Apcomplex z)
    {
        return z.precision(z.precision());
    }

    private static Apcomplex rightSqrt(Apcomplex z, Apcomplex reference)
    {
        // See  D. A. Cox, "The Arithmetic-Geometric Mean of Gauss", L'Enseignement Mathematique, Vol. 30, 1984, pp. 275-330
        // or for example Tomack Gilmore's paper about it: https://homepage.univie.ac.at/tomack.gilmore/papers/Agm.pdf
        // 1. norm(a1 - b1) <= norm(a1 + b1)
        // 2. If norm(a1 - b1) = norm(a1 + b1) then imag(b1 / a1) > 0
        Apcomplex result = sqrt(z);

        // First compare norms with low precision
        int doublePrecision = ApfloatHelper.getDoublePrecision(z.radix());
        Apcomplex approxResult = result.precision(doublePrecision);
        Apcomplex approxReference = reference.precision(doublePrecision);
        int comparison = norm(approxReference.subtract(approxResult)).compareTo(norm(approxReference.add(approxResult)));
        if (comparison == 0)
        {
            // Full precision comparison as they are equal to low precision
            comparison = norm(reference.subtract(result)).compareTo(norm(reference.add(result)));
        }
        if (comparison > 0 || comparison == 0 && result.divide(reference).imag().signum() <= 0)
        {
            result = result.negate();
        }
        return result;
    }

    /**
     * Natural logarithm.<p>
     *
     * The logarithm is calculated using the arithmetic-geometric mean.
     * See the Borweins' book for the formula.
     *
     * @param z The argument.
     *
     * @return Natural logarithm of <code>z</code>.
     *
     * @exception ArithmeticException If <code>z</code> is zero.
     */

    public static Apcomplex log(Apcomplex z)
        throws ArithmeticException, ApfloatRuntimeException
    {
        if (z.imag().signum() == 0)
        {
            if (z.real().signum() >= 0)
            {
                return ApfloatMath.log(z.real());
            }
            return new Apcomplex(ApfloatMath.log(z.real().negate()), ApfloatMath.pi(z.precision(), z.radix()));
        }

        // Calculate the log using 1 / radix <= |z| < 1 and the log addition formula
        // because the agm converges badly for big z

        long targetPrecision = z.precision();

        if (targetPrecision == Apfloat.INFINITE)
        {
            throw new InfiniteExpansionException("Cannot calculate logarithm to infinite precision");
        }

        // If the absolute value of the argument is very big, the result is more accurate
        Apfloat x = abs(z);
        if (x.scale() > 1)
        {
            double logScale = Math.log((double) x.scale() - 1) / Math.log((double) x.radix());
            logScale += Math.ulp(logScale);
            targetPrecision = Util.ifFinite(targetPrecision, targetPrecision + (long) logScale);
        }

        Apfloat imagBias;

        // Scale z so that real part of z is always >= 0, that is its angle is -pi/2 <= angle(z) <= pi/2 to avoid possible instability near z.imag() = +-pi
        if (z.real().signum() < 0)
        {
            Apfloat pi = ApfloatHelper.extendPrecision(ApfloatMath.pi(targetPrecision, z.radix()), z.radix() <= 3 ? 1 : 0);     // pi may have 1 digit more than pi/2

            if (z.imag().signum() >= 0)
            {
                imagBias = pi;
            }
            else
            {
                imagBias = pi.negate();
            }

            z = z.negate();
        }
        else
        {
            // No bias
            imagBias = Apfloat.ZERO;
        }

        Apfloat one = new Apfloat(1, Apfloat.INFINITE, z.radix());

        long originalScale = z.scale();

        z = scale(z, -originalScale);   // Set z's scale to zero

        Apfloat radixPower;
        if (originalScale == 0)
        {
            radixPower = Apfloat.ZERO;
        }
        else
        {
            Apfloat logRadix = ApfloatHelper.extendPrecision(ApfloatMath.logRadix(targetPrecision, z.radix()));
            radixPower = new Apfloat(originalScale, Apfloat.INFINITE, z.radix()).multiply(logRadix);
        }

        Apcomplex result = ApfloatHelper.extendPrecision(rawLog(z)).add(radixPower);

        // If the absolute value of the argument is close to 1, the real part of the result is less accurate
        // If the angle of the argument is close to zero, the imaginary part of the result is less accurate
        long finalRealPrecision = Math.max(targetPrecision - one.equalDigits(x), 1),
             finalImagPrecision = Math.max(targetPrecision - 1 + result.imag().scale(), 1);     // Scale of pi/2 is always 1

        return new Apcomplex(result.real().precision(finalRealPrecision),
                             result.imag().precision(finalImagPrecision).add(imagBias));
    }

    /**
     * Logarithm in arbitrary base.<p>
     *
     * @param z The argument.
     * @param w The base.
     *
     * @return Base-<code>w</code> logarithm of <code>z</code>.
     *
     * @exception ArithmeticException If <code>z</code> or <code>w</code> is zero.
     *
     * @since 1.6
     */

    public static Apcomplex log(Apcomplex z, Apcomplex w)
        throws ArithmeticException, ApfloatRuntimeException
    {
        if (z.real().signum() >= 0 && z.imag().signum() == 0 &&
            w.real().signum() >= 0 && w.imag().signum() == 0)
        {
            return ApfloatMath.log(z.real(), w.real());
        }

        long targetPrecision = Math.min(z.precision(), w.precision());

        if (z.real().signum() >= 0 && z.imag().signum() == 0)
        {
            Apfloat x = z.real();

            Apfloat one = new Apfloat(1, Apfloat.INFINITE, x.radix());
            targetPrecision = Util.ifFinite(targetPrecision, targetPrecision + one.equalDigits(x)); // If the log() argument is close to 1, the result is less accurate
            x = x.precision(Math.min(x.precision(), targetPrecision));

            return ApfloatMath.log(x).divide(log(w));
        }
        else if (w.real().signum() >= 0 && w.imag().signum() == 0)
        {
            Apfloat y = w.real();

            Apfloat one = new Apfloat(1, Apfloat.INFINITE, y.radix());
            targetPrecision = Util.ifFinite(targetPrecision, targetPrecision + one.equalDigits(y)); // If the log() argument is close to 1, the result is less accurate
            y = y.precision(Math.min(y.precision(), targetPrecision));

            return log(z).divide(ApfloatMath.log(y));
        }
        else
        {
            return log(z).divide(log(w));
        }
    }

    // Raw logarithm, regardless of z
    // Doesn't work for really big z, but is faster if used alone for small numbers
    private static Apcomplex rawLog(Apcomplex z)
        throws ApfloatRuntimeException
    {
        assert (z.real().signum() != 0 || z.imag().signum() != 0);      // Infinity

        Apfloat one = new Apfloat(1, Apfloat.INFINITE, z.radix());

        final int EXTRA_PRECISION = 25;

        long targetPrecision = z.precision(),
             workingPrecision = ApfloatHelper.extendPrecision(targetPrecision),
             n = targetPrecision / 2 + EXTRA_PRECISION;                 // Very rough estimate

        z = ApfloatHelper.extendPrecision(z, EXTRA_PRECISION);

        Apfloat e = one.precision(workingPrecision);
        e = ApfloatMath.scale(e, -n);
        z = scale(z, -n);

        Apfloat agme = ApfloatHelper.extendPrecision(ApfloatMath.agm(one, e));
        Apcomplex agmez = ApfloatHelper.extendPrecision(agm(one, z));

        Apfloat pi = ApfloatHelper.extendPrecision(ApfloatMath.pi(targetPrecision, z.radix()));
        Apcomplex log = pi.multiply(agmez.subtract(agme)).divide(new Apfloat(2, Apfloat.INFINITE, z.radix()).multiply(agme).multiply(agmez));

        return ApfloatHelper.setPrecision(log, targetPrecision);
    }

    /**
     * Exponent function.
     * Calculated using Newton's iteration for the inverse of logarithm.
     *
     * @param z The argument.
     *
     * @return <code>e<sup>z</sup></code>.
     */

    public static Apcomplex exp(Apcomplex z)
        throws ApfloatRuntimeException
    {
        if (z.imag().signum() == 0)
        {
            return ApfloatMath.exp(z.real());
        }

        int radix = z.radix();
        Apfloat one = new Apfloat(1, Apfloat.INFINITE, radix);

        long doublePrecision = ApfloatHelper.getDoublePrecision(radix);

        // If the real part of the argument is close to 0, the result is more accurate; if it's very big the result is less accurate
        if (z.real().precision() < z.real().scale() - 1)
        {
            throw new LossOfPrecisionException("Complete loss of accurate digits in real part");
        }
        // The imaginary part must be scaled to the range of -pi ... pi, which may limit the precision
        if (z.imag().precision() < z.imag().scale())
        {
            throw new LossOfPrecisionException("Complete loss of accurate digits in imaginary part");
        }
        long realPrecision = Util.ifFinite(z.real().precision(), z.real().precision() + 1 - z.real().scale()),
             imagPrecision = Util.ifFinite(z.imag().precision(), 1 + z.imag().precision() - z.imag().scale()),
             targetPrecision = Math.min(realPrecision, imagPrecision);

        if (targetPrecision == Apfloat.INFINITE)
        {
            throw new InfiniteExpansionException("Cannot calculate exponent to infinite precision");
        }
        else if (z.real().compareTo(new Apfloat((double) Long.MAX_VALUE * Math.log((double) radix), doublePrecision, radix)) >= 0)
        {
            throw new OverflowException("Overflow");
        }
        else if (z.real().compareTo(new Apfloat((double) Long.MIN_VALUE * Math.log((double) radix), doublePrecision, radix)) <= 0)
        {
            // Underflow

            return Apcomplex.ZEROS[z.radix()];
        }

        boolean negateResult = false;                           // If the final result is to be negated
        Apfloat zImag;

        if (z.imag().scale() > 0)
        {
            long piPrecision = Util.ifFinite(targetPrecision, targetPrecision + z.imag().scale());
            Apfloat pi = ApfloatMath.pi(piPrecision, radix),    // This is precalculated for initial check only
                    twoPi = pi.add(pi),
                    halfPi = pi.divide(new Apfloat(2, targetPrecision, radix));

            // Scale z so that -pi < z.imag() <= pi
            zImag = ApfloatMath.fmod(z.imag(), twoPi);
            if (zImag.compareTo(pi) > 0)
            {
                zImag = zImag.subtract(twoPi);
            }
            else if (zImag.compareTo(pi.negate()) <= 0)
            {
                zImag = zImag.add(twoPi);
            }
            // More, scale z so that -pi/2 < z.imag() <= pi/2 to avoid instability near z.imag() = +-pi
            if (zImag.compareTo(halfPi) > 0)
            {
                // exp(z - i*pi) = exp(z)/exp(i*pi) = -exp(z)
                zImag = zImag.subtract(pi);
                negateResult = true;
            }
            else if (zImag.compareTo(halfPi.negate()) <= 0)
            {
                // exp(z + i*pi) = exp(z)*exp(i*pi) = -exp(z)
                zImag = zImag.add(pi);
                negateResult = true;
            }
        }
        else
        {
            // No need to scale the imaginary part since it's small, -pi/2 < z.imag() <= pi/2
            zImag = z.imag();
        }
        z = new Apcomplex(z.real(), zImag);

        Apfloat resultReal;
        Apcomplex resultImag;

        // First handle the real part

        if (z.real().signum() == 0)
        {
            resultReal = one;
        }
        else if (z.real().scale() < -doublePrecision / 2)
        {
            // Taylor series: exp(x) = 1 + x + x^2/2 + ...

            long precision = Util.ifFinite(-z.real().scale(), -2 * z.real().scale());
            resultReal = one.precision(precision).add(z.real());
        }
        else
        {
            // Approximate starting value for iteration

            // An overflow or underflow should not occur
            long scaledRealPrecision = Math.max(0, z.real().scale()) + doublePrecision;
            Apfloat logRadix = ApfloatMath.log(new Apfloat((double) radix, scaledRealPrecision, radix)),
                    scaledReal = z.real().precision(scaledRealPrecision).divide(logRadix),
                    integerPart = scaledReal.truncate(),
                    fractionalPart = scaledReal.frac();

            resultReal = new Apfloat(Math.pow((double) radix, fractionalPart.doubleValue()), doublePrecision, radix);
            resultReal = ApfloatMath.scale(resultReal, integerPart.longValue());

            if (resultReal.signum() == 0) {
                // Underflow
                return Apcomplex.ZEROS[z.radix()];
            }
        }

        // Then handle the imaginary part

        if (zImag.signum() == 0)
        {
            // Imaginary part may have been reduced to zero e.g. if it was exactly pi
            resultImag = one;
        }
        else if (zImag.scale() < -doublePrecision / 2)
        {
            // Taylor series: exp(z) = 1 + z + z^2/2 + ...

            long precision = Util.ifFinite(-zImag.scale(), -2 * zImag.scale());
            resultImag = new Apcomplex(one.precision(precision), zImag.precision(-zImag.scale()));
        }
        else
        {
            // Approximate starting value for iteration

            double doubleImag = zImag.doubleValue();
            resultImag = new Apcomplex(new Apfloat(Math.cos(doubleImag), doublePrecision, radix),
                                       new Apfloat(Math.sin(doubleImag), doublePrecision, radix));
        }

        // Starting value is (real part starting value) * (imag part starting value)
        Apcomplex result = resultReal.multiply(resultImag);

        long precision = result.precision();    // Accuracy of initial guess

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
            if ((minPrec - Apcomplex.EXTRA_PRECISION) << precisingIteration >= targetPrecision)
            {
                break;
            }
        }

        if (iterations > 0)
        {
            // Precalculate the needed values once to the required precision
            ApfloatMath.logRadix(targetPrecision, radix);
        }

        z = ApfloatHelper.extendPrecision(z);

        // Newton's iteration
        while (iterations-- > 0)
        {
            precision *= 2;
            result = ApfloatHelper.setPrecision(result, Math.min(precision, targetPrecision));

            Apcomplex t = log(result);
            t = lastIterationExtendPrecision(iterations, precisingIteration, t);
            t = z.subtract(t);

            if (iterations < precisingIteration)
            {
                t = new Apcomplex(t.real().precision(precision / 2),
                                  t.imag().precision(precision / 2));
            }

            result = lastIterationExtendPrecision(iterations, precisingIteration, result);
            result = result.add(result.multiply(t));

            // Precising iteration
            if (iterations == precisingIteration)
            {
                t = log(result);
                t = lastIterationExtendPrecision(iterations, -1, t);

                result = lastIterationExtendPrecision(iterations, -1, result);
                result = result.add(result.multiply(z.subtract(t)));
            }
        }

        return ApfloatHelper.setPrecision(negateResult ? result.negate() : result, targetPrecision);
    }

    /**
     * Arbitrary power. Calculated using <code>log()</code> and <code>exp()</code>.<p>
     *
     * @param z The base.
     * @param w The exponent.
     *
     * @return <code>z<sup>w</sup></code>.
     *
     * @exception ArithmeticException If both <code>z</code> and <code>w</code> are zero.
     */

    public static Apcomplex pow(Apcomplex z, Apcomplex w)
        throws ApfloatRuntimeException
    {
        long targetPrecision = Math.min(z.precision(), w.precision());

        Apcomplex result = ApfloatHelper.checkPow(z, w, targetPrecision);
        if (result != null)
        {
            return result;
        }

        if (z.real().signum() >= 0 && z.imag().signum() == 0)
        {
            Apfloat x = z.real();

            // Limits precision for log() but may be sub-optimal; precision could be limited more
            Apfloat one = new Apfloat(1, Apfloat.INFINITE, x.radix());
            targetPrecision = Util.ifFinite(targetPrecision, targetPrecision + one.equalDigits(x)); // If the log() argument is close to 1, the result is less accurate
            x = x.precision(Math.min(x.precision(), targetPrecision));

            return exp(w.multiply(ApfloatMath.log(x)));
        }
        else
        {
            return exp(w.multiply(log(z)));
        }
    }

    /**
     * Inverse cosine. Calculated using <code>log()</code>.
     *
     * @param z The argument.
     *
     * @return Inverse cosine of <code>z</code>.
     */

    public static Apcomplex acos(Apcomplex z)
        throws ApfloatRuntimeException
    {
        Apfloat one = new Apfloat(1, Apfloat.INFINITE, z.radix());

        if (z.imag().signum() == 0 && ApfloatMath.abs(z.real()).compareTo(one) <= 0)
        {
            return ApfloatMath.acos(z.real());
        }

        Apcomplex i = new Apcomplex(Apfloat.ZERO, one),
                  w = i.multiply(log(z.add(sqrt(z.multiply(z).subtract(one)))));

        if (z.real().signum() < 0 && z.imag().signum() == 0)
        {
            return new Apcomplex(w.real().negate(), w.imag());
        }
        else if (z.real().signum() * z.imag().signum() > 0 || z.real().signum() == 0)
        {
            return w.negate();
        }
        else
        {
            return w;
        }
    }

    /**
     * Inverse hyperbolic cosine. Calculated using <code>log()</code>.
     *
     * @param z The argument.
     *
     * @return Inverse hyperbolic cosine of <code>z</code>.
     */

    public static Apcomplex acosh(Apcomplex z)
        throws ApfloatRuntimeException
    {
        Apfloat one = new Apfloat(1, Apfloat.INFINITE, z.radix());

        if (z.real().signum() > 0 || z.real().signum() == 0 && z.imag().signum() >= 0)
        {
            return log(z.add(sqrt(z.multiply(z).subtract(one))));
        }
        else
        {
            return log(z.subtract(sqrt(z.multiply(z).subtract(one))));
        }
    }

    /**
     * Inverse sine. Calculated using <code>log()</code>.
     *
     * @param z The argument.
     *
     * @return Inverse sine of <code>z</code>.
     */

    public static Apcomplex asin(Apcomplex z)
        throws ApfloatRuntimeException
    {
        Apfloat one = new Apfloat(1, Apfloat.INFINITE, z.radix());

        if (z.imag().signum() == 0 && ApfloatMath.abs(z.real()).compareTo(one) <= 0)
        {
            return ApfloatMath.asin(z.real());
        }

        Apcomplex i = new Apcomplex(Apfloat.ZERO, one);

        if (z.imag().signum() >= 0)
        {
            return i.multiply(log(sqrt(one.subtract(z.multiply(z))).subtract(i.multiply(z))));
        }
        else
        {
            return i.multiply(log(i.multiply(z).add(sqrt(one.subtract(z.multiply(z)))))).negate();
        }
    }

    /**
     * Inverse hyperbolic sine. Calculated using <code>log()</code>.
     *
     * @param z The argument.
     *
     * @return Inverse hyperbolic sine of <code>z</code>.
     */

    public static Apcomplex asinh(Apcomplex z)
        throws ApfloatRuntimeException
    {
        Apfloat one = new Apfloat(1, Apfloat.INFINITE, z.radix());

        if (z.real().signum() >= 0)
        {
            return log(sqrt(z.multiply(z).add(one)).add(z));
        }
        else
        {
            return log(sqrt(z.multiply(z).add(one)).subtract(z)).negate();
        }
    }

    /**
     * Inverse tangent. Calculated using <code>log()</code>.
     *
     * @param z The argument.
     *
     * @return Inverse tangent of <code>z</code>.
     *
     * @exception ArithmeticException If <code>z == <i>i</i></code>.
     */

    public static Apcomplex atan(Apcomplex z)
        throws ArithmeticException, ApfloatRuntimeException
    {
        if (z.imag().signum() == 0)
        {
            return ApfloatMath.atan(z.real());
        }

        Apfloat one = new Apfloat(1, Apfloat.INFINITE, z.radix()),
                two = new Apfloat(2, Apfloat.INFINITE, z.radix());
        Apcomplex i = new Apcomplex(Apfloat.ZERO, one),
                  w = log(i.add(z).divide(i.subtract(z))).multiply(i).divide(two);

        if (z.real().signum() == 0 && z.imag().signum() > 0)
        {
            return new Apcomplex(w.real().negate(), w.imag());
        }
        else
        {
            return w;
        }
    }

    /**
     * Inverse hyperbolic tangent. Calculated using <code>log()</code>.
     *
     * @param z The argument.
     *
     * @return Inverse hyperbolic tangent of <code>z</code>.
     *
     * @exception ArithmeticException If <code>z</code> is 1 or -1.
     */

    public static Apcomplex atanh(Apcomplex z)
        throws ArithmeticException, ApfloatRuntimeException
    {
        Apfloat one = new Apfloat(1, Apfloat.INFINITE, z.radix()),
                two = new Apfloat(2, Apfloat.INFINITE, z.radix());
        Apcomplex w = log(one.add(z).divide(one.subtract(z))).divide(two);

        if (z.real().signum() > 0 && z.imag().signum() == 0)
        {
            return w.conj();
        }
        else
        {
            return w;
        }
    }

    /**
     * Cosine. Calculated using <code>exp()</code>.
     *
     * @param z The argument.
     *
     * @return Cosine of <code>z</code>.
     */

    public static Apcomplex cos(Apcomplex z)
        throws ApfloatRuntimeException
    {
        if (z.imag().signum() == 0)
        {
            return ApfloatMath.cos(z.real());
        }

        Apfloat one = new Apfloat(1, Apfloat.INFINITE, z.radix()),
                two = new Apfloat(2, Apfloat.INFINITE, z.radix());
        Apcomplex i = new Apcomplex(Apfloat.ZERO, one),
                  w = exp(i.multiply(z));

        return (w.add(one.divide(w))).divide(two);
    }

    /**
     * Hyperbolic cosine. Calculated using <code>exp()</code>.
     *
     * @param z The argument.
     *
     * @return Hyperbolic cosine of <code>z</code>.
     */

    public static Apcomplex cosh(Apcomplex z)
        throws ApfloatRuntimeException
    {
        if (z.imag().signum() == 0)
        {
            return ApfloatMath.cosh(z.real());
        }

        Apfloat one = new Apfloat(1, Apfloat.INFINITE, z.radix()),
                two = new Apfloat(2, Apfloat.INFINITE, z.radix());
        Apcomplex w = exp(z);

        return (w.add(one.divide(w))).divide(two);
    }

    /**
     * Sine. Calculated using <code>exp()</code>.
     *
     * @param z The argument.
     *
     * @return Sine of <code>z</code>.
     */

    public static Apcomplex sin(Apcomplex z)
        throws ApfloatRuntimeException
    {
        if (z.imag().signum() == 0)
        {
            return ApfloatMath.sin(z.real());
        }

        Apfloat one = new Apfloat(1, Apfloat.INFINITE, z.radix()),
                two = new Apfloat(2, Apfloat.INFINITE, z.radix());
        Apcomplex i = new Apcomplex(Apfloat.ZERO, one),
                  w = exp(i.multiply(z));

        return one.divide(w).subtract(w).multiply(i).divide(two);
    }

    /**
     * Hyperbolic sine. Calculated using <code>exp()</code>.
     *
     * @param z The argument.
     *
     * @return Hyperbolic sine of <code>z</code>.
     */

    public static Apcomplex sinh(Apcomplex z)
        throws ApfloatRuntimeException
    {
        if (z.imag().signum() == 0)
        {
            return ApfloatMath.sinh(z.real());
        }

        Apfloat one = new Apfloat(1, Apfloat.INFINITE, z.radix()),
                two = new Apfloat(2, Apfloat.INFINITE, z.radix());
        Apcomplex w = exp(z);

        return (w.subtract(one.divide(w))).divide(two);
    }

    /**
     * Tangent. Calculated using <code>exp()</code>.
     *
     * @param z The argument.
     *
     * @return Tangent of <code>z</code>.
     *
     * @exception ArithmeticException If <code>z</code> is &pi;/2 + n &pi; where n is an integer.
     */

    public static Apcomplex tan(Apcomplex z)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return tan(z, z.imag().signum() < 0);
    }

    static Apcomplex tanFixedPrecision(Apcomplex z)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return tan(z, z.imag().signum() > 0);
    }

    static Apcomplex tan(Apcomplex z, boolean negate)
        throws ArithmeticException, ApfloatRuntimeException
    {
        if (z.imag().signum() == 0)
        {
            return ApfloatMath.tan(z.real());
        }

        z = (negate ? z.negate() : z);

        Apfloat one = new Apfloat(1, Apfloat.INFINITE, z.radix()),
                two = new Apfloat(2, Apfloat.INFINITE, z.radix());
        Apcomplex i = new Apcomplex(Apfloat.ZERO, one),
                  w = exp(two.multiply(i).multiply(z));

        w = i.multiply(one.subtract(w)).divide(one.add(w));

        return (negate ? w.negate() : w);
    }

    /**
     * Hyperbolic tangent. Calculated using <code>exp()</code>.
     *
     * @param z The argument.
     *
     * @return Hyperbolic tangent of <code>z</code>.
     *
     * @exception ArithmeticException If <code>z</code> is <i>i</i> (&pi;/2 + n &pi;) where n is an integer.
     */

    public static Apcomplex tanh(Apcomplex z)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return tanh(z, z.real().signum() > 0);
    }

    static Apcomplex tanhFixedPrecision(Apcomplex z)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return tanh(z, z.real().signum() < 0);
    }

    private static Apcomplex tanh(Apcomplex z, boolean negate)
        throws ArithmeticException, ApfloatRuntimeException
    {
        if (z.imag().signum() == 0)
        {
            return ApfloatMath.tanh(z.real());
        }

        z = (negate ? z.negate() : z);

        Apfloat one = new Apfloat(1, Apfloat.INFINITE, z.radix()),
                two = new Apfloat(2, Apfloat.INFINITE, z.radix());
        Apcomplex w = exp(two.multiply(z));

        w = w.subtract(one).divide(w.add(one));

        return (negate ? w.negate() : w);
    }

    static Apcomplex cot(Apcomplex z)
        throws ArithmeticException, ApfloatRuntimeException
    {
        boolean negate = z.imag().signum() < 0;
        z = (negate ? z.negate() : z);

        Apfloat one = new Apfloat(1, Apfloat.INFINITE, z.radix()),
                two = new Apfloat(2, Apfloat.INFINITE, z.radix());
        Apcomplex i = new Apcomplex(Apfloat.ZERO, one),
                  w = expNoLoP(two.multiply(i).multiply(z));

        w = i.multiply(two.multiply(w).divide(w.subtract(one)).subtract(one));

        return (negate ? w.negate() : w);
    }

    /**
     * Lambert W function. The W function gives the solution to the equation
     * <code>W e<sup>W</sup> = z</code>. Also known as the product logarithm.<p>
     *
     * This function gives the solution to the principal branch, W<sub>0</sub>.
     *
     * @param z The argument.
     *
     * @return <code>W<sub>0</sub>(z)</code>.
     *
     * @since 1.8.0
     */

    public static Apcomplex w(Apcomplex z)
        throws ApfloatRuntimeException
    {
        return LambertWHelper.w(z);
    }

    /**
     * Lambert W function for the specified branch.<p>
     *
     * @param z The argument.
     * @param k The branch.
     *
     * @return <code>W<sub>k</sub>(z)</code>.
     *
     * @exception ArithmeticException If <code>z</code> is zero and <code>k</code> is not zero.
     *
     * @see #w(Apcomplex)
     *
     * @since 1.8.0
     */

    public static Apcomplex w(Apcomplex z, long k)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return LambertWHelper.w(z, k);
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
     * @param z The argument(s).
     *
     * @return The product of the given numbers.
     *
     * @since 1.3
     */

    public static Apcomplex product(Apcomplex... z)
        throws ApfloatRuntimeException
    {
        if (z.length == 0)
        {
            return Apcomplex.ONE;
        }

        // Determine working precision
        long maxPrec = Apcomplex.INFINITE;
        for (int i = 0; i < z.length; i++)
        {
            if (z[i].real().signum() == 0 && z[i].imag().signum() == 0)
            {
                return Apcomplex.ZEROS[z[i].radix()];
            }
            maxPrec = Math.min(maxPrec, z[i].precision());
        }

        // Do not use z.clone() as the array might be of some subclass type, resulting in ArrayStoreException later
        Apcomplex[] tmp = new Apcomplex[z.length];

        // Add sqrt length digits for round-off errors
        long extraPrec = (long) Math.sqrt((double) z.length),
             destPrec = ApfloatHelper.extendPrecision(maxPrec, extraPrec);
        for (int i = 0; i < z.length; i++)
        {
            tmp[i] = z[i].precision(destPrec);
        }
        z = tmp;

        // Create a heap, ordered by size
        Queue<Apcomplex> heap = new PriorityQueue<>(z.length, Comparator.comparing(Apcomplex::size));

        // Perform the multiplications in parallel
        ParallelHelper.ProductKernel<Apcomplex> kernel = (h) ->
        {
            Apcomplex a = h.remove();
            Apcomplex b = h.remove();
            Apcomplex c = a.multiply(b);
            h.add(c);
        };
        ParallelHelper.parallelProduct(z, heap, kernel);

        return ApfloatHelper.setPrecision(heap.remove(), maxPrec);
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
     * @param z The argument(s).
     *
     * @return The sum of the given numbers.
     *
     * @since 1.3
     */

    public static Apcomplex sum(Apcomplex... z)
        throws ApfloatRuntimeException
    {
        if (z.length == 0)
        {
            return Apcomplex.ZERO;
        }

        Apfloat[] x = new Apfloat[z.length],
                  y = new Apfloat[z.length];
        for (int i = 0; i < z.length; i++)
        {
            x[i] = z[i].real();
            y[i] = z[i].imag();
        }
        return new Apcomplex(ApfloatMath.sum(x), ApfloatMath.sum(y));
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
     * @param z The argument.
     *
     * @return <code>&Gamma;(z)</code>
     *
     * @throws ArithmeticException If <code>z</code> is a nonpositive integer.
     *
     * @since 1.9.0
     */

    public static Apcomplex gamma(Apcomplex z)
        throws ArithmeticException, ApfloatRuntimeException
    {
        // Implementation note: the ck are actually constant (wrt. to precision and radix) so we could cache them,
        // however since this is a slow algorithm, the factors ck would take up quite a lot of space, and would not
        // improve the asymptotic complexity, so it's not really worth it - this function is anyway only useful for
        // a few thousand digits of precision, no matter of what optimization we might try.
        if (z.equals(Apfloat.ONE))
        {
            return z;
        }
        long precision = z.precision();
        int radix = z.radix();
        if (z.imag().signum() == 0)
        {
            if (z.real().signum() == 0)
            {
                throw new ArithmeticException("Gamma of zero");
            }
            if (z.real().isInteger())
            {
                if (z.real().signum() < 0)
                {
                    throw new ArithmeticException("Gamma of negative integer");
                }
                long n;
                try
                {
                    n = z.real().longValueExact();
                }
                catch (ArithmeticException ae)
                {
                    throw new OverflowException("Overflow");
                }
                return ApfloatMath.factorial(n - 1, precision, radix);
            }
        }
        if (precision == Apfloat.INFINITE)
        {
            throw new InfiniteExpansionException("Cannot calculate gamma function to infinite precision");
        }
        if (z.real().signum() < 0)
        {
            // Use reflection formula, see e.g. https://functions.wolfram.com/GammaBetaErf/Gamma/16/03/01/
            z = z.negate();
            Apfloat pi = ApfloatMath.pi(precision, radix);
            return pi.negate().divide(z.multiply(sin(pi.multiply(z))).multiply(gamma(z)));
        }
        Apint one = new Apint(1, radix);
        long a1 = (long) (precision / Math.log(2 * Math.PI) * Math.log(radix));
        long workingPrecision = ApfloatHelper.extendPrecision(precision, (long) (precision * 0.5) + Apfloat.EXTRA_PRECISION); // increase intermediate precision - ck are large and alternating in sign, lots of precision loss
        z = z.precision(workingPrecision).subtract(one);
        Apint a = new Apint(a1 + 1, radix);
        Apint two = new Apint(2, radix);
        Apfloat c0 = ApfloatMath.sqrt(ApfloatMath.pi(workingPrecision, radix).multiply(two));
        Apcomplex sum = c0;
        Apfloat e = ApfloatMath.exp(one.precision(workingPrecision));
        Apfloat divisor = ApfloatMath.exp(new Apfloat(-a1, workingPrecision, radix));
        for (long k = 1; k <= a1; k++)
        {
            Apint kk = new Apint(k, radix);
            Apfloat ak = a.subtract(kk).precision(workingPrecision);
            Apfloat ck = ApfloatMath.inverseRoot(ak, 2).multiply(ApfloatMath.pow(ak, k)).divide(divisor);
            sum = sum.add(ck.divide(z.add(kk)));
            if (k < a1)
            {
                divisor = divisor.multiply(e).multiply(kk).negate();
            }
        }
        Aprational half = new Aprational(one, two);
        Apcomplex result = ApcomplexMath.pow(z.add(a), z.add(half)).multiply(ApcomplexMath.exp(z.negate().subtract(a))).multiply(sum);
        double normalizedScale = result.scale() * Math.log(radix);
        if (normalizedScale > 0 && z.real().scale() > 0)
        {
            precision = precision - (long) (1.01 * Math.log(normalizedScale) / Math.log(radix)); // Very large results have a reduced precision
            if (precision <= 0)
            {
                throw new LossOfPrecisionException("Complete loss of accurate digits");
            }
        }
        else if (normalizedScale < 0)
        {
            precision = precision - (long) (1.148 * Math.log(-normalizedScale) / Math.log(radix)); // Very small results also have a reduced precision
            if (precision <= 0)
            {
                throw new LossOfPrecisionException("Complete loss of accurate digits");
            }
        }
        return result.precision(precision);
    }

    /**
     * Incomplete gamma function.<p>
     *
     * @implNote
     * This implementation is <i>slow</i>, meaning that it isn't a <i>fast algorithm</i>.
     * The asymptotic complexity is at least O(n<sup>2</sup>log&nbsp;n) and it is
     * impractically slow beyond a precision of a few thousand digits. At the time of
     * implementation no generic fast algorithm is known for the incomplete gamma function.
     *
     * @param a The first argument.
     * @param z The second argument.
     *
     * @return <code>&Gamma;(a, z)</code>
     *
     * @throws ArithmeticException If the real part of <code>a</code> is nonpositive and <code>z</code> is zero.
     *
     * @since 1.10.0
     */

    public static Apcomplex gamma(Apcomplex a, Apcomplex z)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return IncompleteGammaHelper.gamma(a, z);
    }

    /**
     * Generalized incomplete gamma function.<p>
     *
     * This function is defined as: <code>&Gamma;(a, z0, z1) = &Gamma;(a, z0) - &Gamma;(a, z1)</code><p>
     *
     * The lower gamma function can be calculated with: <code>&gamma;(a, z) = &Gamma;(a, 0, z)</code><p>
     *
     * @implNote
     * This implementation is <i>slow</i>, meaning that it isn't a <i>fast algorithm</i>.
     * The asymptotic complexity is at least O(n<sup>2</sup>log&nbsp;n) and it is
     * impractically slow beyond a precision of a few thousand digits. At the time of
     * implementation no generic fast algorithm is known for the incomplete gamma function.
     *
     * @param a The first argument.
     * @param z0 The second argument.
     * @param z1 The third argument.
     *
     * @return <code>&Gamma;(a, z0, z1)</code>
     *
     * @throws ArithmeticException If the real part of <code>a</code> is nonpositive and either <code>z0</code> or <code>z1</code> is zero. For the lower gamma function if <code>a</code> is a nonpositive integer.
     *
     * @since 1.10.0
     */

    public static Apcomplex gamma(Apcomplex a, Apcomplex z0, Apcomplex z1)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return IncompleteGammaHelper.gamma(a, z0, z1);
    }

    /**
     * Logarithm of the gamma function. Note that this function has a different branch
     * structure than <code>log(gamma(z))</code>.<p>
     *
     * @implNote
     * This implementation is <i>slow</i>, meaning that it isn't a <i>fast algorithm</i>.
     * The asymptotic complexity is at least O(n<sup>2</sup>log&nbsp;n) and it is
     * impractically slow beyond a precision of a few thousand digits. At the time of
     * implementation no generic fast algorithm is known for the gamma function.
     *
     * @param z The argument.
     *
     * @return <code>log&Gamma;(z)</code>
     *
     * @throws ArithmeticException If <code>z</code> is a nonpositive integer.
     *
     * @since 1.11.0
     */

    public static Apcomplex logGamma(Apcomplex z)
        throws ArithmeticException, ApfloatRuntimeException
    {
        // |B_2n| ~ 4 sqrt(pi n) (n / (pi e))^2n
        // Stirling's series (does not converge)
        // B_2n / (2n(2n-1)z^(2n-1))

        // The sum diverges, but depending on how large re(z) is, the terms initially get smaller and smaller,
        // until they start getting bigger and bigger (and grow to infinity)

        // By truncating the sum at the point where the terms are the smallest, we can get a good approximation

        // Thus we can calculate which is the smallest term, given any z
        // The larger re(z) is, the larger the n of the term is, and the smaller the term is
        // For higher precision we need more terms, and a larger re(z)
        // Use the recurrence formula to move re(z) to be as large as needed
        // For negative re(z) use first the reflection formula

        // To calculate how many terms of the sum we need, and how big should re(z) be:
        // Use the asymptotic formula for B_2n (which is good enough for n >= 3)
        // The term in the sum is B_2n / (2n(2n-1)z^(2n-1))
        //
        // which is approximately
        //
        //  z (E Pi z / n)^(-2n) / (2n (2n - 1))
        //
        // Take derivative with respect to n and solve when it's zero
        //
        // z = (n exp((4n - 1) / (2n - 4n^2))) / Pi
        //
        // Substitute back to what the term is at that point
        //
        // exp(-(2n - 1)^2 / (2n)) / (2 Pi (2 n - 1))
        //
        // For precision p in base b, we want that term to be equal to b^-p, solve that for n
        // (cannot be solved but approximately 2n ~ 2n-1 for large n, then it can be solved)
        //
        // n = 1/2 (1 + W(b^p / (2 Pi)))
        //
        // Use formula further above to get corresponding value for z
        //
        // W is Lambert's W function
        // W can be approximated by log(z) - log(log(z))
        // Followed possibly by iteration(s) of w = w/(1 + w) (1 + log(x/w))
        //
        // The bernoulli number factor of ~sqrt(n) has been ignored in the above calculations,
        // compensate by adding a few digits of extra precision

        long precision = z.precision();
        if (z.imag().signum() == 0)
        {
            if (z.real().signum() == 0)
            {
                throw new ArithmeticException("Log gamma of zero");
            }
            if (z.real().isInteger() && z.real().signum() < 0)
            {
                throw new ArithmeticException("Log gamma of negative integer");
            }
        }
        if (precision == Apfloat.INFINITE)
        {
            throw new InfiniteExpansionException("Cannot calculate log gamma function to infinite precision");
        }

        int radix = z.radix();
        Apint one = Apint.ONES[radix],
              two = new Apint(2, radix);
        long workingPrecision = ApfloatHelper.extendPrecision(precision);
        Apfloat pi = ApfloatMath.pi(workingPrecision, radix);

        if (z.real().signum() <= 0)
        {
            // Use reflection formula
            if (z.scale() < -precision)
            {
                // See e.g. https://functions.wolfram.com/GammaBetaErf/LogGamma/16/01/01/
                // Note that with z so small, now sin(z) ~= z, accurate to the precision of z
                return log(pi).subtract(log(pi.multiply(z))).subtract(logGamma(z.negate())).subtract(log(z.negate()));
            }
            // See: Arbitrary-precision computation of the gamma function, Fredrik Johansson, https://arxiv.org/pdf/2109.08392.pdf
            return log(pi).subtract(logSin(z)).subtract(logGamma(one.subtract(z)));
        }

        double adjust = Math.log(precision) + 1,    // Adjustment for the sqrt(n) factor in bernoulli numbers
               w = (precision + adjust) * Math.log(radix) - Math.log(2 * Math.PI);
        long n = (long) Math.ceil(0.5 * (1 + w - Math.log(w)));
        Apfloat zReal = new Apfloat(n * Math.exp((4. * n - 1) / (2 * n - 4. * n * n)) / Math.PI, precision, radix);
        Apcomplex s = Apcomplex.ZERO;
        if (z.real().compareTo(zReal) < 0)
        {
            long N = zReal.subtract(z.real()).roundAway().longValueExact();
            // Use recurrence formula
            s = s.subtract(logPochhammer(z, N));
            z = z.add(new Apfloat(N, precision, radix));
        }

        s = s.add(z.subtract(new Aprational(one, two)).multiply(log(z))).subtract(z).add(log(two.multiply(pi)).divide(two));
        Apcomplex z2 = z.multiply(z),
                  zp = z;
        Iterator<Aprational> bernoulli2 = AprationalMath.bernoullis2(n, radix);
        for (long k = 1; k <= n; k++)
        {
            long k2 = Math.multiplyExact(k,  2);
            Apcomplex term = bernoulli2.next().precision(workingPrecision).divide(new Apint(k2, radix).multiply(new Apint(k2 - 1, radix)).multiply(zp));
            if (k < n)
            {
                zp = zp.multiply(z2);
            }

            long[] matchingPrecisionsReal = ApfloatHelper.getMatchingPrecisions(s.real(), term.real());
            long[] matchingPrecisionsImag = ApfloatHelper.getMatchingPrecisions(s.imag(), term.imag());
            if (matchingPrecisionsReal[1] == 0 && matchingPrecisionsImag[1] == 0)
            {
                // The rest of the terms would be insignificantly small
                break;
            }

            s = s.add(term);
        }

        return s;
    }

    // log(sin(pi z)) with correct branch structure
    private static Apcomplex logSin(Apcomplex z)
    {
        // See https://arxiv.org/pdf/2109.08392.pdf Arbitrary-precision computation of the gamma function by Fredrik Johansson
        long precision = z.precision(),
             workingPrecision = ApfloatHelper.extendPrecision(precision);
        int radix = z.radix();
        Apint n = z.real().floor(),
              one = Apint.ONES[radix],
              two = new Apint(2, radix);
        Apfloat half = new Aprational(one, two).precision(workingPrecision),
                pi = ApfloatMath.pi(workingPrecision, radix);
        Apcomplex i = new Apcomplex(Apint.ZERO, Apint.ONES[radix]);
        Apcomplex offset = n.multiply(pi).multiply(i);
        assert (z.real().signum() <= 0);
        if (z.imag().signum() >= 0)
        {
            offset = offset.negate();
        }
        z = z.subtract(n);
        Apcomplex ls;
        if (z.imag().compareTo(one) > 0)
        {
            ls = log(half.multiply(one.subtract(expNoLoP(two.multiply(i).multiply(pi).multiply(z))))).subtract(i.multiply(pi).multiply(z.subtract(half)));
        }
        else if (z.imag().compareTo(one.negate()) < 0)
        {
            ls = log(half.multiply(one.subtract(expNoLoP(two.negate().multiply(i).multiply(pi).multiply(z))))).add(i.multiply(pi).multiply(z.subtract(half)));
        }
        else
        {
            ls = log(sin(pi.multiply(z)));
        }
        return ls.add(offset);
    }

    private static Apcomplex expNoLoP(Apcomplex z)
    {
        // Avoid loss of precision if z is too big
        if (z.real().signum() < 0)
        {
            if (z.real().scale() > 1)
            {
                if (z.real().precision() <= z.real().scale() - 1)
                {
                    z = new Apcomplex(z.real().precision(z.real().scale()), z.imag());
                }
            }
        }
        return exp(z);
    }

    private static Apcomplex logPochhammer(Apcomplex z, long n)
    {
        // Hare's algorithm
        boolean conj = (z.imag().signum() < 0);
        if (conj)
        {
            z = z.conj();
        }
        int radix = z.radix();
        Apcomplex s = z;
        long m = 0;
        for (long k = 1; k < n; k++)
        {
            Apcomplex t = s.multiply(z.add(new Apint(k, radix)));
            if (s.imag().signum() >= 0 && t.imag().signum() < 0)
            {
                 m += 2;
            }
            s = t;
        }
        if (s.real().signum() < 0)
        {
            if (s.imag().signum() >= 0)
            {
                m++;
            }
            else
            {
                m--;
            }
            s = s.negate();
        }
        Apcomplex i = new Apcomplex(Apint.ZERO, Apint.ONES[radix]);
        Apfloat pi = ApfloatMath.pi(z.precision(), radix);
        Apcomplex result = log(s).add(pi.multiply(i).multiply(new Apint(m, radix)));
        return (conj ? result.conj() : result);
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
     * @param z The argument.
     *
     * @return <code>&psi;(z)</code>
     *
     * @throws ArithmeticException If <code>z</code> is a nonpositive integer.
     *
     * @since 1.11.0
     */

    public static Apcomplex digamma(Apcomplex z)
        throws ArithmeticException, ApfloatRuntimeException
    {
        // digamma(x) = digamma(1-x) - pi cot(pi x)
        // |B_2n| ~ 4 sqrt(pi n) (n / (pi e))^2n
        // digamma(z) ~ ln(z) - 1 / 2z - sum (j=1, infinity, B_2j / (2j z^2j)), re(z) > 0
        // digamma(z) = digamma(z + N) - sum (k=0, N-1, 1 / (z + k))

        // The sum diverges, but depending on how large re(z) is, the terms initially get smaller and smaller,
        // until they start getting bigger and bigger (and grow to infinity)

        // By truncating the sum at the point where the terms are the smallest, we can get a good approximation

        // Thus we can calculate which is the smallest term, given any z
        // The larger re(z) is, the larger the n of the term is, and the smaller the term is
        // For higher precision we need more terms, and a larger re(z)
        // Use the recurrence formula to move re(z) to be as large as needed
        // For negative re(z) use first the reflection formula

        // To calculate how many terms of the sum we need, and how big should re(z) be:
        // Use the asymptotic formula for B_2n (which is good enough for n >= 3)
        // The term in the sum is B_2n / (2n z^2n)
        //
        // which is approximately
        //
        // (n / (pi e))^2n / (2n z^2n)
        // =
        // 1/2 n^(2n-1) (e pi z)^(-2n)
        // =
        // 1/(2n) (e pi z / n)^(-2n)
        //
        // Take derivative with respect to n and solve when it's zero
        //
        // n = 1/(2 W(1/(2 pi z)))
        // so then (solve for z)
        // z = e^(-1/(2n)) n / pi
        //
        // Substitute back to what the term is at that point
        //
        // e^(1-2n) / (2n)
        //
        // For precision p in base b, we want that term to be equal to b^-p, solve that for n
        //
        // n = 1/2 W(b^p e)
        //
        // Use formula further above to get corresponding value for z
        //
        // W is Lambert's W function
        // W can be approximated by log(z) - log(log(z))
        // Followed possibly by iteration(s) of w = w/(1 + w) (1 + log(x/w))
        //
        // The bernoulli number factor of ~sqrt(n) has been ignored in the above calculations,
        // compensate by adding a few digits of extra precision

        long precision = z.precision();
        int radix = z.radix();
        Apint one = Apint.ONES[radix];

        if (z.real().signum() <= 0)
        {
            if (z.real().isInteger() && z.imag().signum() == 0)
            {
                throw new ArithmeticException("Digamma of nonpositive integer");
            }
            if (precision == Apfloat.INFINITE)
            {
                throw new InfiniteExpansionException("Cannot calculate digamma function to infinite precision");
            }
            Apfloat pi = ApfloatMath.pi(precision, radix);
            // Use reflection formula, see e.g. https://functions.wolfram.com/GammaBetaErf/PolyGamma/16/01/01/
            if (z.scale() < -precision)
            {
                return digamma(z.negate()).subtract(pi.multiply(cot(pi.multiply(z)))).subtract(one.divide(z));
            }
            return digamma(one.subtract(z)).subtract(pi.multiply(cot(pi.multiply(z))));
        }
        if (precision == Apfloat.INFINITE)
        {
            throw new InfiniteExpansionException("Cannot calculate digamma function to infinite precision");
        }

        double adjust = Math.log(precision) + 1,    // Adjustment for the sqrt(n) factor in bernoulli numbers
               w = (precision + adjust) * Math.log(radix) + 1;
        long n = (long) Math.ceil(0.5 * (w - Math.log(w)));
        Apfloat zReal = new Apfloat(Math.exp(-0.5 / n) * n / Math.PI, precision, radix);
        Apcomplex s = Apfloat.ZERO;
        if (z.real().compareTo(zReal) < 0)
        {
            long N = zReal.subtract(z.real()).roundAway().longValueExact();
            // Use recurrence formula
            for (long k = 0; k < N; k++)
            {
                s = s.subtract(one.divide(z.add(new Apint(k, radix))));
            }
            z = z.add(new Apfloat(N, precision, radix));
        }

        Apint two = new Apint(2, radix);
        s = s.add(log(z)).subtract(one.divide(two.multiply(z)));
        Apcomplex z2 = z.multiply(z),
                  zp = one;
        Iterator<Aprational> bernoulli2 = AprationalMath.bernoullis2(n, radix);
        for (long k = 1; k <= n; k++)
        {
            long k2 = Math.multiplyExact(k,  2);
            zp = zp.multiply(z2);
            Apcomplex term = bernoulli2.next().precision(precision).divide(new Apint(k2, radix).multiply(zp));

            long[] matchingPrecisionsReal = ApfloatHelper.getMatchingPrecisions(s.real(), term.real());
            long[] matchingPrecisionsImag = ApfloatHelper.getMatchingPrecisions(s.imag(), term.imag());
            if (matchingPrecisionsReal[1] == 0 && matchingPrecisionsImag[1] == 0)
            {
                // The rest of the terms would be insignificantly small
                break;
            }

            s = s.subtract(term);
        }

        return s;
    }

    /**
     * Binomial coefficient. Calculated using the {@link #gamma(Apcomplex)} function.
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

    public static Apcomplex binomial(Apcomplex n, Apcomplex k)
        throws ArithmeticException, ApfloatRuntimeException
    {
        if (n.imag().signum() == 0 && k.imag().signum() == 0)
        {
            return ApfloatMath.binomial(n.real(), k.real());
        }
        Apcomplex nk = n.subtract(k);
        if (k.isInteger() && k.real().signum() < 0 ||
            nk.isInteger() && nk.real().signum() < 0)
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

    public static Apcomplex zeta(Apcomplex s)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return ZetaHelper.zeta(s);
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
     * @throws ArithmeticException If <code>s</code> is <code>1</code> or if <code>a</code> is a nonpositive integer.
     *
     * @since 1.11.0
     */

    public static Apcomplex zeta(Apcomplex s, Apcomplex a)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return HurwitzZetaHelper.zeta(s, a);
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
     * @param z The second argument.
     *
     * @return <i><sub>0</sub>F<sub>1</sub>(; a; z)</i>
     *
     * @throws ArithmeticException If the function value is not finite.
     *
     * @since 1.11.0
     */

    public static Apcomplex hypergeometric0F1(Apcomplex a, Apcomplex z)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return HypergeometricHelper.hypergeometricPFQ(new Apcomplex[0], new Apcomplex[] { a }, z);
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
     * @param z The third argument.
     *
     * @return <i><sub>1</sub>F<sub>1</sub>(a; b; z)</i>
     *
     * @throws ArithmeticException If the function value is not finite.
     *
     * @since 1.11.0
     */

    public static Apcomplex hypergeometric1F1(Apcomplex a, Apcomplex b, Apcomplex z)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return HypergeometricHelper.hypergeometricPFQ(new Apcomplex[] { a }, new Apcomplex[] { b }, z);
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
     * @param z The fourth argument.
     *
     * @return <i><sub>2</sub>F<sub>1</sub>(a, b; c; z)</i>
     *
     * @throws ArithmeticException If the function value is not finite.
     *
     * @since 1.11.0
     */

    public static Apcomplex hypergeometric2F1(Apcomplex a, Apcomplex b, Apcomplex c, Apcomplex z)
        throws ArithmeticException, ApfloatRuntimeException
    {
        return HypergeometricHelper.hypergeometricPFQ(new Apcomplex[] { a, b }, new Apcomplex[] { c }, z);
    }

    /**
     * Returns the unit in the last place of the argument, considering the
     * scale and precision. This is maximum of the ulps of the real and
     * imaginary part of the argument.
     * If the precision of the argument is infinite, zero is returned.
     *
     * @param z The argument.
     *
     * @return The ulp of the argument.
     *
     * @since 1.10.0
     */

    public static Apfloat ulp(Apcomplex z)
    {
        return ApfloatMath.max(ApfloatMath.ulp(z.real()), ApfloatMath.ulp(z.imag()));
    }

    // Extend the precision on last iteration
    private static Apcomplex lastIterationExtendPrecision(int iterations, int precisingIteration, Apcomplex z)
    {
        return (iterations == 0 && precisingIteration != 0 ? ApfloatHelper.extendPrecision(z) : z);
    }
}
