package palaiologos.kamilalisp.runtime.ide.editor;

import org.apache.commons.compress.compressors.xz.XZCompressorInputStream;
import org.apache.commons.compress.compressors.xz.XZCompressorOutputStream;
import org.tukaani.xz.LZMA2Options;
import org.tukaani.xz.XZOutputStream;

import java.io.*;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.locks.ReentrantLock;
import java.util.stream.Stream;
import java.util.zip.GZIPOutputStream;

public class ProjectDataRegistry {
    private static HashMap<String, String> data = new HashMap<>();
    private static final ReentrantLock lock = new ReentrantLock();

    public static void setKey(String key, String value) {
        lock.lock();
        data.put(key, value);
        lock.unlock();
    }

    public static String getKey(String key) {
        lock.lock();
        String d = data.get(key);
        lock.unlock();
        return d;
    }

    public static Set<String> keys() {
        lock.lock();
        Set<String> ks = data.keySet();
        lock.unlock();
        return ks;
    }

    public static void serialiseTo(OutputStream os) throws IOException {
        lock.lock();
        Iterator<String> it = data.entrySet().stream().map(e -> "(def " + e.getKey() + " " + e.getValue() + ")").iterator();
        while (it.hasNext()) {
            os.write(it.next().getBytes());
            os.write('\n');
        }
        lock.unlock();
    }

    public static void writeTo(OutputStream os) throws IOException {
        lock.lock();
        XZCompressorOutputStream gos = new XZCompressorOutputStream(os, LZMA2Options.PRESET_MAX);
        ObjectOutputStream oos = new ObjectOutputStream(gos);
        oos.writeObject(data);
        oos.close();
        lock.unlock();
    }

    public static void readFrom(InputStream is) throws IOException, ClassNotFoundException {
        lock.lock();
        XZCompressorInputStream gis = new XZCompressorInputStream(is);
        ObjectInputStream ois = new ObjectInputStream(gis);
        data = (HashMap<String, String>) ois.readObject();
        ois.close();
        lock.unlock();
    }
}
