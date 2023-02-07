package palaiologos.kamilalisp.runtime.regex;

import palaiologos.kamilalisp.runtime.meta.ConcurrentLRUCache;

import java.util.regex.Pattern;

class PatternCache {
    private static final int CACHE_SIZE = 1000;
    private static final ConcurrentLRUCache<String, Pattern> cache = new ConcurrentLRUCache<>(CACHE_SIZE);

    public static Pattern get(String regex) {
        Pattern pattern = cache.get(regex);
        if (pattern == null) {
            pattern = Pattern.compile(regex);
            cache.put(regex, pattern);
        }
        return pattern;
    }
}
