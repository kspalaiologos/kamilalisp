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

import java.lang.ref.SoftReference;
import java.util.AbstractMap;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentMap;
import java.util.concurrent.ConcurrentHashMap;

/**
 * ConcurrentHashMap with softly referenced values.
 * The maximum map size is assumed to be limited so no
 * effort is made to expunge entries for stale values.<p>
 *
 * Values are not properly compared for equality so
 * the only actual concurrent method implemented is
 * <code>putIfAbsent()</code>.<p>
 *
 * @since 1.7.0
 * @version 1.9.0
 * @author Mikko Tommila
 */

class ConcurrentSoftHashMap<K, V>
    extends AbstractMap<K, V>
    implements ConcurrentMap<K, V>
{
    private ConcurrentHashMap<K, SoftReference<V>> map;

    public ConcurrentSoftHashMap()
    {
        this.map = new ConcurrentHashMap<>();
    }

    @Override
    public void clear()
    {
        this.map.clear();
    }

    @Override
    public Set<Map.Entry<K, V>> entrySet()
    {
        throw new UnsupportedOperationException();
    }

    @Override
    public V get(Object key)
    {
        return unwrap(this.map.get(key));
    }

    @Override
    public V put(K key, V value)
    {
        return unwrap(this.map.put(key, wrap(value)));
    }

    @Override
    public V putIfAbsent(K key, V value)
    {
        return unwrap(this.map.putIfAbsent(key, wrap(value)));
    }

    @Override
    public V remove(Object key)
    {
        return unwrap(this.map.remove(key));
    }

    @Override
    public boolean remove(Object key, Object value)
    {
        throw new UnsupportedOperationException();
    }

    @Override
    public V replace(K key, V value)
    {
        throw new UnsupportedOperationException();
    }

    @Override
    public boolean replace(K key, V oldValue, V newValue)
    {
        throw new UnsupportedOperationException();
    }

    @Override
    public int size()
    {
        return this.map.size();
    }

    private SoftReference<V> wrap(V value)
    {
        return new SoftReference<>(value);
    }

    private V unwrap(SoftReference<V> value)
    {
        return (value == null ? null : value.get());
    }
}
