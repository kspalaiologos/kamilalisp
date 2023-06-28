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
 * Interface of a factory for creating Number Theoretic Transforms.
 * The factory method pattern is used.
 *
 * @see NTTStrategy
 * @see NTTStepStrategy
 *
 * @version 1.7.0
 * @author Mikko Tommila
 */

public interface NTTBuilder
{
    /**
     * Creates a Number Theoretic Transform of suitable
     * type for the specified length.
     *
     * @param size The transform length that will be used.
     *
     * @return A suitable NTT object for performing the transform.
     */

    public NTTStrategy createNTT(long size);

    /**
     * Creates an object for implementing the steps of a step-based
     * Number Theoretic Transform.
     *
     * @return A suitable object for performing the transform steps.
     *
     * @since 1.7.0
     */

    public NTTStepStrategy createNTTSteps();

    /**
     * Creates an object for implementing the steps of a three-NTT
     * based convolution.
     *
     * @return A suitable object for performing the convolution steps.
     *
     * @since 1.7.0
     */

    public NTTConvolutionStepStrategy createNTTConvolutionSteps();

    /**
     * Creates an object for implementing the steps of factor-3 NTT.
     *
     * @return A suitable object for performing the factor-3 NTT steps.
     *
     * @since 1.7.0
     */

    public Factor3NTTStepStrategy createFactor3NTTSteps();
}
