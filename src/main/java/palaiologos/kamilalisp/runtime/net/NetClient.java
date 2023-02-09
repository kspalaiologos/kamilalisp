package palaiologos.kamilalisp.runtime.net;

import org.pcollections.HashTreePMap;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;
import palaiologos.kamilalisp.runtime.hashmap.HashMapUserData;

import java.io.IOException;
import java.net.Socket;
import java.util.List;

public class NetClient extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        String host = args.get(0).getString();
        int port = args.get(1).getInteger().intValueExact();
        try {
            Socket socket = new Socket(host, port);
            return new Atom(new SocketUserData(socket));
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected String name() {
        return "net:client";
    }
}
