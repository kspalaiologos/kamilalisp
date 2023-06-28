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

import java.util.Iterator;

import org.apfloat.spi.Util;

/**
 * Helper class for the Hurwitz zeta function.
 *
 * @since 1.11.0
 * @version 1.11.0
 * @author Mikko Tommila
 */

class HurwitzZetaHelper
{
    // See https://arxiv.org/pdf/1309.2877.pdf
    // Rigorous high-precision computation of the Hurwitz zeta function and its derivatives, Fredrik Johansson

    public static Apcomplex zeta(Apcomplex s, Apcomplex a)
    {
        int radix = a.radix();
        Apint one = new Apint(1, radix);
        if (s.equals(one))
        {
            throw new ArithmeticException("Zeta of first argument one");
        }
        if (s.real().signum() == 0 && s.imag().signum() == 0 && a.real().signum() == 0 && a.imag().signum() == 0)
        {
            Apint two = new Apint(2, radix);
            return new Aprational(one, two);
        }
        long precision = Math.min(s.precision(),  a.precision());
        if (a.isInteger() && a.real().signum() <= 0)
        {
            if (s.real().signum() < 0 || s.real().signum() == 0 && s.imag().signum() == 0)
            {
                // Use recurrence formula: zeta(s, a) = a^-s + zeta(s, a + 1)
                Apcomplex t = Apcomplex.ZERO;
                long i = a.longValueExact();
                while (i++ <= 0)
                {
                    t = t.add(ApcomplexMath.pow(a, s.negate()));
                    a = a.add(one);
                }
                a = a.precision(precision);
                return t.add(zeta(s, a).precision(precision));  // Precision is not correct as S, I and T cancel out each other
            }

            throw new ArithmeticException("Zeta of second argument nonpositive integer");
        }
        if (precision == Apfloat.INFINITE)
        {
            throw new InfiniteExpansionException("Cannot calculate zeta function to infinite precision");
        }
        long doublePrecision = ApfloatHelper.getDoublePrecision(radix);
        // Must be: ℜ(a) + N > 1 and ℜ(s) + 2M > 1
        // We can set N = M for a basic case
        // Far in the critical strip N should be larger than M for better efficiency
        // Note that the search is for the absolute size of the error term, not the relative error (relative to the value of the zeta function being evaluated)
        // Thus we would first need some guess for the scale of the value of the Hurwitz zeta function, to have a goal for the size of the error term
        long zetaScale = Math.min(0, zetaScale(s.precision(doublePrecision), a.precision(doublePrecision)));
        Apint N = binarySearch(ApfloatHelper.limitPrecision(s, doublePrecision), ApfloatHelper.limitPrecision(a, doublePrecision), precision, -Util.ifFinite(-zetaScale, precision - zetaScale)),
              M = N;
        s = ApfloatHelper.extendPrecision(s);
        a = ApfloatHelper.extendPrecision(a);
        Apcomplex S = S(s, a, N.longValueExact()),
                  I = I(s, a, N),
                  T = T(s, a, N, M.longValueExact());
        return ApfloatHelper.reducePrecision(S.add(I).add(T));
    }

    private static long zetaScale(Apcomplex s, Apcomplex a)
    {
        // Increase the precision to avoid loss of precision exception
        long extraPrecision = Math.max(0, Math.max(s.scale(), a.scale()));
        Apint one = Apint.ONES[a.radix()];
        s = ApfloatHelper.extendPrecision(s, extraPrecision);
        a = ApfloatHelper.extendPrecision(a, extraPrecision);
        return ApcomplexMath.pow(a, one.subtract(s)).divide(s.subtract(one)).scale();   // Is not actually valid if re(s) <= 1 or re(a) <= 0
    }

    private static Apint binarySearch(Apcomplex s, Apcomplex a, long precision, long targetScale)
    {
        int radix = a.radix();
        Apint one = Apint.ONES[radix],
              two = new Apint(2, radix),
              min = ApintMath.max(two.subtract(a.real().truncate()), one.subtract(s.real()).divide(two).truncate().add(one)),
              N = ApintMath.max(new Apint(precision, radix), min);
        long M = N.longValueExact(),
             low = M,
             high = M;
        Apfloat R = R(s, a, N, M);
        // Initial search to find another point on the other side
        // double or halve the current point to find it
        while (R.scale() >= targetScale)
        {
            low = M;
            // R is too large, M is too small
            M = Math.multiplyExact(2, M);
            N = new Apint(M, radix);
            R = R(s, a, N, M);
            high = M;
        }
        if (low == high)
        {
            long lowLimit = Math.max(0,  min.longValueExact());
            while (R.scale() < targetScale && M > lowLimit)
            {
                high = M;
                // R is too small, M is too large
                M = Math.max(M >> 1, lowLimit);
                N = new Apint(M, radix);
                R = R(s, a, N, M);
                low = M;
            }
        }
        // Now that we have a range [low, high] find the point where R.scale() is just less than targetScale
        while (high - low > 1)
        {
            // Test mid point of range
            M = high + low >>> 1;
            N = new Apint(M, radix);
            R = R(s, a, N, M);
            if (R.scale() >= targetScale)
            {
                // Mid point R is too large, M is too small
                low = M;
            }
            else
            {
                // Mid point R is too small, M is too large
                high = M;
            }
        }
        return new Apint(high, radix);
    }

    private static Apfloat R(Apcomplex s, Apcomplex a, Apint N, long M)
    {
        int radix = a.radix();
        Apint two = new Apint(2, radix),
              four = new Apint(4, radix),
              M2 = new Apint(2 * M, radix);
        Apfloat σ = s.real(),
                τ = s.imag(),
                α = a.real(),
                β = a.imag(),
                pi = ApfloatMath.pi(ApfloatHelper.getDoublePrecision(radix), radix);
        Apfloat K = ApfloatMath.exp(ApfloatMath.max(Apfloat.ZEROS[radix], expPrecision(τ.multiply(ApfloatMath.atan(β.divide(α.add(N))))))),
                R = K.multiply(J(N.add(α), σ.add(M2)));
        return four.multiply(ApcomplexMath.abs(pochhammer(s, 2 * M))).divide(ApfloatMath.pow(two.multiply(pi), 2 * M)).multiply(ApfloatMath.abs(R));
    }

    private static Apfloat J(Apfloat A, Apfloat B)
    {
        Apint one = Apint.ONES[A.radix()];
        Apfloat B1 = B.subtract(one);
        return one.divide(B1.multiply(ApfloatMath.pow(A, B1)));
    }

    private static Apcomplex pochhammer(Apcomplex s, long n)
    {
        Apint one = Apcomplex.ONES[s.radix()];
        Apcomplex p = one;
        for (int k = 0; k < n; k++)
        {
            p = p.multiply(s);
            s = s.add(one);
        }
        return p;
    }

    private static Apcomplex S(Apcomplex s, Apcomplex a, long N)
    {
        int radix = a.radix();
        Apcomplex sum = Apcomplex.ZEROS[radix];
        for (long k = 0; k < N; k++)
        {
            sum = sum.add(ApcomplexMath.pow(a.add(new Apint(k, radix)), s.negate()));
        }
        return sum;
    }

    private static Apcomplex I(Apcomplex s, Apcomplex a, Apint N)
    {
        int radix = a.radix();
        Apint one = Apint.ONES[radix];
        return ApcomplexMath.pow(a.add(N), one.subtract(s)).divide(s.subtract(one));
    }

    private static Apcomplex T(Apcomplex s, Apcomplex a, Apint N, long M)
    {
        int radix = a.radix();
        Apint one = Apint.ONES[radix];
        Apcomplex sum = new Aprational(one, new Apint(2, radix)),
                  aN = a.add(N),
                  aN2 = ApcomplexMath.pow(aN, -2),
                  pochhammer = s,
                  factor = pochhammer.divide(aN);
        Iterator<Aprational> bernoullis = AprationalMath.bernoullis2(M, radix);
        for (long k = 1; k <= M; k++)
        {
            factor = factor.divide(new Apint(2 * k - 1, radix).multiply(new Apint(2 * k, radix)));
            sum = sum.add(bernoullis.next().multiply(factor));
            if (k < M)
            {
                pochhammer = pochhammer.add(one);
                factor = factor.multiply(pochhammer);
                pochhammer = pochhammer.add(one);
                factor = factor.multiply(pochhammer).multiply(aN2);
            }
        }
        return sum.multiply(ApcomplexMath.pow(aN, s.negate()));
    }

    private static Apfloat expPrecision(Apfloat x)
    {
        // Increase the precision to avoid loss of precision exception
        return ApfloatHelper.extendPrecision(x, Math.max(0, x.scale()));
    }
}
