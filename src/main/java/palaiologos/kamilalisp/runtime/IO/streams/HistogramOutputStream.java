package palaiologos.kamilalisp.runtime.IO.streams;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.io.IOException;
import java.io.OutputStream;
import java.math.BigInteger;
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.atomic.AtomicLong;

public class HistogramOutputStream extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        StreamWrapper.OutputStreamUserdata original = args.get(0).getUserdata(StreamWrapper.OutputStreamUserdata.class);
        final AtomicLong[] histogram = new AtomicLong[256];
        for (int i = 0; i < 256; i++)
            histogram[i] = new AtomicLong(0);
        final AtomicLong bytes = new AtomicLong(0);
        OutputStream os = new OutputStream() {
            @Override
            public void write(int c) throws IOException {
                if (c != -1)
                    histogram[c].getAndAdd(1);
                bytes.getAndAdd(1);
                original.stream.write(c);
            }
        };
        return new Atom(new StreamWrapper.OutputStreamUserdata(os) {
            @Override
            public String toDisplayString() {
                return "io:histogram-ostream#" + original.toDisplayString();
            }

            @Override
            public Atom specialField(Object key) {
                if (!(key instanceof String))
                    throw new RuntimeException("io:histogram-ostream: special field key must be a string");
                return switch ((String) key) {
                    case "histogram" ->
                            new Atom(Arrays.stream(histogram).map(x -> new Atom(BigInteger.valueOf(x.get()))).toList());
                    case "bytes" -> new Atom(BigInteger.valueOf(bytes.get()));
                    default -> throw new RuntimeException("io:histogram-ostream: unknown special field: " + key);
                };
            }
        });
    }

    @Override
    protected String name() {
        return "io:histogram-ostream";
    }
}
