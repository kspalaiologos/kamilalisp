package palaiologos.kamilalisp.runtime.remote.io;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.runtime.remote.packet.IDEPacket;

import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.Socket;
import java.util.List;

public class TerminalReadLn extends IDEFunction implements Lambda {
    public TerminalReadLn(ObjectInputStream in, ObjectOutputStream out, Socket socket) {
        super(in, out, socket);
    }

    @Override
    protected Atom fapply(Environment env, List<Atom> args) {
        sendPacket();
        IDEPacket packet = (IDEPacket) receivePacket();
        return new Atom((String) packet.data.get(0));
    }

    @Override
    protected String name() {
        return "io:readln";
    }
}
