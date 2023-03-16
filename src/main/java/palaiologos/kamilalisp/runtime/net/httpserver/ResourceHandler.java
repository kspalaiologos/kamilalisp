package palaiologos.kamilalisp.runtime.net.httpserver;

import io.undertow.Handlers;
import io.undertow.server.HttpHandler;
import io.undertow.server.handlers.resource.PathResourceManager;
import palaiologos.kamilalisp.atom.*;

import java.io.File;
import java.nio.file.Paths;
import java.util.List;

public class ResourceHandler extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        String directory = args.get(0).getString();
        return new Atom(new ResourceHandlerUserdata(directory));
    }

    @Override
    protected String name() {
        return "net:http-resource-handler";
    }

    public static class ResourceHandlerUserdata extends UndertowHttpHandlerWrapper {
        private final io.undertow.server.handlers.resource.ResourceHandler handler;

        public ResourceHandlerUserdata(String directory) {
            this.handler = new io.undertow.server.handlers.resource.ResourceHandler(new PathResourceManager(new File(directory).getAbsoluteFile().toPath(), 100));
            handler.setDirectoryListingEnabled(false);
        }

        @Override
        public HttpHandler getHandler() {
            return handler;
        }

        @Override
        public Atom field(Object key) {
            throw new IllegalArgumentException("net:http-resource-handler does not have fields.");
        }
    }
}
