package palaiologos.kamilalisp.runtime.IO.streams;

import org.apache.commons.compress.compressors.bzip2.BZip2CompressorInputStream;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.io.IOException;
import java.util.List;

public class Bzip2InputStream extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        StreamWrapper.InputStreamUserdata owner = args.get(0).getUserdata(StreamWrapper.InputStreamUserdata.class);
        try {
            return new Atom(new StreamWrapper.InputStreamUserdata(new BZip2CompressorInputStream(owner.stream)) {
                @Override
                public String toDisplayString() {
                    return "io:bzip2-istream#" + owner.toDisplayString();
                }

                @Override
                public Atom specialField(Object key) {
                    throw new RuntimeException("io:bzip2-istream: unknown special field: " + key);
                }
            });
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected String name() {
        return "io:bzip2-istream";
    }
}
