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
 * Constants needed for various modular arithmetic operations for the <code>float</code> type.
 *
 * @version 1.0
 * @author Mikko Tommila
 */

public interface FloatModConstants
{
    /**
     * Moduli to be used in number theoretic transforms.
     * Allows transform lengths upto 3*2<sup>17</sup>.
     */

    public static final float MODULUS[] = { 16515073.0f, 14942209.0f, 14155777.0f };

    /**
     * Primitive roots for the corresponding moduli.
     */

    public static final float PRIMITIVE_ROOT[] = { 5.0f, 11.0f, 7.0f };

    /**
     * Maximum transform length for the moduli.
     */

    public static final long MAX_TRANSFORM_LENGTH = 393216;

    /**
     * Maximum bits in a power-of-two base that fits in a <code>float</code>.
     */

    public static final int MAX_POWER_OF_TWO_BITS = 24;

    /**
     * Maximum power-of-two base that fits in a <code>float</code>.
     */

    public static final float MAX_POWER_OF_TWO_BASE = (float) (1 << MAX_POWER_OF_TWO_BITS);
}
