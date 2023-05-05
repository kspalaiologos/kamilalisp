package palaiologos.kamilalisp.runtime.remote.io;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;

import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.Socket;
import java.util.List;

public class WorkspaceDelete extends IDEFunction implements Lambda {
    public WorkspaceDelete(ObjectInputStream in, ObjectOutputStream out, Socket socket) {
        super(in, out, socket);
    }

    @Override
    public Atom fapply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        sendPacket(List.of(args.get(0).getString()));
        return Atom.NULL;
    }

    @Override
    protected String name() {
        return "ide:workspace:delete";
    }
}
