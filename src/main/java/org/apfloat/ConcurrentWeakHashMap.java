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

import java.lang.ref.ReferenceQueue;
import java.lang.ref.WeakReference;
import java.util.AbstractMap;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Combination of WeakHashMap and ConcurrentHashMap,
 * providing weak keys and non-blocking access.
 *
 * @since 1.5
 * @version 1.9.0
 * @author Mikko Tommila
 */

class ConcurrentWeakHashMap<K, V>
    extends AbstractMap<K, V>
{
    private static class Key
        extends WeakReference<Object>
    {
        private int hashCode;

        public Key(Object key, ReferenceQueue<Object> queue)
        {
            super(key, queue);
            this.hashCode = key.hashCode();
        }

        @Override
        public int hashCode()
        {
            return this.hashCode;
        }

        @Override
        public boolean equals(Object obj)
        {
            if (this == obj)
            {
                // Always matches even if referenced object has been garbage collected, needed for expunging garbage collected keys
                return true;
            }
            if (obj instanceof Key)
            {
                Key that = (Key) obj;
                Object value = get();
                return (value != null && value.equals(that.get()));
            }
            return false;
        }
    }

    private ConcurrentHashMap<Key, V> map;
    private ReferenceQueue<Object> queue;

    public ConcurrentWeakHashMap()
    {
        this.map = new ConcurrentHashMap<>();
        this.queue = new ReferenceQueue<>();
    }

    @Override
    public void clear()
    {
        expungeStaleEntries();
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
        // Do not expunge stale entries here to improve performance
        return this.map.get(wrap(key));
    }

    @Override
    public V put(K key, V value)
    {
        expungeStaleEntries();
        return this.map.put(wrap(key), value);
    }

    @Override
    public V remove(Object key)
    {
        expungeStaleEntries();
        return this.map.remove(wrap(key));
    }

    @Override
    public boolean isEmpty()
    {
        // This is for the quick check, therefore we do not expunge stale entries here
        return this.map.isEmpty();
    }

    @Override
    public int size()
    {
        expungeStaleEntries();
        return this.map.size();
    }

    private Key wrap(Object key)
    {
        return new Key(key, this.queue);
    }

    private void expungeStaleEntries()
    {
        // Should not cause (much) blocking
        Key key;
        while ((key = (Key) this.queue.poll()) != null)
        {
            this.map.remove(key);
        }
    }
}
