package palaiologos.kamilalisp.runtime.IO.streams;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.List;

public class FileInputStreamWrapper extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        String name = args.get(0).getString();
        try {
            FileInputStream fis = new FileInputStream(new File(name).getAbsoluteFile());
            return new Atom(new StreamWrapper.InputStreamUserdata(fis) {
                @Override
                public String toDisplayString() {
                    return "io:file-istream {path: " + name + "}";
                }

                @Override
                public Atom specialField(Object key) {
                    throw new RuntimeException("Unrecognised key: " + key);
                }
            });
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected String name() {
        return "io:file-istream";
    }
}
