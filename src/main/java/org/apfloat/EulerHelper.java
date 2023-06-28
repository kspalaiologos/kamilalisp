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

import org.apfloat.ApfloatMath.ApfloatHolder;

/**
 * Helper class for computing the Euler gamma using binary splitting and the Brent-McMillan formula.
 *
 * @since 1.11.0
 * @version 1.11.0
 * @author Mikko Tommila
 */

class EulerHelper
{
    // See http://www.numberworld.org/y-cruncher/internals/binary-splitting-library.html#eulergamma_bm_ab
    // See https://www.ginac.de/CLN/binsplit.pdf

    private EulerHelper(Apfloat n2, long precision, int radix)
        throws ApfloatRuntimeException
    {
        this.n2 = n2;
        this.precision = precision;
        this.radix = radix;
    }

    public static Apfloat euler(long precision, int radix)
        throws ApfloatRuntimeException
    {
        ApfloatHolder Q = new ApfloatHolder(),
                      R = new ApfloatHolder(),
                      S = new ApfloatHolder(),
                      U = new ApfloatHolder();

        long workingPrecision = ApfloatHelper.extendPrecision(precision),
             n = ApfloatHelper.extendPrecision((long) (precision * Math.log(radix) / 4)),
             terms = (long) (ALPHA * n);
        Apfloat nn = new Apfloat(n, workingPrecision, radix),
                n2 = nn.multiply(nn);
        new EulerHelper(n2, workingPrecision, radix).euler(0, terms, null, Q, R, S, null, U, null);
        return U.getApfloat().divide(Q.getApfloat().multiply(R.getApfloat().add(S.getApfloat()))).subtract(ApfloatMath.log(nn)).precision(precision);
    }

    private void euler(long a, long b, ApfloatHolder P, ApfloatHolder Q, ApfloatHolder R, ApfloatHolder S, ApfloatHolder T, ApfloatHolder U, ApfloatHolder V)
        throws ApfloatRuntimeException
    {
        assert (a < b);

        if (b - a == 1)
        {
            Apfloat bb = new Apfloat(b, this.precision, this.radix);
            Apfloat b2 = bb.multiply(bb);
            if (P != null)
            {
                P.setApfloat(new Apfloat(1, this.precision, this.radix));
            }
            Q.setApfloat(bb);
            R.setApfloat(this.n2);
            S.setApfloat(b2);
            if (T != null)
            {
                T.setApfloat(this.n2);
            }
            U.setApfloat(this.n2);
            if (V != null)
            {
                V.setApfloat(b2.multiply(bb));
            }
        }
        else
        {
            long m = a + b >>> 1;
            ApfloatHolder LP = new ApfloatHolder(),
                          LQ = new ApfloatHolder(),
                          LR = new ApfloatHolder(),
                          LS = new ApfloatHolder(),
                          LT = new ApfloatHolder(),
                          LU = new ApfloatHolder(),
                          LV = new ApfloatHolder(),
                          RP = new ApfloatHolder(),
                          RQ = new ApfloatHolder(),
                          RR = new ApfloatHolder(),
                          RS = new ApfloatHolder(),
                          RT = new ApfloatHolder(),
                          RU = new ApfloatHolder(),
                          RV = new ApfloatHolder();

            euler(a, m, LP, LQ, LR, LS, LT, LU, V != null ? LV : null);
            euler(m, b, P != null ? RP : null, RQ, RR, RS, T != null ? RT : null, RU, RV);

            if (P != null)
            {
                P.setApfloat(LP.getApfloat().multiply(RQ.getApfloat()).add(LQ.getApfloat().multiply(RP.getApfloat())));
            }
            Q.setApfloat(LQ.getApfloat().multiply(RQ.getApfloat()));
            R.setApfloat(LR.getApfloat().multiply(RS.getApfloat()).add(LT.getApfloat().multiply(RR.getApfloat())));
            S.setApfloat(LS.getApfloat().multiply(RS.getApfloat()));
            if (T != null)
            {
                T.setApfloat(LT.getApfloat().multiply(RT.getApfloat()));
            }
            U.setApfloat(LU.getApfloat().multiply(RV.getApfloat()).add(LP.getApfloat().multiply(LT.getApfloat()).multiply(RQ.getApfloat()).multiply(RR.getApfloat())).add(LQ.getApfloat().multiply(LT.getApfloat()).multiply(RU.getApfloat())));
            if (V != null)
            {
                V.setApfloat(LV.getApfloat().multiply(RV.getApfloat()));
            }
        }
    }

    private static final double ALPHA = 3.5911214766686221; // 1 / W(1 / e)

    private final Apfloat n2;
    private final long precision;
    private final int radix;
}
