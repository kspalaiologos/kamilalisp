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

import java.util.Queue;
import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Future;

import org.apfloat.ApfloatContext;
import org.apfloat.ApfloatRuntimeException;

/**
 * Class for running <code>ParallelRunnable</code> objects in parallel using
 * multiple threads.<p>
 *
 * The ParallelRunner assumes that the current {@link ApfloatContext} returns an
 * <code>ExecutorService</code> that is limited to a number of threads that is
 * one less than the number of processors. This way, when also the current thread
 * runs batches from the <code>ParallelRunnable</code>, CPU utilization should be
 * maximized but only so that no more threads are actively executing than the
 * number of processors.
 *
 * @since 1.1
 * @version 1.9.0
 * @author Mikko Tommila
 */

public class ParallelRunner
{
    private ParallelRunner()
    {
    }

    /**
     * Run a ParallelRunnable object in parallel using multiple threads.
     * The method assumes that the <code>ExecutorService</code> returned from
     * {@link ApfloatContext#getExecutorService()} is limited to using one
     * thread less than the number of processors. This maximizes CPU usage,
     * When the <code>ParallelRunnable</code> is also run from the current thread.
     *
     * @param parallelRunnable The ParallelRunnable to be run.
     */

    public static void runParallel(ParallelRunnable parallelRunnable)
        throws ApfloatRuntimeException
    {
        ParallelRunner.tasks.add(parallelRunnable);
        try
        {
            runTasks(parallelRunnable);
        }
        finally
        {
            ParallelRunner.tasks.remove(parallelRunnable);
        }
    }

    /**
     * While waiting for a <code>Future</code> to be completed, steal a minimal
     * amount of work from any running task and run it.
     *
     * @param future The Future to wait for.
     */

    public static void wait(Future<?> future)
    {
        Runnable stealer = () -> {
            while (!future.isDone())
            {
                // Try and get any running task
                ParallelRunnable parallelRunnable = ParallelRunner.tasks.peek();
                if (parallelRunnable != null)
                {
                    // Steal a minimal amount of work while we wait
                    parallelRunnable.runBatch();
                }
                else
                {
                    // Actually idle - give up the rest of the CPU time slice
                    Thread.yield();
                }
            }
        };

        runTasks(stealer);
    }

    private static void runTasks(Runnable runnable)
    {
        ApfloatContext ctx = ApfloatContext.getContext();
        int numberOfProcessors = ctx.getNumberOfProcessors();

        if (numberOfProcessors > 1)
        {
            ExecutorService executorService = ctx.getExecutorService();

            for (int i = 0; i < numberOfProcessors - 1; i++)
            {
                // Process the task also in other threads
                executorService.execute(runnable);
            }
        }

        // Also process the task in the current thread, until it is finished
        runnable.run();
    }

    // Implemented as a List because the assumption is that the number of concurrent tasks is very small
    private static Queue<ParallelRunnable> tasks = new ConcurrentLinkedQueue<>();
}
