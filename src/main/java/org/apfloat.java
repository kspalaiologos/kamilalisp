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
import java.util.ListResourceBundle;

import java.lang.management.ManagementFactory;
import java.lang.management.MemoryMXBean;
import java.lang.management.MemoryUsage;

import org.apfloat.ApfloatContext;
import org.apfloat.spi.Util;

/**
 * Default initial settings for the global {@link ApfloatContext}.
 *
 * @version 1.9.0
 * @author Mikko Tommila
 */

public class apfloat
    extends ListResourceBundle
{
    @Override
    public Object[][] getContents()
    {
        return CONTENTS;
    }

    private static final Object[][] CONTENTS;

    static
    {
        // Try to use up to 80% of total memory and all processors
        long totalMemory;
        try
        {
            MemoryMXBean memoryBean = ManagementFactory.getMemoryMXBean();
            MemoryUsage memoryUsage = memoryBean.getHeapMemoryUsage();
            totalMemory = Math.max(memoryUsage.getCommitted(), memoryUsage.getMax());
        }
        catch (NoClassDefFoundError ncdfe)
        {
            // The ManagementFactory class might be unavailable
            totalMemory = Runtime.getRuntime().maxMemory();
        }

        long maxMemoryBlockSize = Util.round23down(totalMemory / 5 * 4);
        int numberOfProcessors = Runtime.getRuntime().availableProcessors();
        long memoryThreshold = Math.max(maxMemoryBlockSize >> 10, 65536);
        int blockSize = Util.round2down((int) Math.min(memoryThreshold, Integer.MAX_VALUE));

        Object[][] contents =
        {
            { ApfloatContext.BUILDER_FACTORY, "org.apfloat.internal.LongBuilderFactory" },
            { ApfloatContext.DEFAULT_RADIX, "10" },
            { ApfloatContext.MAX_MEMORY_BLOCK_SIZE, String.valueOf(maxMemoryBlockSize) },
            { ApfloatContext.CACHE_L1_SIZE, "8192" },
            { ApfloatContext.CACHE_L2_SIZE, "262144" },
            { ApfloatContext.CACHE_BURST, "32" },
            { ApfloatContext.MEMORY_THRESHOLD, String.valueOf(memoryThreshold) },
            { ApfloatContext.SHARED_MEMORY_TRESHOLD, String.valueOf(maxMemoryBlockSize / numberOfProcessors / 32) },
            { ApfloatContext.BLOCK_SIZE, String.valueOf(blockSize) },
            { ApfloatContext.NUMBER_OF_PROCESSORS, String.valueOf(numberOfProcessors) },
            { ApfloatContext.FILE_PATH, "" },
            { ApfloatContext.FILE_INITIAL_VALUE, "0" },
            { ApfloatContext.FILE_SUFFIX, ".ap" },
            { ApfloatContext.CLEANUP_AT_EXIT, "true" }
        };

        CONTENTS = contents;
    }
}
