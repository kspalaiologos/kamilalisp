package palaiologos.kamilalisp.runtime.IO.streams;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.io.OutputStream;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

public class ByteBufferOutputStream extends PrimitiveFunction implements Lambda {

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 0);
        List<Atom> data = new ArrayList<>();

        return new Atom(new StreamWrapper.OutputStreamUserdata(new OutputStream() {
            @Override
            public void write(int b) {
                data.add(new Atom(BigInteger.valueOf(b)));
            }
        }) {
            @Override
            public String toDisplayString() {
                return "io:byte-buffer-output-stream (" + data.size() + "bytes)";
            }

            @Override
            public Atom specialField(Object key) {
                if (!(key instanceof String))
                    throw new RuntimeException("io:byte-buffer-output-stream: special field key must be a string");
                if (key.equals("data")) {
                    return new Atom(data);
                }
                throw new RuntimeException("io:byte-buffer-output-stream: unknown special field: " + key);
            }
        });
    }

    @Override
    protected String name() {
        return "io:byte-buffer-output-stream";
    }
}
