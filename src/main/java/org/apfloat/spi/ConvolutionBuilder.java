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

/**
 * Interface of a factory for creating convolutors.
 * The factory method pattern is used.
 *
 * @see ConvolutionStrategy
 *
 * @version 1.0
 * @author Mikko Tommila
 */

public interface ConvolutionBuilder
{
    /**
     * Returns a convolution strategy of suitable
     * type for the specified length.
     *
     * @param radix The radix that will be used.
     * @param size1 Length of first data set.
     * @param size2 Length of second data set.
     * @param resultSize Minimum number of elements needed in the result data.
     *
     * @return A suitable object for performing the convolution.
     */

    public ConvolutionStrategy createConvolution(int radix, long size1, long size2, long resultSize);
}
