package palaiologos.kamilalisp.runtime.meta;

import java.util.concurrent.locks.ReentrantLock;

public class ConcurrentLRUCache<K, V> {
    private final LRUCache<K, V> cache;
    private final ReentrantLock lock = new ReentrantLock();

    public ConcurrentLRUCache(int maxSize) {
        cache = new LRUCache<>(maxSize);
    }

    public V get(K key) {
        lock.lock();
        V x = null;
        try {
            x = cache.get(key);
        } catch (Throwable t) {
            lock.unlock();
            throw t;
        }
        lock.unlock();
        return x;
    }

    public void put(K key, V value) {
        lock.lock();
        try {
            cache.put(key, value);
        } catch (Throwable t) {
            lock.unlock();
            throw t;
        }
        lock.unlock();
    }
}
