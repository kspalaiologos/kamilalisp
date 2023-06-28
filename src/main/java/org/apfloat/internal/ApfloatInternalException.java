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

import org.apfloat.ApfloatRuntimeException;

/**
 * Exception indicating some unexpected apfloat
 * implementation specific error situation.
 * This exception can be thrown in different situations, for example:
 *
 * <ul>
 *   <li>Backing storage failure. For example, if a number is stored on disk,
 *       an <code>IOException</code> can be thrown in any of the disk operations,
 *       if e.g. a file can't be created, or if the disk is full.</li>
 *   <li>Operands of some operation have different radixes.</li>
 *   <li>Other internal limitation, e.g. the maximum transform length
 *       mathematically possible for the implementation, is exceeded.</li>
 * </ul>
 *
 * @since 1.5
 * @version 1.5
 * @author Mikko Tommila
 */

public class ApfloatInternalException
    extends ApfloatRuntimeException
{
    /**
     * Constructs a new apfloat internal exception with an empty detail message.
     */

    public ApfloatInternalException()
    {
    }

    /**
     * Constructs a new apfloat internal exception with the specified detail message.
     *
     * @param message The detail message.
     */

    public ApfloatInternalException(String message)
    {
        super(message);
    }

    /**
     * Constructs a new apfloat internal exception with the specified detail message and cause.
     *
     * @param message The detail message.
     * @param cause Originating cause of the exception.
     */

    public ApfloatInternalException(String message, Throwable cause)
    {
        super(message, cause);
    }

    private static final long serialVersionUID = -7022924635011038776L;
}
