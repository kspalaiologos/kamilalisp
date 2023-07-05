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

import java.util.Arrays;
import java.util.List;
import java.util.ArrayList;
import java.util.Queue;
import java.util.PriorityQueue;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Future;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * Helper methods for parallel algorithms.
 *
 * @since 1.8.0
 * @version 1.9.0
 * @author Mikko Tommila
 */

class ParallelHelper
{
    @FunctionalInterface
    public interface ProductKernel<T extends Apcomplex>
    {
        public void run(Queue<T> heap);
    }

    private ParallelHelper()
    {
    }

    /**
     * Multiply two smallest elements in the heap and put the product back to the heap,
     * until only one element remains.
     *
     * @param x The elements to be multiplied.
     * @param heap The priority queue to use. Must be initially empty.
     * @param kernel The multiplication kernel callback.
     */

    // Thanks to Peter Luschny and Spiro Trikaliotis for the improved algorithm!
    public static <T extends Apcomplex> void parallelProduct(T[] x, Queue<T> heap, ProductKernel<T> kernel)
    {
        // If there are lots of numbers then use a fully parallel algorithm, for small products the overhead is not worth it
        ApfloatContext ctx = ApfloatContext.getContext();
        int numberOfProcessors = ctx.getNumberOfProcessors();
        if (x.length >= 1000 && numberOfProcessors > 1)
        {
            // First multiply small numbers in parallel;
            // number size would be so small that they would not be multiplied using a parallel algorithm (roughly dependent on cache L1 size)
            long maxSize = (long) (ctx.getCacheL1Size() * 2.5 / Math.log((double) ctx.getDefaultRadix()));
            // There is no efficient "ConcurrentPriorityQueue" data structure, so we just split the data
            List<Queue<T>> subHeaps = new ArrayList<>();
            for (int i = 0; i < numberOfProcessors; i++)
            {
                subHeaps.add(new PriorityQueue<>(heap));
            }
            int i = 0;
            for (T a : x)
            {
                // Add only small numbers to the parallel heaps, big numbers go to the main heap directly
                (a.size() <= maxSize ? subHeaps.get(i++) : heap).add(a);
                i = (i == numberOfProcessors ? 0 : i);
            }
            AtomicInteger index = new AtomicInteger();
            Runnable runnable = () ->
            {
                Queue<T> subHeap = subHeaps.get(index.getAndIncrement());
                long size = 0;
                // Multiply numbers as long as there are at least two and they are small enough
                // Note that with the heap we will start with the smallest numbers and size will grow
                while (subHeap.size() > 1 && size <= maxSize)
                {
                    kernel.run(subHeap);
                    size = subHeap.peek().size();
                }
                synchronized (heap)
                {
                    // Synchronize the adds; nothing must be reading the heap at the same time
                    heap.addAll(subHeap);
                }
            };

            // Run the runnable in multiple threads
            runParallel(runnable, numberOfProcessors - 1);
        }
        else
        {
            // Use the single-thread algorithm
            heap.addAll(Arrays.asList(x));
        }

        // Then just multiply the remaining numbers;
        // they will presumably be so big that the multiplications use the parallel algorithm anyway
        while (heap.size() > 1)
        {
            kernel.run(heap);
        }
    }

    public static <T> T getFuture(Future<T> future)
    {
        try
        {
            return future.get();
        }
        catch (InterruptedException ie)
        {
            throw new ApfloatRuntimeException("Waiting for dispatched task to complete was interrupted", ie);
        }
        catch (ExecutionException ee)
        {
            throw new ApfloatRuntimeException("Task execution failed", ee);
        }
    }

    public static void runParallel(Runnable runnable)
    {
        ApfloatContext ctx = ApfloatContext.getContext();
        int numberOfThreads = ctx.getNumberOfProcessors() - 1;

        runParallel(runnable, numberOfThreads);
    }

    private static void runParallel(Runnable runnable, int numberOfThreads)
    {
        ApfloatContext ctx = ApfloatContext.getContext();
        ExecutorService executorService = ctx.getExecutorService();
        List<Future<?>> futures = new ArrayList<Future<?>>();

        // Dispatch other threads, if any
        for (int i = 0; i < numberOfThreads; i++)
        {
            futures.add(executorService.submit(runnable));
        }

        // Also run the Runnable in the current thread
        runnable.run();

        // Join the other threads, if any
        futures.forEach(ParallelHelper::getFuture);
    }
}
