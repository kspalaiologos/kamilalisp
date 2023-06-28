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
package org.apfloat.internal;

import org.apfloat.spi.Util;

/**
 * Functions to perform bit-reverse ordering of data.
 *
 * @version 1.0
 * @author Mikko Tommila
 */

public class Scramble
{
    private Scramble()
    {
    }

    /**
     * Permute the bits of a number to reverse order.<p>
     *
     * For example, if <code>n</code> is 5 and the transform
     * length is 256, the permutation is (in binary)<p>
     *
     * 00000101 &rarr; 10100000
     *
     * @param n The number whose bits to reverse.
     * @param length The FFT transform length for which the bit reversal to perform.
     *
     * @return The bits of <code>n</code> reversed.
     */

    public static int permute(int n, int length)
    {
        assert (length == (length & -length));

        int p = 1;

        while (p < length)
        {
            p += p + (n & 1);
            n >>= 1;
        }

        return p - length;
    }

    /**
     * Create a table of indexes for scrambling an array for FFT.<p>
     *
     * The returned table contains pairs of indexes that should be swapped
     * to scramble an array. For example, for transform length 8 the
     * returned table contains <code>{ 1, 4, 3, 6 }</code> to indicate
     * that the array elements [1] and [4] should be swapped, and the elements
     * [3] and [6] should be swapped.
     *
     * @param length The FFT transform length for which the scrambling table is created.
     *
     * @return An array of pairs of indexes that indicate, which array elements should be swapped to scramble the array.
     */

    public static int[] createScrambleTable(int length)
    {
        assert (length == (length & -length));

        int[] scrambleTable = new int[length - Util.sqrt4up(length)];

        for (int i = 0, k = 0; i < length; i++)
        {
            int j = permute(i, length);
            if (j < i)
            {
                scrambleTable[k] = i;
                scrambleTable[k + 1] = j;
                k += 2;
            }
        }

        return scrambleTable;
    }
}
