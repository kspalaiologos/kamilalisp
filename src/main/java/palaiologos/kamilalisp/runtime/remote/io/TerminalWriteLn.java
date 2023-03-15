package palaiologos.kamilalisp.runtime.remote.io;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.runtime.remote.packet.StringPacket;

import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.Socket;
import java.util.List;

public class TerminalWriteLn extends SimpleIDEFunction implements Lambda {
    public TerminalWriteLn(ObjectInputStream in, ObjectOutputStream out, Socket socket) {
        super(in, out, socket);
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        for (Atom arg : args) {
            sendPacket(new StringPacket(arg.toDisplayString() + "\n"));
        }

        if (args.size() == 1)
            return args.get(0);
        else
            return new Atom(args);
    }

    @Override
    protected String name() {
        return "io:writeln";
    }
}
