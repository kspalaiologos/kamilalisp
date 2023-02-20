package palaiologos.kamilalisp.runtime.remote;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.runtime.remote.io.*;

import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.Socket;
import java.util.Set;

public class RemotePacketRegistry {
    public static final Set<String> terminalKeys = Set.of(
            "term:clear", "ide:workspace:add", "ide:workspace:has", "ide:workspace:delete"
    );

    public static void register(Environment env, ObjectInputStream in, ObjectOutputStream out, Socket socket) {
        env.setPrimitive("term:clear", new Atom(new TerminalClear(in, out, socket)));
        env.setPrimitive("ide:workspace:add", new Atom(new WorkspaceAdd(in, out, socket)));
        env.setPrimitive("ide:workspace:has", new Atom(new WorkspaceHas(in, out, socket)));
        env.setPrimitive("ide:workspace:delete", new Atom(new WorkspaceDelete(in, out, socket)));
    }
}
