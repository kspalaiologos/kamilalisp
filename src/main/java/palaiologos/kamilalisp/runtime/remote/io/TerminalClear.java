package palaiologos.kamilalisp.runtime.remote.io;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;
import palaiologos.kamilalisp.runtime.remote.IDEPacket;

import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.Socket;
import java.util.List;

public class TerminalClear extends PrimitiveFunction implements Lambda {
    private ObjectInputStream in;
    private ObjectOutputStream out;
    private Socket socket;

    public TerminalClear(ObjectInputStream in, ObjectOutputStream out, Socket socket) {
        this.in = in;
        this.out = out;
        this.socket = socket;
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        try {
            out.writeObject(new IDEPacket("term:clear", List.of()));
            out.flush();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return Atom.NULL;
    }

    @Override
    protected String name() {
        return "term:clear";
    }
}
