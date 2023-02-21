package palaiologos.kamilalisp.runtime.ide;

import java.util.concurrent.atomic.AtomicLong;

public class NetCounter {
    private static final AtomicLong counterIn = new AtomicLong(0);
    private static final AtomicLong counterOut = new AtomicLong(0);

    public synchronized static void addIn(long n) {
        counterIn.getAndAdd(n);
    }

    public synchronized static void addOut(long n) {
        counterOut.getAndAdd(n);
    }

    public synchronized static long poolIn() {
        return counterIn.getAndSet(0);
    }

    public synchronized static long poolOut() {
        return counterOut.getAndSet(0);
    }
}
