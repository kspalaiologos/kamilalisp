package palaiologos.kamilalisp.runtime.IO.streams;

import org.apache.commons.compress.compressors.bzip2.BZip2CompressorInputStream;
import org.apache.commons.compress.compressors.xz.XZCompressorInputStream;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.io.IOException;
import java.util.List;

public class XzInputStream extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        StreamWrapper.InputStreamUserdata owner = args.get(0).getUserdata(StreamWrapper.InputStreamUserdata.class);
        try {
            return new Atom(new StreamWrapper.InputStreamUserdata(new XZCompressorInputStream(owner.stream)) {
                @Override
                public String toDisplayString() {
                    return "io:xz-input-stream#" + owner.toDisplayString();
                }

                @Override
                public Atom specialField(Object key) {
                    throw new RuntimeException("io:xz-input-stream: unknown special field: " + key);
                }
            });
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected String name() {
        return "io:xz-input-stream";
    }
}
