package palaiologos.kamilalisp.runtime.IO.streams;

import org.apache.commons.compress.compressors.lz4.BlockLZ4CompressorInputStream;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.List;

public class Lz4InputStream extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        StreamWrapper.InputStreamUserdata owner = args.get(0).getUserdata(StreamWrapper.InputStreamUserdata.class);
        return new Atom(new StreamWrapper.InputStreamUserdata(new BlockLZ4CompressorInputStream(owner.stream)) {
            @Override
            public String toDisplayString() {
                return "io:lz4-input-stream#" + owner.toDisplayString();
            }

            @Override
            public Atom specialField(Object key) {
                throw new RuntimeException("io:lz4-input-stream: unknown special field: " + key);
            }
        });
    }

    @Override
    protected String name() {
        return "io:lz4-input-stream";
    }
}
