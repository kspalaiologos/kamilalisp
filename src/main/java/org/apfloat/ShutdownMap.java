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
package org.apfloat;

import java.util.Map;
import java.util.AbstractMap;
import java.util.Set;

/**
 * Map that always throws <code>ApfloatRuntimeException</code> on all operations.
 * Can be used to replace cache maps after JVM shutdown and clean-up
 * has been initiated to prevent other threads from performing any operations.
 *
 * @since 1.6.2
 * @version 1.6.2
 * @author Mikko Tommila
 */

class ShutdownMap<K, V>
    extends AbstractMap<K, V>
{
    public ShutdownMap()
    {
    }

    @Override
    public Set<Map.Entry<K, V>> entrySet()
    {
        throw new ApfloatRuntimeException("Shutdown in progress");
    }

    @Override
    public V put(K key, V value)
    {
        throw new ApfloatRuntimeException("Shutdown in progress");
    }
}
