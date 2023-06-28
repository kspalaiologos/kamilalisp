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

import java.util.concurrent.atomic.AtomicLong;

import org.apfloat.spi.Util;

/**
 * Abstract class for a <code>Runnable</code> that can be run in parallel by
 * multiple threads. Internally, the <code>ParallelRunnable</code> splits the
 * work to many small batches, which are run one at a time, and can be run in
 * parallel by multiple threads. The <code>ParallelRunnable</code> isn't
 * completed until all batches are completed, i.e. the {@link #run()} method
 * only returns when all batches are completed.
 *
 * @since 1.1
 * @version 1.9.0
 * @author Mikko Tommila
 */

public abstract class ParallelRunnable
    implements Runnable
{
    /**
     * Subclass constructor.
     *
     * @param length The length of the work to be run.
     */

    protected ParallelRunnable(long length)
    {
        // Set the batch size to be some balanced value with respect to the batch size and the number of batches
        this.preferredBatchSize = Util.sqrt4down(length);
        this.length = length;
        this.started = new AtomicLong();
        this.completed = new AtomicLong();
    }

    /**
     * Repeatedly get a batch of work and run it, until all batches are
     * completed. This method can (and should) be called from multiple
     * threads in parallel.
     */

    @Override
    public final void run()
    {
        // Run batches as long as there are any available
        while (runBatch());

        // Wait until all batches are completed (the above only says all batches were started)
        // Note that accessing this atomic variable also ensures that memory writes in other
        // threads have happened-before we get here and see that the task is completed
        while (isWorkToBeCompleted())
        {
            Thread.yield();     // Do not waste time
        }
    }

    /**
     * Run one batch if available. Returns <code>true</code> if a batch was
     * actually acquired and run, <code>false</code> if all batches were
     * already started and none could be run. This method can be used by any
     * thread to steal and complete a minimal amount of work.<p>
     *
     * Note that if a batch could not be run, it does not mean that all of
     * the batches are already completed - some could still be running.
     *
     * @return If a batch was actually run.
     */

    public final boolean runBatch()
    {
        boolean isRun = false;
        if (isWorkToBeStarted())
        {
            long batchSize = Math.max(MINIMUM_BATCH_SIZE, getPreferredBatchSize());
            long startValue = this.started.getAndAdd(batchSize);
            long length = Math.min(batchSize, this.length - startValue);
            if (length > 0)
            {
                Runnable runnable = getRunnable(startValue, length);
                runnable.run();
                // This ensures that all memory writes in the Runnable happen-before other threads can see that the batch was completed
                this.completed.addAndGet(length);
                isRun = true;
            }
        }
        return isRun;
    }

    /**
     * Returns if there is still enough work left to start a new batch.
     *
     * @return If a new batch could be started to still perform some work.
     *
     * @since 1.9.0
     */

    public boolean isWorkToBeStarted()
    {
        return this.started.get() < this.length;
    }

    /**
     * Returns if there is some work that may be currently processed but not yet finished.
     *
     * @return If there is still some work left that is not completed yet.
     *
     * @since 1.9.0
     */

    public boolean isWorkToBeCompleted()
    {
        return this.completed.get() < this.length;
    }

    /**
     * Get the Runnable object for strides which fit in an <code>int</code>.
     *
     * @param startValue The starting value for the stride.
     * @param length The length of the stride.
     *
     * @return The Runnable object for the specified stride.
     */

    protected Runnable getRunnable(int startValue, int length)
    {
        throw new UnsupportedOperationException("Not implemented");
    }

    /**
     * Get the Runnable object for strides which fit only in a <code>long</code>.
     *
     * @param startValue The starting value for the stride.
     * @param length The length of the stride.
     *
     * @return The Runnable object for the specified stride.
     */

    protected Runnable getRunnable(long startValue, long length)
    {
        if (startValue <= Integer.MAX_VALUE - length)   // Avoid overflow
        {
            return getRunnable((int) startValue, (int) length);
        }
        else
        {
            throw new UnsupportedOperationException("Not implemented");
        }
    }

    /**
     * Get the preferred batch size.
     *
     * @return The preferred batch size.
     *
     * @since 1.7.0
     */

    protected long getPreferredBatchSize()
    {
        return this.preferredBatchSize;
    }

    private static final int MINIMUM_BATCH_SIZE = 16;

    private long length;
    private long preferredBatchSize;
    private AtomicLong started;
    private AtomicLong completed;
}
