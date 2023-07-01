package palaiologos.kamilalisp.runtime.sh;

import java.io.File;
import java.io.IOException;

public class Wd {
    private static File wd = new File(System.getProperty("user.dir"));

    public static File get() {
        return wd;
    }

    public static File relativeTo(File relativePath) {
        try {
            return new File(wd, relativePath.getPath()).getCanonicalFile();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    public static File relativeTo(String relativePath) {
        return relativeTo(new File(relativePath));
    }

    public static synchronized void set(File wd) {
        Wd.wd = wd;
    }
}
