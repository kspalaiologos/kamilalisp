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
 * Steps for the factor-3 NTT.
 *
 * @since 1.7.0
 * @version 1.7.0
 * @author Mikko Tommila
 */

public interface Factor3NTTStepStrategy
{
    /**
     * Transform the columns of a matrix using a 3-point transform.
     *
     * @param dataStorage0 The data of the first column.
     * @param dataStorage1 The data of the second column.
     * @param dataStorage2 The data of the third column.
     * @param startColumn The starting element index in the data storages to transform.
     * @param columns How many columns to transform.
     * @param power2length Length of the column transform.
     * @param length Length of total transform (three times the length of one column).
     * @param isInverse <code>true</code> if an inverse transform is performed, <code>false</code> if a forward transform is performed.
     * @param modulus Index of the modulus.
     */

    public void transformColumns(DataStorage dataStorage0, DataStorage dataStorage1, DataStorage dataStorage2, long startColumn, long columns, long power2length, long length, boolean isInverse, int modulus)
        throws ApfloatRuntimeException;

    /**
     * Get the maximum transform length.
     *
     * @return The maximum transform length.
     */

    public long getMaxTransformLength();
}
