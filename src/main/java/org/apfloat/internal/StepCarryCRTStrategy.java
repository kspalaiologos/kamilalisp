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
import org.apfloat.spi.BuilderFactory;
import org.apfloat.spi.CarryCRTStrategy;
import org.apfloat.spi.CarryCRTStepStrategy;
import org.apfloat.spi.DataStorageBuilder;
import org.apfloat.spi.DataStorage;

/**
 * Class for performing the final step of a three-modulus
 * Number Theoretic Transform based convolution. Works with blocks of data.<p>
 *
 * The algorithm is parallelized for multiprocessor computers,
 * if the data fits in memory.<p>
 *
 * The parallelization works so that the carry-CRT is done in
 * blocks in parallel. As a final step, a second pass is done
 * through the data set to propagate the carries from one block
 * to the next.<p>
 *
 * All access to this class must be externally synchronized.
 *
 * @see CarryCRTStepStrategy
 *
 * @since 1.7.0
 * @version 1.9.0
 * @author Mikko Tommila
 */

public class StepCarryCRTStrategy
    implements CarryCRTStrategy, Parallelizable
{
    // Runnable for calculating the carry-CRT in blocks, then get the carry of the previous block, add it, and provide carry to the next block
    private class CarryCRTRunnable<T>
        implements Runnable
    {
        public CarryCRTRunnable(DataStorage resultMod0, DataStorage resultMod1, DataStorage resultMod2, DataStorage dataStorage, long size, long resultSize, long offset, long length, MessagePasser<Long, T> messagePasser, CarryCRTStepStrategy<T> stepStrategy)
        {
            this.resultMod0 = resultMod0;
            this.resultMod1 = resultMod1;
            this.resultMod2 = resultMod2;
            this.dataStorage = dataStorage;
            this.size = size;
            this.resultSize = resultSize;
            this.offset = offset;
            this.length = length;
            this.messagePasser = messagePasser;
            this.stepStrategy = stepStrategy;
        }

        @Override
        public void run()
        {
            T results = this.stepStrategy.crt(this.resultMod0, this.resultMod1, this.resultMod2, this.dataStorage, this.size, this.resultSize, this.offset, this.length);

            // Finishing step - get the carry from the previous block and propagate it through the data
            if (this.offset > 0)
            {
                T previousResults = this.messagePasser.receiveMessage(this.offset);

                results = this.stepStrategy.carry(this.dataStorage, this.size, this.resultSize, this.offset, this.length, results, previousResults);
            }

            // Finally, send the carry to the next block
            this.messagePasser.sendMessage(this.offset + this.length, results);

            // Last block sanity check
            if (this.offset + this.length == this.size)
            {
                assert (results != null);
                assert (java.lang.reflect.Array.getLength(results) == 2);
                assert (((Number) java.lang.reflect.Array.get(results, 0)).longValue() == 0);
                assert (((Number) java.lang.reflect.Array.get(results, 1)).longValue() == 0);
            }
        }

        private DataStorage resultMod0,
                            resultMod1,
                            resultMod2,
                            dataStorage;
        private long size,
                     resultSize,
                     offset,
                     length;
        private MessagePasser<Long, T> messagePasser;
        private CarryCRTStepStrategy<T> stepStrategy;
    }

    /**
     * Creates a carry-CRT object using the specified radix.
     *
     * @param radix The radix that will be used.
     */

    public StepCarryCRTStrategy(int radix)
    {
        this.radix = radix;
    }

    /**
     * Calculate the final result of a three-NTT convolution.<p>
     *
     * Performs a Chinese Remainder Theorem (CRT) on each element
     * of the three result data sets to get the result of each element
     * modulo the product of the three moduli. Then it calculates the carries
     * to get the final result.<p>
     *
     * Note that the return value's initial word may be zero or non-zero,
     * depending on how large the result is.<p>
     *
     * Assumes that <code>MODULUS[0] &gt; MODULUS[1] &gt; MODULUS[2]</code>.
     *
     * @param resultMod0 The result modulo <code>MODULUS[0]</code>.
     * @param resultMod1 The result modulo <code>MODULUS[1]</code>.
     * @param resultMod2 The result modulo <code>MODULUS[2]</code>.
     * @param resultSize The number of elements needed in the final result.
     *
     * @return The final result with the CRT performed and the carries calculated.
     */

    @Override
    public DataStorage carryCRT(DataStorage resultMod0, DataStorage resultMod1, DataStorage resultMod2, long resultSize)
        throws ApfloatRuntimeException
    {
        ApfloatContext ctx = ApfloatContext.getContext();
        BuilderFactory builderFactory = ctx.getBuilderFactory();
        Class<?> elementArrayType = builderFactory.getElementArrayType();

        return doCarryCRT(elementArrayType, resultMod0, resultMod1, resultMod2, resultSize);
    }

    private <T> DataStorage doCarryCRT(Class<T> elementArrayType, DataStorage resultMod0, DataStorage resultMod1, DataStorage resultMod2, long resultSize)
        throws ApfloatRuntimeException
    {
        long size = Math.min(resultSize + 2, resultMod0.getSize());         // Some extra precision if not full result is required

        ApfloatContext ctx = ApfloatContext.getContext();
        BuilderFactory builderFactory = ctx.getBuilderFactory();
        DataStorageBuilder dataStorageBuilder = builderFactory.getDataStorageBuilder();
        DataStorage dataStorage = dataStorageBuilder.createDataStorage(resultSize * builderFactory.getElementSize());
        dataStorage.setSize(resultSize);

        ParallelRunnable parallelRunnable = createCarryCRTParallelRunnable(elementArrayType, resultMod0, resultMod1, resultMod2, dataStorage, size, resultSize);

        if (size <= Integer.MAX_VALUE &&                                    // Only if the size fits in an integer, but with memory arrays it should
            resultMod0.isCached() &&                                        // Only if the data storage supports efficient parallel random access
            resultMod1.isCached() &&
            resultMod2.isCached() &&
            dataStorage.isCached())
        {
            ParallelRunner.runParallel(parallelRunnable);
        }
        else
        {
            parallelRunnable.getRunnable(0, size).run();                    // Just run in current thread without parallelization
        }

        return dataStorage;
    }

    /**
     * Create a ParallelRunnable object for doing the carry-CRT in parallel.
     *
     * @param <T> The element array type used.
     * @param elementArrayType The element array type used.
     * @param resultMod0 The result modulo <code>MODULUS[0]</code>.
     * @param resultMod1 The result modulo <code>MODULUS[1]</code>.
     * @param resultMod2 The result modulo <code>MODULUS[2]</code>.
     * @param dataStorage The destination data storage of the computation.
     * @param size The number of elements in the whole data set.
     * @param resultSize The number of elements needed in the final result.
     *
     * @return An suitable object for performing the carry-CRT in parallel.
     */

    protected <T> ParallelRunnable createCarryCRTParallelRunnable(Class<T> elementArrayType, DataStorage resultMod0, DataStorage resultMod1, DataStorage resultMod2, DataStorage dataStorage, long size, long resultSize)
    {
        ApfloatContext ctx = ApfloatContext.getContext();
        BuilderFactory builderFactory = ctx.getBuilderFactory();

        MessagePasser<Long, T> messagePasser = new MessagePasser<>();
        CarryCRTStepStrategy<T> stepStrategy = builderFactory.getCarryCRTBuilder(elementArrayType).createCarryCRTSteps(this.radix);

        ParallelRunnable parallelRunnable = new ParallelRunnable(size)
        {
            @Override
            public Runnable getRunnable(long offset, long length)
            {
                return new CarryCRTRunnable<>(resultMod0, resultMod1, resultMod2, dataStorage, size, resultSize, offset, length, messagePasser, stepStrategy);
            }
        };
        return parallelRunnable;
    }

    private int radix;
}
