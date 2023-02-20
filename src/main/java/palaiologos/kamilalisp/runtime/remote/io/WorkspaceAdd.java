package palaiologos.kamilalisp.runtime.remote.io;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;

import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.Socket;
import java.util.List;

public class WorkspaceAdd extends IDEFunction implements Lambda {
    public WorkspaceAdd(ObjectInputStream in, ObjectOutputStream out, Socket socket) {
        super(in, out, socket);
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.size() == 0)
            sendPacket();
        else if(args.size() == 1)
            sendPacket(List.of(args.get(0).toString()));
        return Atom.NULL;
    }

    @Override
    protected String name() {
        return "ide:workspace:add";
    }
}
