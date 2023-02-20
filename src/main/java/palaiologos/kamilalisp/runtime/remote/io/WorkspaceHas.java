package palaiologos.kamilalisp.runtime.remote.io;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.runtime.remote.IDEPacket;

import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.Socket;
import java.util.List;

public class WorkspaceHas extends IDEFunction implements Lambda {
    public WorkspaceHas(ObjectInputStream in, ObjectOutputStream out, Socket socket) {
        super(in, out, socket);
    }

    @Override
    public Atom fapply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        sendPacket(List.of(args.get(0).getString()));
        IDEPacket packet = (IDEPacket) receivePacket();
        boolean b = (boolean) packet.data.get(0);
        return b ? Atom.TRUE : Atom.FALSE;
    }

    @Override
    protected String name() {
        return "ide:workspace:has";
    }
}
