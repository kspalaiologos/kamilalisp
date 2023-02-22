package palaiologos.kamilalisp.runtime.net;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.runtime.IO.streams.StreamWrapper;
import palaiologos.kamilalisp.runtime.dataformat.BufferAtomList;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.math.BigInteger;
import java.net.Socket;
import java.util.List;

public class SocketUserData implements Userdata {
    private final Socket socket;
    private final InputStream is;
    private final OutputStream os;
    private final Atom aIs;
    private final Atom aOs;

    public SocketUserData(Socket socket) {
        this.socket = socket;
        try {
            this.is = socket.getInputStream();
            this.os = socket.getOutputStream();

            this.aIs = new Atom(new StreamWrapper.InputStreamUserdata(is) {
                @Override
                public String toDisplayString() {
                    return "net:client-socket:input-stream " + socket.getInetAddress();
                }

                @Override
                public Atom specialField(Object key) {
                    throw new RuntimeException("net:client-socket:input-stream has no special field " + key);
                }
            });

            this.aOs = new Atom(new StreamWrapper.OutputStreamUserdata(os) {
                @Override
                public String toDisplayString() {
                    return "net:client-socket:output-stream " + socket.getInetAddress();
                }

                @Override
                public Atom specialField(Object key) {
                    throw new RuntimeException("net:client-socket:output-stream has no special field " + key);
                }
            });
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public Atom field(Object key) {
        if (!(key instanceof String)) {
            throw new RuntimeException("net:client-socket field name must be a string");
        }

        return switch ((String) key) {
            case "close" -> new Atom(new SocketClose(socket));
            case "out" -> aOs;
            case "in" -> aIs;
            default -> throw new RuntimeException("net:client-socket has no field " + key);
        };
    }

    @Override
    public int compareTo(Userdata other) {
        return socket.hashCode() - other.hashCode();
    }

    @Override
    public int hashCode() {
        return socket.hashCode();
    }

    @Override
    public boolean equals(Userdata other) {
        if (other instanceof SocketUserData) {
            return socket.equals(((SocketUserData) other).socket);
        } else {
            return false;
        }
    }

    @Override
    public String toDisplayString() {
        return "net:client-socket";
    }

    @Override
    public String typeName() {
        return "net:client-socket";
    }

    @Override
    public boolean coerceBoolean() {
        return true;
    }

    private static class SocketClose extends PrimitiveFunction implements Lambda {
        private final Socket socket;

        public SocketClose(Socket socket) {
            this.socket = socket;
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            try {
                socket.close();
                return Atom.NULL;
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }

        @Override
        protected String name() {
            return "net:client-socket.close";
        }
    }
}
