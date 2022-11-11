package palaiologos.kamilalisp.runtime.meta;

import palaiologos.kamilalisp.atom.*;

import java.util.HashMap;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.locks.ReentrantLock;

public class Memo extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() != 1 && args.size() != 2) {
            throw new RuntimeException("memo takes exactly one or two arguments");
        }
        Atom arg = args.get(0);
        if (arg.getType() != Type.CALLABLE) {
            throw new RuntimeException("memo takes a lambda as an argument");
        }
        int max = -1;
        if (args.size() == 2) {
            Atom maxArg = args.get(1);
            if (maxArg.getType() == Type.INTEGER)
                max = maxArg.getInteger().intValueExact();
            else
                throw new RuntimeException("memo takes an integer as a second argument");
        }
        final Lambda mfn = (Lambda) arg.getCallable();
        if (max != -1) {
            int finalMax = max;
            return new Atom(new Lambda() {
                class LRUCache<K, V> {
                    class Node<T, U> {
                        Node<T, U> previous;
                        Node<T, U> next;
                        final T key;
                        final U value;

                        public Node(Node<T, U> previous, Node<T, U> next, T key, U value) {
                            this.previous = previous;
                            this.next = next;
                            this.key = key;
                            this.value = value;
                        }
                    }

                    private final HashMap<K, Node<K, V>> cache;
                    private Node<K, V> leastRecentlyUsed;
                    private Node<K, V> mostRecentlyUsed;
                    private final int maxSize;
                    private int currentSize;

                    public LRUCache(int maxSize) {
                        this.maxSize = maxSize;
                        this.currentSize = 0;
                        leastRecentlyUsed = new Node<K, V>(null, null, null, null);
                        mostRecentlyUsed = leastRecentlyUsed;
                        cache = new HashMap<K, Node<K, V>>();
                    }

                    public V get(K key) {
                        Node<K, V> tempNode = cache.get(key);
                        if (tempNode == null) {
                            return null;
                        }
                        // If MRU leave the list as it is
                        else if (tempNode.key == mostRecentlyUsed.key) {
                            return mostRecentlyUsed.value;
                        }

                        // Get the next and previous nodes
                        Node<K, V> nextNode = tempNode.next;
                        Node<K, V> previousNode = tempNode.previous;

                        // If at the left-most, we update LRU
                        if (tempNode.key == leastRecentlyUsed.key) {
                            nextNode.previous = null;
                            leastRecentlyUsed = nextNode;
                        }

                        // If we are in the middle, we need to update the items before and after our item
                        else if (tempNode.key != mostRecentlyUsed.key) {
                            previousNode.next = nextNode;
                            nextNode.previous = previousNode;
                        }

                        // Finally move our item to the MRU
                        tempNode.previous = mostRecentlyUsed;
                        mostRecentlyUsed.next = tempNode;
                        mostRecentlyUsed = tempNode;
                        mostRecentlyUsed.next = null;

                        return tempNode.value;

                    }

                    public void put(K key, V value) {
                        if (cache.containsKey(key)) {
                            return;
                        }

                        // Put the new node at the right-most end of the linked-list
                        Node<K, V> myNode = new Node<K, V>(mostRecentlyUsed, null, key, value);
                        mostRecentlyUsed.next = myNode;
                        cache.put(key, myNode);
                        mostRecentlyUsed = myNode;

                        // Delete the left-most entry and update the LRU pointer
                        if (currentSize == maxSize) {
                            cache.remove(leastRecentlyUsed.key);
                            leastRecentlyUsed = leastRecentlyUsed.next;
                            leastRecentlyUsed.previous = null;
                        }

                        // Update cache size, for the first added entry update the LRU pointer
                        else if (currentSize < maxSize) {
                            if (currentSize == 0) {
                                leastRecentlyUsed = myNode;
                            }
                            currentSize++;
                        }
                    }
                }

                private final LRUCache<List<Atom>, Atom> cache = new LRUCache<>(finalMax);
                private final ReentrantLock lock = new ReentrantLock();

                @Override
                public Atom apply(Environment env, List<Atom> args) {
                    lock.lock();
                    Atom result = cache.get(args);
                    if (result == null) {
                        result = Evaluation.safeEvaluate(env, mfn, args, msg -> {
                            lock.unlock();
                            throw new RuntimeException(msg);
                        });
                        cache.put(args, result);
                    }
                    lock.unlock();

                    return result;
                }

                @Override
                public String stringify() {
                    return "memo$" + mfn.stringify();
                }

                @Override
                public String frameString() {
                    return "memo$" + mfn.frameString();
                }

                @Override
                public int line() {
                    return mfn.line();
                }

                @Override
                public int column() {
                    return mfn.column();
                }
            });
        } else {
            return new Atom(new Lambda() {
                private final ConcurrentHashMap<List<Atom>, Atom> cache = new ConcurrentHashMap<>();

                @Override
                public Atom apply(Environment env, List<Atom> args) {
                    Atom result = cache.get(args);
                    if (result == null) {
                        result = Evaluation.evaluate(env, mfn, args);
                        cache.put(args, result);
                    }
                    return result;
                }

                @Override
                public String stringify() {
                    return "memo$" + mfn.stringify();
                }

                @Override
                public String frameString() {
                    return "memo$" + mfn.frameString();
                }

                @Override
                public int line() {
                    return mfn.line();
                }

                @Override
                public int column() {
                    return mfn.column();
                }
            });
        }
    }

    @Override
    protected String name() {
        return "memo";
    }
}
