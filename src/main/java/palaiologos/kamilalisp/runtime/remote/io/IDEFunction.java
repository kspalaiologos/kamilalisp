package palaiologos.kamilalisp.runtime.remote.io;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.PrimitiveFunction;
import palaiologos.kamilalisp.runtime.remote.IDEPacket;

import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;
import java.net.Socket;
import java.util.List;

public abstract class IDEFunction extends PrimitiveFunction {
    private ObjectInputStream in;
    public ObjectOutputStream out;
    private Socket socket;

    public IDEFunction(ObjectInputStream in, ObjectOutputStream out, Socket socket) {
        this.in = in;
        this.out = out;
        this.socket = socket;
    }

    void sendPacket(String name, List<Serializable> args) {
        try {
            out.writeObject(new IDEPacket(name, args));
            out.flush();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    void sendPacket(List<Serializable> args) {
        try {
            out.writeObject(new IDEPacket(name(), args));
            out.flush();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    void sendPacket() {
        try {
            out.writeObject(new IDEPacket(name(), List.of()));
            out.flush();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    abstract public Atom apply(Environment env, List<Atom> args);
    abstract protected String name();
}
