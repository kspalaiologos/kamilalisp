package palaiologos.kamilalisp.runtime.net.httpserver;

import io.undertow.Handlers;
import io.undertow.server.HttpHandler;
import palaiologos.kamilalisp.atom.*;

import java.util.List;

public class RedirectHandler extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        String location = args.get(0).getString();
        return new Atom(new RedirectionHandlerUserdata(location));
    }

    @Override
    protected String name() {
        return "net:http-redirect-handler";
    }

    public static class RedirectionHandlerUserdata extends UndertowHttpHandlerWrapper {
        private final io.undertow.server.handlers.RedirectHandler handler;

        public RedirectionHandlerUserdata(String location) {
            this.handler = Handlers.redirect(location);
        }

        @Override
        public HttpHandler getHandler() {
            return handler;
        }

        @Override
        public Atom field(Object key) {
            throw new IllegalArgumentException("net:http-redirect-handler does not have fields.");
        }
    }
}
