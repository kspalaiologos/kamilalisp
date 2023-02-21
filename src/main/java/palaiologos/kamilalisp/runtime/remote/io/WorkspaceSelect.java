package palaiologos.kamilalisp.runtime.remote.io;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.Type;

import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.Socket;
import java.util.List;

public class WorkspaceSelect extends IDEFunction implements Lambda {
    public WorkspaceSelect(ObjectInputStream in, ObjectOutputStream out, Socket socket) {
        super(in, out, socket);
    }

    @Override
    public Atom fapply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        if(args.get(0).getType() == Type.INTEGER)
            sendPacket(List.of(args.get(0).getInteger().intValueExact()));
        else if(args.get(0).getType() == Type.STRING)
            sendPacket(List.of(args.get(0).getString()));
        else
            throw new IllegalArgumentException("Expected integer or string");
        return Atom.NULL;
    }

    @Override
    protected String name() {
        return "ide:workspace:select";
    }
}
