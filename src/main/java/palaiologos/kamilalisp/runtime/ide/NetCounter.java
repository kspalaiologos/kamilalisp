package palaiologos.kamilalisp.runtime.ide;

import java.util.concurrent.atomic.AtomicLong;

public class NetCounter {
    private static final AtomicLong counterIn = new AtomicLong(0);
    private static final AtomicLong counterOut = new AtomicLong(0);
    private static final AtomicLong inTotal = new AtomicLong(0);
    private static final AtomicLong outTotal = new AtomicLong(0);

    public synchronized static void addIn(long n) {
        counterIn.getAndAdd(n);
    }

    public synchronized static void addOut(long n) {
        counterOut.getAndAdd(n);
    }

    public synchronized static long poolIn() {
        inTotal.getAndAdd(counterIn.get());
        return counterIn.getAndSet(0);
    }

    public synchronized static long poolOut() {
        outTotal.getAndAdd(counterOut.get());
        return counterOut.getAndSet(0);
    }

    public synchronized static long getInTotal() {
        return inTotal.get();
    }

    public synchronized static long getOutTotal() {
        return outTotal.get();
    }
}
