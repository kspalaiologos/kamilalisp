package palaiologos.kamilalisp.runtime.net.httpserver;

import io.undertow.server.HttpHandler;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Userdata;

public class UndertowHttpHandlerWrapper implements Userdata {
    private final HttpHandler handler;

    public UndertowHttpHandlerWrapper(HttpHandler handler) {
        this.handler = handler;
    }

    public HttpHandler getHandler() {
        return handler;
    }

    @Override
    public int hashCode() {
        return handler.hashCode();
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
