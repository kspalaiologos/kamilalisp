package palaiologos.kamilalisp.runtime.remote;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.runtime.remote.io.TerminalClear;
import palaiologos.kamilalisp.runtime.remote.io.WorkspaceAdd;

import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.Socket;

public class RemotePacketRegistry {
    public static void register(Environment env, ObjectInputStream in, ObjectOutputStream out, Socket socket) {
        env.setPrimitive("term:clear", new Atom(new TerminalClear(in, out, socket)));
        env.setPrimitive("ide:workspace:add", new Atom(new WorkspaceAdd(in, out, socket)));
    }
}
