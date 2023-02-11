package palaiologos.kamilalisp.runtime.cas;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

public class StreamWrap extends InputStream {
    private final InputStream IN = System.in;

    public static InputStream nullInputStream() {
        return InputStream.nullInputStream();
    }

    @Override
    public int read() throws IOException {
        throw new IOException("Not implemented");
    }

    @Override
    public int read(byte[] b, int off, int len) throws IOException {
        System.out.println("read(byte[], int, int) = " + off + ", " + len);
        return IN.read(b, off, len);
    }
}
