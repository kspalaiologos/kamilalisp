package palaiologos.kamilalisp.runtime.IO.streams;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.io.OutputStream;
import java.util.List;

public class NullOutputStream extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        return new Atom(new StreamWrapper.OutputStreamUserdata(OutputStream.nullOutputStream()) {
            @Override
            public String toDisplayString() {
                return "io:null-ostream";
            }

            @Override
            public Atom specialField(Object key) {
                throw new RuntimeException("io:null-ostream does not have a special field " + key);
            }
        });
    }

    @Override
    protected String name() {
        return "io:null-ostream";
    }
}
