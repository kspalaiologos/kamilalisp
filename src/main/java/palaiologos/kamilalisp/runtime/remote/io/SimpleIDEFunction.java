package palaiologos.kamilalisp.runtime.remote.io;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.PrimitiveFunction;
import palaiologos.kamilalisp.runtime.remote.IDEPacket;
import palaiologos.kamilalisp.runtime.remote.Packet;

import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;
import java.net.Socket;
import java.util.List;

public abstract class SimpleIDEFunction extends PrimitiveFunction {
    public ObjectInputStream in;
    public ObjectOutputStream out;
    private Socket socket;

    public SimpleIDEFunction(ObjectInputStream in, ObjectOutputStream out, Socket socket) {
        this.in = in;
        this.out = out;
        this.socket = socket;
    }

    void sendPacket(Packet p) {
        try {
            out.writeObject(p);
            out.flush();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
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

    Packet receivePacket() {
        try {
            Packet p = (Packet) in.readObject();
            if(p instanceof IDEPacket) {
                if(((IDEPacket) p).kind.equals("ide:err")) {
                    throw new RuntimeException((Throwable) ((IDEPacket) p).data.get(0));
                } else if(((IDEPacket) p).kind.equals("ide:ok")) {
                    return receivePacket();
                }
            }
            return p;
        } catch (IOException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    abstract public Atom apply(Environment env, List<Atom> args);
    abstract protected String name();
}
