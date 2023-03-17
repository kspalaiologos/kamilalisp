package palaiologos.kamilalisp.runtime.net.httpserver;

import io.undertow.Undertow;
import palaiologos.kamilalisp.atom.*;

import java.util.List;

public class HTTPServer extends PrimitiveFunction implements SpecialForm {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        return new Atom(new UndertowBuilderWrapperUserdata(Undertow.builder()));
    }

    @Override
    protected String name() {
        return "net:http-server-builder";
    }
}
