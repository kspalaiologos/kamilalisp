package palaiologos.kamilalisp.runtime.IO.streams;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import java.util.stream.Collectors;

public class TeeOutputStream extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        List<StreamWrapper.OutputStreamUserdata> streams = args.stream().map(x -> x.getUserdata(StreamWrapper.OutputStreamUserdata.class)).toList();
        OutputStream os = new OutputStream() {
            @Override
            public void write(int c) throws IOException {
                for (StreamWrapper.OutputStreamUserdata s : streams) {
                    s.stream.write(c);
                }
            }
        };
        return new Atom(new StreamWrapper.OutputStreamUserdata(os) {
            @Override
            public String toDisplayString() {
                return "io:tee-ostream#(" + streams.stream().map(StreamWrapper.OutputStreamUserdata::toDisplayString).collect(Collectors.joining(",")) + ")";
            }

            @Override
            public Atom specialField(Object key) {
                throw new RuntimeException("io:tee-ostream does not have a special field " + key);
            }
        });
    }

    @Override
    protected String name() {
        return "io:tee-ostream";
    }
}
