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

/**
 * Exception indicating a different radix being used in two operands
 * of a calculation.<p>
 *
 * While it's possible to convert numbers to different radixes using the
 * <code>toRadix()</code> methods, this is highly inefficient. If numbers
 * of different radixes need to be used in a calculation, they should be
 * explicitly converted to matching radixes before attempting the calculation.
 * Otherwise this exception should be thrown.
 *
 * @since 1.5
 * @version 1.5
 * @author Mikko Tommila
 */

public class RadixMismatchException
    extends ApfloatInternalException
{
    /**
     * Constructs a new apfloat radix mismatch exception with an empty detail message.
     */

    public RadixMismatchException()
    {
    }

    /**
     * Constructs a new apfloat radix mismatch exception with the specified detail message.
     *
     * @param message The detail message.
     */

    public RadixMismatchException(String message)
    {
        super(message);
    }

    /**
     * Constructs a new apfloat radix mismatch exception with the specified detail message and cause.
     *
     * @param message The detail message.
     * @param cause Originating cause of the exception.
     */

    public RadixMismatchException(String message, Throwable cause)
    {
        super(message, cause);
    }

    private static final long serialVersionUID = -7022924635011038776L;
}
