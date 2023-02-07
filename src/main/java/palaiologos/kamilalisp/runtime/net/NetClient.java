package palaiologos.kamilalisp.runtime.net;

import org.pcollections.HashTreePMap;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;
import palaiologos.kamilalisp.runtime.hashmap.HashMapUserData;

import java.io.IOException;
import java.math.BigInteger;
import java.net.Socket;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class NetClient extends PrimitiveFunction implements Lambda {
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
            return "net:client:close";
        }
    }

    private static class SocketReadBytes extends PrimitiveFunction implements Lambda {
        private final Socket socket;

        public SocketReadBytes(Socket socket) {
            this.socket = socket;
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            try {
                int noBytes = args.get(0).getInteger().intValueExact();
                byte[] bytes = new byte[noBytes];
                int read = socket.getInputStream().read(bytes);
                if (read == -1) {
                    return Atom.NULL;
                }
                List<Atom> atoms = new ArrayList<>(read);
                for (int i = 0; i < read; i++) {
                    atoms.add(new Atom(BigInteger.valueOf(bytes[i])));
                }
                return new Atom(atoms);
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }

        @Override
        protected String name() {
            return "net:client:read-bytes";
        }
    }

    private static class SocketWriteBytes extends PrimitiveFunction implements Lambda {
        private final Socket socket;

        public SocketWriteBytes(Socket socket) {
            this.socket = socket;
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            try {
                List<Atom> bytes = args.get(0).getList();
                byte[] bytesArray = new byte[bytes.size()];
                for (int i = 0; i < bytes.size(); i++) {
                    bytesArray[i] = bytes.get(i).getInteger().byteValueExact();
                }
                socket.getOutputStream().write(bytesArray);
                return Atom.NULL;
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }

        @Override
        protected String name() {
            return "net:client:write-bytes";
        }
    }

    private static class SocketReadLine extends PrimitiveFunction implements Lambda {
        private final Socket socket;

        public SocketReadLine(Socket socket) {
            this.socket = socket;
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            try {
                StringBuilder sb = new StringBuilder();
                while (true) {
                    int read = socket.getInputStream().read();
                    if (read == -1) {
                        return new Atom(sb.toString());
                    }
                    char c = (char) read;
                    if (c == '\n') {
                        break;
                    }
                    sb.append(c);
                }
                return new Atom(sb.toString());
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }

        @Override
        protected String name() {
            return "net:client:read-line";
        }
    }

    private static class SocketWriteLine extends PrimitiveFunction implements Lambda {
        private final Socket socket;

        public SocketWriteLine(Socket socket) {
            this.socket = socket;
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            try {
                String line = args.get(0).getString();
                socket.getOutputStream().write(line.getBytes());
                socket.getOutputStream().write('\n');
                return Atom.NULL;
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }

        @Override
        protected String name() {
            return "net:client:write-line";
        }
    }

    private static class SocketFlush extends PrimitiveFunction implements Lambda {
        private final Socket socket;

        public SocketFlush(Socket socket) {
            this.socket = socket;
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            try {
                socket.getOutputStream().flush();
                return Atom.NULL;
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }

        @Override
        protected String name() {
            return "net:client:flush";
        }
    }

private static class SocketSkip extends PrimitiveFunction implements Lambda {
        private final Socket socket;

        public SocketSkip(Socket socket) {
            this.socket = socket;
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            try {
                long noBytes = args.get(0).getInteger().longValueExact();
                long skipped = socket.getInputStream().skip(noBytes);
                return new Atom(BigInteger.valueOf(skipped));
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }

        @Override
        protected String name() {
            return "net:client:skip";
        }
    }

private static class SocketAvailable extends PrimitiveFunction implements Lambda {
        private final Socket socket;

        public SocketAvailable(Socket socket) {
            this.socket = socket;
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            try {
                int available = socket.getInputStream().available();
                return new Atom(BigInteger.valueOf(available));
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }

        @Override
        protected String name() {
            return "net:client:available";
        }
    }

    private Map<Atom, Atom> object(Socket s) {
        return Map.of(
                new Atom("close"), new Atom(new SocketClose(s)),
                new Atom("read-bytes"), new Atom(new SocketReadBytes(s)),
                new Atom("write-bytes"), new Atom(new SocketWriteBytes(s)),
                new Atom("read-line"), new Atom(new SocketReadLine(s)),
                new Atom("write-line"), new Atom(new SocketWriteLine(s)),
                new Atom("flush"), new Atom(new SocketFlush(s)),
                new Atom("skip"), new Atom(new SocketSkip(s)),
                new Atom("available"), new Atom(new SocketAvailable(s))
        );
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        String host = args.get(0).getString();
        int port = args.get(1).getInteger().intValueExact();
        try {
            Socket socket = new Socket(host, port);
            return new Atom(new HashMapUserData(HashTreePMap.from(object(socket))));
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected String name() {
        return "net:client";
    }
}
