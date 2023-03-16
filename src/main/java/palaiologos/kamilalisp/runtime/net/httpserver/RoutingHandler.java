package palaiologos.kamilalisp.runtime.net.httpserver;

import io.undertow.Handlers;
import io.undertow.server.HttpHandler;
import palaiologos.kamilalisp.atom.*;

import java.util.List;

public class RoutingHandler extends PrimitiveFunction implements SpecialForm {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        return new Atom(new RoutingHandlerUserdata());
    }

    @Override
    protected String name() {
        return "net:http-routing-handler";
    }

    public static class RoutingHandlerUserdata extends UndertowHttpHandlerWrapper {
        private final io.undertow.server.RoutingHandler handler;

        public RoutingHandlerUserdata() {
            this.handler = Handlers.routing();
        }

        @Override
        public HttpHandler getHandler() {
            return handler;
        }

        @Override
        public Atom field(Object key) {
            if(!(key instanceof String k)) {
                throw new IllegalArgumentException("net:http-routing-handler expects string fields.");
            }

            return switch (k) {
                case "get" -> new Atom(new Get());
                case "put" -> new Atom(new Put());
                case "post" -> new Atom(new Post());
                case "delete" -> new Atom(new Delete());
                case "fallback" -> new Atom(new Fallback());
                default -> throw new IllegalArgumentException("net:http-routing-handler does not have field " + key);
            };
        }

        class Get extends PrimitiveFunction implements Lambda {
            @Override
            public Atom apply(Environment env, List<Atom> args) {
                assertArity(args, 2);
                handler.get(args.get(0).getString(), args.get(1).getUserdata(UndertowHttpHandlerWrapper.class).getHandler());
                return Atom.NULL;
            }

            @Override
            protected String name() {
                return "net:http-routing-handler.get";
            }
        }

        class Put extends PrimitiveFunction implements Lambda {
            @Override
            public Atom apply(Environment env, List<Atom> args) {
                assertArity(args, 2);
                handler.put(args.get(0).getString(), args.get(1).getUserdata(UndertowHttpHandlerWrapper.class).getHandler());
                return Atom.NULL;
            }

            @Override
            protected String name() {
                return "net:http-routing-handler.put";
            }
        }

        class Post extends PrimitiveFunction implements Lambda {
            @Override
            public Atom apply(Environment env, List<Atom> args) {
                assertArity(args, 2);
                handler.post(args.get(0).getString(), args.get(1).getUserdata(UndertowHttpHandlerWrapper.class).getHandler());
                return Atom.NULL;
            }

            @Override
            protected String name() {
                return "net:http-routing-handler.post";
            }
        }

        class Delete extends PrimitiveFunction implements Lambda {
            @Override
            public Atom apply(Environment env, List<Atom> args) {
                assertArity(args, 2);
                handler.delete(args.get(0).getString(), args.get(1).getUserdata(UndertowHttpHandlerWrapper.class).getHandler());
                return Atom.NULL;
            }

            @Override
            protected String name() {
                return "net:http-routing-handler.delete";
            }
        }

        class Fallback extends PrimitiveFunction implements Lambda {
            @Override
            public Atom apply(Environment env, List<Atom> args) {
                assertArity(args, 1);
                handler.setFallbackHandler(args.get(1).getUserdata(UndertowHttpHandlerWrapper.class).getHandler());
                return Atom.NULL;
            }

            @Override
            protected String name() {
                return "net:http-routing-handler.fallback";
            }
        }
    }
}
