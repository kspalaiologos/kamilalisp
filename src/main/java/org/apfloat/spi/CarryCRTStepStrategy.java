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
 * Interface for performing the steps of a carry-CRT operation in a convolution.
 *
 * @param <T> The element array type of the carry-CRT steps.
 *
 * @since 1.7.0
 * @version 1.7.0
 * @author Mikko Tommila
 */

public interface CarryCRTStepStrategy<T>
{
    /**
     * Perform the Chinese Remainder Theorem (CRT) on each element
     * of the three result data sets to get the result of each element
     * modulo the product of the three moduli. Then it calculates the carries
     * for the block of data to get the final result.<p>
     *
     * Note that the return value's initial word may be zero or non-zero,
     * depending on how large the result is.<p>
     *
     * Assumes that <code>MODULUS[0] &gt; MODULUS[1] &gt; MODULUS[2]</code>.
     *
     * @param resultMod0 The result modulo <code>MODULUS[0]</code>.
     * @param resultMod1 The result modulo <code>MODULUS[1]</code>.
     * @param resultMod2 The result modulo <code>MODULUS[2]</code>.
     * @param dataStorage The destination data storage of the computation.
     * @param size The number of elements in the whole data set.
     * @param resultSize The number of elements needed in the final result.
     * @param offset The offset within the data for the block to be computed.
     * @param length Length of the block to be computed.
     *
     * @return The carries overflowing from this block (two elements).
     */

    public T crt(DataStorage resultMod0, DataStorage resultMod1, DataStorage resultMod2, DataStorage dataStorage, long size, long resultSize, long offset, long length)
        throws ApfloatRuntimeException;

    /**
     * Propagate carries from the previous block computed with the CRT
     * method.
     *
     * @param dataStorage The destination data storage of the computation.
     * @param size The number of elements in the whole data set.
     * @param resultSize The number of elements needed in the final result.
     * @param offset The offset within the data for the block to be computed.
     * @param length Length of the block to be computed.
     * @param results The carry overflow from this block (two elements).
     * @param previousResults The carry overflow from the previous block (two elements).
     *
     * @return The carries overflowing from this block (two elements).
     */

    public T carry(DataStorage dataStorage, long size, long resultSize, long offset, long length, T results, T previousResults)
        throws ApfloatRuntimeException;
}
