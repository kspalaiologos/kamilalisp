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

import java.util.Map;
import java.util.WeakHashMap;
import java.util.concurrent.Callable;
import java.util.concurrent.FutureTask;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

import org.apfloat.ApfloatContext;
import org.apfloat.spi.NTTStrategy;

/**
 * Convolution using three Number Theoretic Transforms
 * and the CRT to get the final result, using multiple threads in parallel.<p>
 *
 * This algorithm is parallelized so that all operations are done in parallel
 * using multiple threads, if the number of processors is greater than one
 * in {@link ApfloatContext#getNumberOfProcessors()}.<p>
 *
 * If the data block to be transformed is larger than the shared memory threshold setting
 * in the current ApfloatContext, this class will synchronize all data access on
 * the shared memory lock retrieved from {@link ApfloatContext#getSharedMemoryLock()}.<p>
 *
 * All access to this class must be externally synchronized.
 *
 * @since 1.7.0
 * @version 1.9.0
 * @author Mikko Tommila
 */

public class ParallelThreeNTTConvolutionStrategy
    extends ThreeNTTConvolutionStrategy
{
    private static class LockFuture
        extends FutureTask<Void>
    {
        public LockFuture(Lock lock)
        {
            super(VOID_CALLABLE);
            this.thread = Thread.currentThread();   // Store the calling thread as the lock (and unlock) is thread-specific
            this.lock = lock;
        }

        @Override
        public synchronized boolean isDone()
        {
            if (!this.done && Thread.currentThread().equals(this.thread))   // Only the thread making the wait(Future) call should lock the lock, as it will unlock it also
            {
                this.done = this.lock.tryLock();
            }
            return this.done;
        }

        private static final Callable<Void> VOID_CALLABLE = () -> null;

        private Thread thread;
        private Lock lock;
        private boolean done;
    }

    /**
     * Creates a new convoluter that uses the specified
     * transform for transforming the data.
     *
     * @param radix The radix to be used.
     * @param nttStrategy The transform to be used.
     */

    public ParallelThreeNTTConvolutionStrategy(int radix, NTTStrategy nttStrategy)
    {
        super(radix, nttStrategy);
    }

    @Override
    protected void lock(long length)
    {
        assert(this.key == null);

        if (super.nttStrategy instanceof Parallelizable &&
            super.carryCRTStrategy instanceof Parallelizable &&
            super.stepStrategy instanceof Parallelizable)
        {
            ApfloatContext ctx = ApfloatContext.getContext();
            if (length > ctx.getSharedMemoryTreshold() / ctx.getBuilderFactory().getElementSize())
            {
                // Data size is big: synchronize on shared memory lock
                this.key = ctx.getSharedMemoryLock();

                if (this.key != null)
                {
                    Lock lock;
                    synchronized (ParallelThreeNTTConvolutionStrategy.locks)
                    {
                        lock = ParallelThreeNTTConvolutionStrategy.locks.computeIfAbsent(this.key, k -> new ReentrantLock());
                    }
                    ctx.wait(new LockFuture(lock));
                }
            }
        }
    }

    @Override
    protected void unlock()
    {
        if (this.key != null)
        {
            synchronized (ParallelThreeNTTConvolutionStrategy.locks)
            {
                ParallelThreeNTTConvolutionStrategy.locks.get(this.key).unlock();
            }
        }
    }

    private static Map<Object, Lock> locks = new WeakHashMap<>();

    private Object key;
}
