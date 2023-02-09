package palaiologos.kamilalisp.runtime.dataformat.archive;

import palaiologos.kamilalisp.atom.Atom;

import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.channels.ClosedChannelException;
import java.nio.channels.SeekableByteChannel;
import java.util.List;
import java.util.concurrent.atomic.AtomicBoolean;

public class SeekableKamilaLispByteChannel implements SeekableByteChannel {
    private static final int NAIVE_RESIZE_LIMIT = 1073741823;
    private final AtomicBoolean closed;
    private List<Atom> data;
    private int position;
    private int size;

    public SeekableKamilaLispByteChannel(List<Atom> data) {
        this.closed = new AtomicBoolean();
        this.data = data;
        this.size = data.size();
    }

    public long position() {
        return (long) this.position;
    }

    public SeekableByteChannel position(long newPosition) throws IOException {
        this.ensureOpen();
        if (newPosition >= 0L && newPosition <= 2147483647L) {
            this.position = (int) newPosition;
            return this;
        } else {
            throw new IOException("Position has to be in range 0.. 2147483647");
        }
    }

    public long size() {
        return (long) this.size;
    }

    public SeekableByteChannel truncate(long newSize) {
        if (newSize >= 0L && newSize <= 2147483647L) {
            if ((long) this.size > newSize) {
                this.size = (int) newSize;
            }

            if ((long) this.position > newSize) {
                this.position = (int) newSize;
            }

            return this;
        } else {
            throw new IllegalArgumentException("Size has to be in range 0.. 2147483647");
        }
    }

    public int read(ByteBuffer buf) throws IOException {
        this.ensureOpen();
        int wanted = buf.remaining();
        int possible = this.size - this.position;
        if (possible <= 0) {
            return -1;
        } else {
            if (wanted > possible) {
                wanted = possible;
            }

            for (int i = 0; i < wanted; ++i) {
                buf.put(this.data.get(this.position + i).getInteger().byteValueExact());
            }
            this.position += wanted;
            return wanted;
        }
    }

    public void close() {
        this.closed.set(true);
    }

    public boolean isOpen() {
        return !this.closed.get();
    }

    public int write(ByteBuffer b) throws IOException {
        throw new UnsupportedOperationException();
    }

    private void ensureOpen() throws ClosedChannelException {
        if (!this.isOpen()) {
            throw new ClosedChannelException();
        }
    }
}
