package palaiologos.kamilalisp.runtime.net.httpserver;

import io.undertow.server.HttpHandler;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Userdata;

public abstract class UndertowHttpHandlerWrapper implements Userdata {
    public abstract HttpHandler getHandler();

    @Override
    public int hashCode() {
        return getHandler().hashCode();
    }

    @Override
    public Atom field(Object key) {
        throw new IllegalArgumentException("net:http-server:http-handler does not have any fields.");
    }

    @Override
    public String toDisplayString() {
        return "net:http-server:http-handler";
    }

    @Override
    public String typeName() {
        return "net:http-server:http-handler";
    }
}
