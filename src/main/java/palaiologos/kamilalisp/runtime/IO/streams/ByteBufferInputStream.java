package palaiologos.kamilalisp.runtime.IO.streams;

import palaiologos.kamilalisp.atom.*;

import java.io.InputStream;
import java.util.List;

public class ByteBufferInputStream extends PrimitiveFunction implements Lambda {

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        List<Atom> data = args.get(0).getList();
        for (Atom a : data)
            if (a.getType() != Type.INTEGER)
                throw new RuntimeException("io:byte-buffer-input-stream: data must be a list of bytes");
        return new Atom(new StreamWrapper.InputStreamUserdata(new InputStream() {
            private int pos = 0;

            @Override
            public int read() {
                return data.get(pos++).getInteger().intValue();
            }

            @Override
            public int available() {
                return data.size() - pos;
            }
        }) {
            @Override
            public String toDisplayString() {
                return "io:byte-buffer-input-stream (" + data.size() + "bytes)";
            }

            @Override
            public Atom specialField(Object key) {
                throw new RuntimeException("io:byte-buffer-input-stream: unknown special field: " + key);
            }
        });
    }

    @Override
    protected String name() {
        return "io:byte-buffer-input-stream";
    }
}
