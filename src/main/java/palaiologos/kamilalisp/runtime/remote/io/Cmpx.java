package palaiologos.kamilalisp.runtime.remote.io;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.SpecialForm;
import palaiologos.kamilalisp.runtime.remote.StringPacket;

import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.Socket;
import java.util.List;

import static palaiologos.kamilalisp.runtime.meta.Cmpx.doCmpx;

public class Cmpx extends SimpleIDEFunction implements SpecialForm {
    public Cmpx(ObjectInputStream in, ObjectOutputStream out, Socket socket) {
        super(in, out, socket);
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.isEmpty())
            throw new RuntimeException("cmpx requires at least one argument");

        sendPacket(new StringPacket(doCmpx(env, args)));
        return Atom.NULL;
    }

    @Override
    protected String name() {
        return "cmpx";
    }
}
