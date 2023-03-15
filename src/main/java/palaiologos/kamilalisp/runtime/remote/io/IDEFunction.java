package palaiologos.kamilalisp.runtime.remote.io;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.runtime.remote.packet.IDEPacket;
import palaiologos.kamilalisp.runtime.remote.packet.Packet;

import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.Socket;
import java.util.List;

public abstract class IDEFunction extends SimpleIDEFunction {
    public IDEFunction(ObjectInputStream in, ObjectOutputStream out, Socket socket) {
        super(in, out, socket);
    }

    public Atom apply(Environment env, List<Atom> args) {
        Atom result = fapply(env, args);
        try {
            Packet p = (Packet) in.readObject();
            if (p instanceof IDEPacket) {
                if (((IDEPacket) p).kind.equals("ide:err")) {
                    throw new RuntimeException((Throwable) ((IDEPacket) p).data.get(0));
                } else if (((IDEPacket) p).kind.equals("ide:ok")) {
                    return result;
                }
            }
            throw new RuntimeException("Unexpected packet received from IDE: " + p.toString());
        } catch (IOException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    abstract protected Atom fapply(Environment env, List<Atom> args);

    abstract protected String name();
}
