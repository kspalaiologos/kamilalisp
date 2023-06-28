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
package org.apfloat.spi;

import java.util.concurrent.Future;

/**
 * Thread execution operations.
 *
 * @since 1.9.0
 * @version 1.9.0
 * @author Mikko Tommila
 */

public interface ExecutionStrategy
{
    /**
     * While waiting for a <code>Future</code> to be completed, steal work
     * from any running tasks and run it.<p>
     *
     * While this method may functionally appear to be equivalent to just
     * calling <code>future.get()</code> it should try its best to steal
     * work from any other tasks submitted to the <code>ExecutorService</code>
     * of the current <code>ApfloatContext</code>. It may in fact steal
     * work using multiple threads, if the current <code>ApfloatContext</code>
     * specifies <code>numberOfProcessors</code> to be more than one.<p>
     *
     * The purpose of this method is to allow keeping all threads of the
     * <code>ExecutorService</code> (and CPU cores) maximally busy at all
     * times, while also not running an excessive number of parallel
     * threads (only as many threads as there are CPU cores).
     *
     * @param future The Future to wait for.
     */

    public void wait(Future<?> future);
}
