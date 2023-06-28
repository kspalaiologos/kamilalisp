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

import java.io.PushbackReader;
import java.io.IOException;

import org.apfloat.ApfloatRuntimeException;

/**
 * An ApfloatBuilder contains factory methods to create
 * new instances of {@link ApfloatImpl} implementations.
 *
 * @version 1.0
 * @author Mikko Tommila
 */

public interface ApfloatBuilder
{
    /**
     * Create a new <code>ApfloatImpl</code> instance from a <code>String</code>.
     *
     * @param value The string to be parsed to a number.
     * @param precision The precision of the number (in digits of the radix).
     * @param radix The radix in which the number is created.
     * @param isInteger Specifies if the number to be parsed from the string is to be treated as an integer or not.
     *
     * @return A new <code>ApfloatImpl</code>.
     *
     * @exception NumberFormatException If the number is not valid.
     */

    public ApfloatImpl createApfloat(String value, long precision, int radix, boolean isInteger)
        throws NumberFormatException, ApfloatRuntimeException;

    /**
     * Create a new <code>ApfloatImpl</code> instance from a <code>long</code>.
     *
     * @param value The value of the number.
     * @param precision The precision of the number (in digits of the radix).
     * @param radix The radix in which the number is created.
     *
     * @return A new <code>ApfloatImpl</code>.
     *
     * @exception NumberFormatException If the number is not valid.
     */

    public ApfloatImpl createApfloat(long value, long precision, int radix)
        throws NumberFormatException, ApfloatRuntimeException;

    /**
     * Create a new <code>ApfloatImpl</code> instance from a <code>double</code>.
     *
     * @param value The value of the number.
     * @param precision The precision of the number (in digits of the radix).
     * @param radix The radix in which the number is created.
     *
     * @return A new <code>ApfloatImpl</code>.
     *
     * @exception NumberFormatException If the number is not valid.
     */

    public ApfloatImpl createApfloat(double value, long precision, int radix)
        throws NumberFormatException, ApfloatRuntimeException;

    /**
     * Create a new <code>ApfloatImpl</code> instance reading from a stream.
     *
     * @param in The stream to read from.
     * @param precision The precision of the number (in digits of the radix).
     * @param radix The radix in which the number is created.
     * @param isInteger Specifies if the number to be parsed from the stream is to be treated as an integer or not.
     *
     * @return A new <code>ApfloatImpl</code>.
     *
     * @exception IOException If an I/O error occurs accessing the stream.
     * @exception NumberFormatException If the number is not valid.
     */

    public ApfloatImpl createApfloat(PushbackReader in, long precision, int radix, boolean isInteger)
        throws IOException, NumberFormatException, ApfloatRuntimeException;
}
