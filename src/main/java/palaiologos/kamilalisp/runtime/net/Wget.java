package palaiologos.kamilalisp.runtime.net;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;
import palaiologos.kamilalisp.runtime.dataformat.BufferAtomList;

import java.io.InputStream;
import java.math.BigInteger;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

public class Wget extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        try {
            URL url = new URL(args.get(0).getString());
            InputStream data = url.openStream();
            byte[] bytes = data.readAllBytes();
            data.close();
            return new Atom(BufferAtomList.from(bytes));
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected String name() {
        return "net:wget";
    }
}
