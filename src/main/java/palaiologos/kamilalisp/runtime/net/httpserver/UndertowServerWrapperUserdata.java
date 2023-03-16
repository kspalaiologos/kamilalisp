package palaiologos.kamilalisp.runtime.net.httpserver;

import io.undertow.Undertow;
import palaiologos.kamilalisp.atom.*;

import java.util.List;

public class UndertowServerWrapperUserdata implements Userdata {
    private final Undertow server;

    public UndertowServerWrapperUserdata(Undertow server) {
        this.server = server;
    }

    @Override
    public Atom field(Object key) {
        if(!(key instanceof String keyString)) {
            throw new IllegalArgumentException("key must be a string");
        }
        switch(keyString) {
            case "start":
                return new Atom(new StartServer());
            case "stop":
                return new Atom(new StopServer());
            default:
                throw new IllegalArgumentException("unknown key: " + keyString);
        }
    }

    @Override
    public String toDisplayString() {
        return "net:http-server:server";
    }

    @Override
    public String typeName() {
        return "net:http-server:server";
    }

    @Override
    public int hashCode() {
        return server.hashCode();
    }

    public class StartServer extends PrimitiveFunction implements Lambda {
        @Override
        public Atom apply(Environment env, List<Atom> args) {
            server.start();
            return Atom.NULL;
        }

        @Override
        public String name() {
            return "net:http-server:server.start";
        }
    }

    public class StopServer extends PrimitiveFunction implements Lambda {
        @Override
        public Atom apply(Environment env, List<Atom> args) {
            server.stop();
            return Atom.NULL;
        }

        @Override
        public String name() {
            return "net:http-server:server.stop";
        }
    }
}
