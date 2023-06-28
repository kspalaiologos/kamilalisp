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
package org.apfloat.spi;

import org.apfloat.ApfloatRuntimeException;

/**
 * Generic convolution strategy. To perform the convolution,
 * an implementing class could use e.g.
 *
 * <ul>
 *   <li>A simple long multiplication convolution with O(n<sup>2</sup>) complexity</li>
 *   <li>An O(n<sup>log2(3)</sup>) Karatsuba type algorithm, e.g. <a href="http://www.apfloat.org/log23.html" target="_blank">as desribed in Knuth's Seminumerical Algorithms</a></li>
 *   <li>Floating-point Fast Fourier Transform (FFT) based convolution</li>
 *   <li><a href="http://www.apfloat.org/ntt.html" target="_blank">Number-Theoretic Transform (NTT)</a> based convolution, with the <a href="http://www.apfloat.org/crt.html" target="_blank">Chinese Remainder Theorem</a> used</li>
 * </ul>
 *
 * @version 1.0
 * @author Mikko Tommila
 */

public interface ConvolutionStrategy
{
    /**
     * Convolutes the two sets of data.
     *
     * @param x First data set.
     * @param y Second data set.
     * @param resultSize Number of elements needed in the result data.
     *
     * @return The convolved data.
     */

    public DataStorage convolute(DataStorage x, DataStorage y, long resultSize)
        throws ApfloatRuntimeException;
}
