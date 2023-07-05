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
 * Steps for a three-NTT convolution. This includes element-by-element
 * multiplication and squaring of the transformed data.
 *
 * @since 1.7.0
 * @version 1.7.0
 * @author Mikko Tommila
 */

public interface NTTConvolutionStepStrategy
{
    /**
     * Linear multiplication in the number theoretic domain.
     * The operation is <code>sourceAndDestination[i] *= source[i] (mod m)</code>.<p>
     *
     * For maximum performance, <code>sourceAndDestination</code>
     * should be in memory if possible.
     *
     * @param sourceAndDestination The first source data storage, which is also the destination.
     * @param source The second source data storage.
     * @param modulus Which modulus to use (0, 1, 2)
     */

    public void multiplyInPlace(DataStorage sourceAndDestination, DataStorage source, int modulus)
        throws ApfloatRuntimeException;

    /**
     * Linear squaring in the number theoretic domain.
     * The operation is <code>sourceAndDestination[i] *= sourceAndDestination[i] (mod m)</code>.<p>
     *
     * For maximum performance, <code>sourceAndDestination</code>
     * should be in memory if possible.
     *
     * @param sourceAndDestination The source data storage, which is also the destination.
     * @param modulus Which modulus to use (0, 1, 2)
     */

    public void squareInPlace(DataStorage sourceAndDestination, int modulus)
        throws ApfloatRuntimeException;
}
