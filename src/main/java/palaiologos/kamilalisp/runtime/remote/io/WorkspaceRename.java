package palaiologos.kamilalisp.runtime.remote.io;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.Type;

import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.Socket;
import java.util.List;

public class WorkspaceRename extends IDEFunction implements Lambda {
    public WorkspaceRename(ObjectInputStream in, ObjectOutputStream out, Socket socket) {
        super(in, out, socket);
    }

    @Override
    public Atom fapply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        if(args.get(0).getType() == Type.INTEGER) {
            int idx = args.get(0).getInteger().intValueExact();
            String newName = args.get(1).getString();
            sendPacket(List.of(idx, newName));
        } else if(args.get(0).getType() == Type.STRING) {
            String oldName = args.get(0).getString();
            String newName = args.get(1).getString();
            sendPacket(List.of(oldName, newName));
        } else {
            throw new IllegalArgumentException("Invalid argument type");
        }

        return Atom.NULL;
    }

    @Override
    protected String name() {
        return "ide:workspace:rename";
    }
}
