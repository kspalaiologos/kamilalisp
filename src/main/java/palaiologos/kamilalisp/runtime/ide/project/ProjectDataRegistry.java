package palaiologos.kamilalisp.runtime.ide.project;

import org.apache.commons.compress.compressors.xz.XZCompressorInputStream;
import org.apache.commons.compress.compressors.xz.XZCompressorOutputStream;
import org.tukaani.xz.LZMA2Options;
import palaiologos.kamilalisp.runtime.ide.IDE;

import java.io.*;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Set;
import java.util.concurrent.locks.ReentrantLock;

public class ProjectDataRegistry {
    private final ReentrantLock lock = new ReentrantLock();
    private final IDE parent;
    private String projectNamespace = "";
    private HashMap<String, String> data = new HashMap<>();

    public ProjectDataRegistry(IDE parent) {
        this.parent = parent;
    }

    public void setNamespace(String newName) {
        lock.lock();
        projectNamespace = newName;
        lock.unlock();
    }

    public void setKey(String key, String value) {
        if (!key.startsWith(projectNamespace + ":") && !key.startsWith("public:" + projectNamespace + ":")
                || projectNamespace.isEmpty())
            return;
        lock.lock();
        data.put(key, value);
        lock.unlock();
        if (parent != null) {
            parent.project.projectTreeModel.addElement(key);
            parent.project.projectTree.revalidate();
            parent.project.projectTree.repaint();
            parent.project.unsavedChanges = true;
        }
    }

    public String getKey(String key) {
        lock.lock();
        String d = data.get(key);
        lock.unlock();
        return d;
    }

    public Set<String> keys() {
        lock.lock();
        Set<String> ks = data.keySet();
        lock.unlock();
        return ks;
    }

    public void serialiseTo(OutputStream os) throws IOException {
        lock.lock();
        Iterator<String> it = data.entrySet().stream().map(e -> "(def " + e.getKey() + " " + e.getValue() + "\n)").iterator();
        while (it.hasNext()) {
            os.write(it.next().getBytes());
            os.write('\n');
        }
        lock.unlock();
    }

    public void writeTo(OutputStream os) throws IOException {
        lock.lock();
        os.write("@KLP-BIN".getBytes());
        XZCompressorOutputStream gos = new XZCompressorOutputStream(os, LZMA2Options.PRESET_MAX);
        ObjectOutputStream oos = new ObjectOutputStream(gos);
        oos.writeObject(projectNamespace);
        oos.writeObject(data);
        oos.close();
        lock.unlock();
    }

    public void readFrom(InputStream is) throws IOException, ClassNotFoundException {
        lock.lock();
        byte[] magic = new byte[8];
        is.read(magic);
        if (!new String(magic).equals("@KLP-BIN"))
            throw new IOException("Invalid magic");
        XZCompressorInputStream gis = new XZCompressorInputStream(is);
        ObjectInputStream ois = new ObjectInputStream(gis);
        projectNamespace = (String) ois.readObject();
        data = (HashMap<String, String>) ois.readObject();
        ois.close();
        lock.unlock();
    }

    public void clear() {
        lock.lock();
        data.clear();
        lock.unlock();
        if (parent != null) {
            parent.project.projectTreeModel.clear();
            parent.project.projectTree.revalidate();
            parent.project.projectTree.repaint();
        }
    }
}
