package palaiologos.kamilalisp.runtime.IO.streams;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.io.InputStream;
import java.util.List;

public class NullInputStream extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        return new Atom(new StreamWrapper.InputStreamUserdata(InputStream.nullInputStream()) {
            @Override
            public String toDisplayString() {
                return "io:null-istream";
            }

            @Override
            public Atom specialField(Object key) {
                throw new RuntimeException("io:null-istream does not have a special field " + key);
            }
        });
    }

    @Override
    protected String name() {
        return "io:null-istream";
    }
}
