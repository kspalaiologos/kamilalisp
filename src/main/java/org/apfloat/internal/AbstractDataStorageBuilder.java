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

import org.apfloat.ApfloatContext;
import org.apfloat.ApfloatRuntimeException;
import org.apfloat.spi.DataStorageBuilder;
import org.apfloat.spi.DataStorage;

/**
 * Abstract base class for a data storage creation strategy.
 * Depending on the implementation-specific element size, the
 * requested data length and threshold values configured in the
 * current {@link ApfloatContext}, different types of data storages
 * are created.
 *
 * @since 1.7.0
 * @version 1.8.2
 * @author Mikko Tommila
 */

public abstract class AbstractDataStorageBuilder
    implements DataStorageBuilder
{
    /**
     * Subclass constructor.
     */

    protected AbstractDataStorageBuilder()
    {
    }

    @Override
    public DataStorage createDataStorage(long size)
        throws ApfloatRuntimeException
    {
        ApfloatContext ctx = ApfloatContext.getContext();

        // Sizes are in bytes
        if (size <= ctx.getMemoryThreshold() && size <= getMaxCachedSize())
        {
            return createCachedDataStorage();
        }
        else
        {
            return createNonCachedDataStorage();
        }
    }

    @Override
    public DataStorage createCachedDataStorage(long size)
        throws ApfloatRuntimeException
    {
        ApfloatContext ctx = ApfloatContext.getContext();

        // Sizes are in bytes
        if (size <= ctx.getMaxMemoryBlockSize() && size <= getMaxCachedSize())
        {
            // Use memory data storage if it can fit in memory
            return createCachedDataStorage();
        }
        else
        {
            // If it can't fit in memory then still have to use disk data storage
            return createNonCachedDataStorage();
        }
    }

    @Override
    public DataStorage createDataStorage(DataStorage dataStorage)
        throws ApfloatRuntimeException
    {
        if (isCached(dataStorage))
        {
            long size = dataStorage.getSize();
            ApfloatContext ctx = ApfloatContext.getContext();

            // Sizes are in bytes
            if (size > ctx.getMemoryThreshold())
            {
                // If it is a memory data storage and should be moved to disk then do so
                DataStorage tmp = createNonCachedDataStorage();
                tmp.copyFrom(dataStorage);
                dataStorage = tmp;
            }
        }
        return dataStorage;
    }

    /**
     * Get the maximum cached data storage size.
     *
     * @return The maximum cached data storage size.
     */

    protected abstract long getMaxCachedSize();

    /**
     * Create a cached data storage.
     *
     * @return A new cached data storage.
     */

    protected abstract DataStorage createCachedDataStorage()
        throws ApfloatRuntimeException;

    /**
     * Create a non-cached data storage.
     *
     * @return A new non-cached data storage.
     */

    protected abstract DataStorage createNonCachedDataStorage()
        throws ApfloatRuntimeException;

    /**
     * Test if the data storage is of cached type.
     *
     * @param dataStorage The data storage.
     *
     * @return If the data storage is cached.
     */

    protected abstract boolean isCached(DataStorage dataStorage)
        throws ApfloatRuntimeException;
}
