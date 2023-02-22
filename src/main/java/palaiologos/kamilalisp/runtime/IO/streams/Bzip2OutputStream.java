package palaiologos.kamilalisp.runtime.IO.streams;

import org.apache.commons.compress.compressors.bzip2.BZip2CompressorOutputStream;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.io.IOException;
import java.util.List;

public class Bzip2OutputStream extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        StreamWrapper.OutputStreamUserdata owner = args.get(0).getUserdata(StreamWrapper.OutputStreamUserdata.class);
        try {
            return new Atom(new StreamWrapper.OutputStreamUserdata(new BZip2CompressorOutputStream(owner.stream)) {
                @Override
                public String toDisplayString() {
                    return "io:bzip2-output-stream#" + owner.toDisplayString();
                }

                @Override
                public Atom specialField(Object key) {
                    throw new RuntimeException("io:bzip2-output-stream: unknown special field: " + key);
                }
            });
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected String name() {
        return "io:bzip2-output-stream";
    }
}
