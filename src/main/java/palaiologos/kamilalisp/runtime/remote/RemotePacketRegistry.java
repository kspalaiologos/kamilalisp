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
            "term:clear", "ide:workspace:add", "ide:workspace:has", "ide:workspace:delete",
            "ide:workspace:select", "ide:workspace:swap", "ide:workspace:rename", "ide:workspace:current"
    );

    public static void register(Environment env, ObjectInputStream in, ObjectOutputStream out, Socket socket) {
        env.setPrimitive("term:clear", new Atom(new TerminalClear(in, out, socket)));
        env.setPrimitive("ide:workspace:add", new Atom(new WorkspaceAdd(in, out, socket)));
        env.setPrimitive("ide:workspace:has", new Atom(new WorkspaceHas(in, out, socket)));
        env.setPrimitive("ide:workspace:delete", new Atom(new WorkspaceDelete(in, out, socket)));
        env.setPrimitive("ide:workspace:select", new Atom(new WorkspaceSelect(in, out, socket)));
        env.setPrimitive("ide:workspace:swap", new Atom(new WorkspaceRename(in, out, socket)));
        env.setPrimitive("ide:workspace:rename", new Atom(new WorkspaceRename(in, out, socket)));
        env.setPrimitive("ide:workspace:current", new Atom(new WorkspaceCurrent(in, out, socket)));
        env.set("io:writeln", new Atom(new TerminalWriteLn(in, out, socket)));
        env.set("io:write", new Atom(new TerminalWrite(in, out, socket)));
    }
}
