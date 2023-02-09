package palaiologos.kamilalisp.runtime.net;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.runtime.dataformat.BufferAtomList;

import java.io.IOException;
import java.math.BigInteger;
import java.net.Socket;
import java.util.List;

public class SocketUserData implements Userdata {
    private final Socket socket;

    public SocketUserData(Socket socket) {
        this.socket = socket;
    }

    @Override
    public Atom field(Object key) {
        if (!(key instanceof String)) {
            throw new RuntimeException("net:client-socket field name must be a string");
        }

        return switch ((String) key) {
            case "close" -> new Atom(new SocketClose(socket));
            case "read-bytes" -> new Atom(new SocketReadBytes(socket));
            case "write-bytes" -> new Atom(new SocketWriteBytes(socket));
            case "read-line" -> new Atom(new SocketReadLine(socket));
            case "write-line" -> new Atom(new SocketWriteLine(socket));
            case "flush" -> new Atom(new SocketFlush(socket));
            case "skip" -> new Atom(new SocketSkip(socket));
            case "available" -> new Atom(new SocketAvailable(socket));
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
                return new Atom(BufferAtomList.from(bytes, read));
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
}
