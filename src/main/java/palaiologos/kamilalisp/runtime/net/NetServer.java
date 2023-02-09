package palaiologos.kamilalisp.runtime.net;

import palaiologos.kamilalisp.atom.*;

import java.io.IOException;
import java.net.ServerSocket;
import java.util.List;

public class NetServer extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        int port = args.get(0).getInteger().intValueExact();
        Callable callable = args.get(1).getCallable();
        try {
            ServerSocket serverSocket = new ServerSocket(port);
            return new Atom(new ServerSocketUserdata(env, callable, serverSocket));
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected String name() {
        return "net:server";
    }
}
