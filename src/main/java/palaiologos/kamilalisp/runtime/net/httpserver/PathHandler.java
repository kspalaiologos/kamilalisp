package palaiologos.kamilalisp.runtime.net.httpserver;

import io.undertow.Handlers;
import io.undertow.server.HttpHandler;
import palaiologos.kamilalisp.atom.*;

import java.util.List;

public class PathHandler extends PrimitiveFunction implements SpecialForm {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        return new Atom(new PathHandlerUserdata());
    }

    @Override
    protected String name() {
        return "net:http-path-handler";
    }

    public static class PathHandlerUserdata extends UndertowHttpHandlerWrapper {
        private io.undertow.server.handlers.PathHandler handler;

        public PathHandlerUserdata() {
            this.handler = Handlers.path();
        }

        @Override
        public HttpHandler getHandler() {
            return handler;
        }

        @Override
        public Atom field(Object key) {
            if(!(key instanceof String k)) {
                throw new IllegalArgumentException("net:http-path-handler expects string fields.");
            }

            return switch (k) {
                case "add-exact" -> new Atom(new AddExact());
                case "add-prefix" -> new Atom(new AddPrefix());
                default -> throw new IllegalArgumentException("net:http-path-handler does not have field " + key);
            };
        }

        class AddExact extends PrimitiveFunction implements Lambda {
            @Override
            public Atom apply(Environment env, List<Atom> args) {
                assertArity(args, 2);
                String name = args.get(0).getString();
                HttpHandler handler = args.get(1).getUserdata(UndertowHttpHandlerWrapper.class).getHandler();
                PathHandlerUserdata.this.handler.addExactPath(name, handler);
                return Atom.NULL;
            }

            @Override
            protected String name() {
                return "net:http-path-handler.add-exact";
            }
        }

        class AddPrefix extends PrimitiveFunction implements Lambda {
            @Override
            public Atom apply(Environment env, List<Atom> args) {
                assertArity(args, 2);
                String name = args.get(0).getString();
                HttpHandler handler = args.get(1).getUserdata(UndertowHttpHandlerWrapper.class).getHandler();
                PathHandlerUserdata.this.handler.addPrefixPath(name, handler);
                return Atom.NULL;
            }

            @Override
            protected String name() {
                return "net:http-path-handler.add-prefix";
            }
        }
    }
}
