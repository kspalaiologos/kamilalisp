package palaiologos.kamilalisp.runtime.IO.streams;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;
import palaiologos.kamilalisp.runtime.dataformat.BufferAtomList;

import java.io.IOException;
import java.io.InputStream;
import java.math.BigInteger;
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.atomic.AtomicLong;

public class HistogramInputStream extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        StreamWrapper.InputStreamUserdata original = args.get(0).getUserdata(StreamWrapper.InputStreamUserdata.class);
        final AtomicLong[] histogram = new AtomicLong[256];
        for(int i = 0; i < 256; i++)
            histogram[i] = new AtomicLong(0);
        final AtomicLong bytes = new AtomicLong(0);
        InputStream is = new InputStream() {
            @Override
            public int read() throws IOException {
                int c = original.stream.read();
                if(c != -1)
                    histogram[c].getAndAdd(1);
                bytes.getAndAdd(1);
                return c;
            }
        };
        return new Atom(new StreamWrapper.InputStreamUserdata(is) {
            @Override
            public String toDisplayString() {
                return "io:histogram-input-stream#" + original.toDisplayString();
            }

            @Override
            public Atom specialField(Object key) {
                if(!(key instanceof String))
                    throw new RuntimeException("io:histogram-input-stream: special field key must be a string");
                return switch ((String) key) {
                    case "histogram" -> new Atom(Arrays.stream(histogram).map(x -> new Atom(BigInteger.valueOf(x.get()))).toList());
                    case "bytes" -> new Atom(BigInteger.valueOf(bytes.get()));
                    default -> throw new RuntimeException("io:histogram-input-stream: unknown special field: " + key);
                };
            }
        });
    }

    @Override
    protected String name() {
        return "io:histogram-input-stream";
    }
}
