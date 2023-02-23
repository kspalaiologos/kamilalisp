package palaiologos.kamilalisp.runtime.remote.io;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;

import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.Socket;
import java.util.List;

public class IDESplitH extends IDEFunction implements Lambda {
    public IDESplitH(ObjectInputStream in, ObjectOutputStream out, Socket socket) {
        super(in, out, socket);
    }

    @Override
    public Atom fapply(Environment env, List<Atom> args) {
        if (args.isEmpty())
            sendPacket();
        else if(args.size() == 1)
            sendPacket(List.of(args.get(0).getIdentifier()));
        else if(args.size() == 3)
            sendPacket(List.of(args.get(0).getIdentifier(), args.get(1).getString(), args.get(2).getInteger().intValueExact()));
        else
            throw new RuntimeException("ide:split-h: expected zero, one or three arguments");
        return Atom.NULL;
    }

    @Override
    protected String name() {
        return "ide:split-h";
    }
}
