package palaiologos.kamilalisp.runtime.net;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.InterruptionError;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.List;

public class ServerSocketUserdata implements Userdata {
    private final ServerSocket serverSocket;
    private final Thread server;

    public ServerSocketUserdata(Environment env, Callable handler, ServerSocket serverSocket) {
        this.serverSocket = serverSocket;

        this.server = new Thread(() -> {
            do {
                try {
                    Socket client = serverSocket.accept();
                    Atom data = new Atom(new SocketUserData(client));
                    Evaluation.safeEvaluate(env, handler, List.of(data), err -> {
                        System.err.println(err);
                        throw new InterruptionError();
                    });
                } catch (IOException e) {
                    throw new RuntimeException(e);
                }
            } while (!Thread.interrupted());
        });

        server.start();
    }

    @Override
    public Atom field(Object key) {
        if (!(key instanceof String)) {
            throw new IllegalArgumentException("net:server-socket: field name must be a string");
        }

        return switch ((String) key) {
            case "close" -> new Atom(new ServerSocketClose(serverSocket, server));
            default -> throw new IllegalArgumentException("net:server-socket: unknown field " + key);
        };
    }

    @Override
    public int hashCode() {
        return serverSocket.hashCode();
    }

    @Override
    public int compareTo(Userdata other) {
        return hashCode() - other.hashCode();
    }

    @Override
    public boolean equals(Userdata other) {
        if (other instanceof ServerSocketUserdata) {
            return serverSocket.equals(((ServerSocketUserdata) other).serverSocket);
        } else {
            return false;
        }
    }

    @Override
    public String toDisplayString() {
        return "net:server-socket";
    }

    @Override
    public String typeName() {
        return "net:server-socket";
    }

    @Override
    public boolean coerceBoolean() {
        return true;
    }

    private static class ServerSocketClose extends PrimitiveFunction implements Lambda {
        private final ServerSocket socket;
        private final Thread server;

        public ServerSocketClose(ServerSocket socket, Thread server) {
            this.socket = socket;
            this.server = server;
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            try {
                server.interrupt();
                socket.close();
                return Atom.NULL;
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }

        @Override
        protected String name() {
            return "net:server:close";
        }
    }
}
