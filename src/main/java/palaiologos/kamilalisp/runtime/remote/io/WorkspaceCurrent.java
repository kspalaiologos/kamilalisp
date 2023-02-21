package palaiologos.kamilalisp.runtime.remote.io;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.runtime.remote.IDEPacket;

import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.math.BigInteger;
import java.net.Socket;
import java.util.List;

public class WorkspaceCurrent extends IDEFunction implements Lambda {
    public WorkspaceCurrent(ObjectInputStream in, ObjectOutputStream out, Socket socket) {
        super(in, out, socket);
    }

    @Override
    public Atom fapply(Environment env, List<Atom> args) {
        sendPacket();
        IDEPacket p = (IDEPacket) receivePacket();
        int no = (int) p.data.get(0);
        String name = (String) p.data.get(1);
        return new Atom(List.of(new Atom(BigInteger.valueOf(no)), new Atom(name)));
    }

    @Override
    protected String name() {
        return "ide:workspace:current";
    }
}
