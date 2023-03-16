package palaiologos.kamilalisp.runtime.net.httpserver;

import io.undertow.server.HttpHandler;
import io.undertow.server.handlers.Cookie;
import io.undertow.server.handlers.CookieImpl;
import org.pcollections.HashPMap;
import org.pcollections.HashTreePMap;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.runtime.IO.streams.StreamWrapper;
import palaiologos.kamilalisp.runtime.hashmap.HashMapUserData;

import java.math.BigInteger;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class LiteralHandler extends PrimitiveFunction implements SpecialForm {
    abstract static class LiteralCallback extends PrimitiveFunction implements Lambda { }

    // Static atom instances.
    private static final Atom name = new Atom("name");
    private static final Atom value = new Atom("value");
    private static final Atom domain = new Atom("domain");
    private static final Atom path = new Atom("path");
    private static final Atom maxAge = new Atom("max-age");
    private static final Atom version = new Atom("version");
    private static final Atom secure = new Atom("secure");
    private static final Atom httpOnly = new Atom("http-only");
    private static final Atom inputStream = new Atom("input-stream");
    private static final Atom remoteHost = new Atom("remote-host");
    private static final Atom remotePort = new Atom("remote-port");
    private static final Atom localHost = new Atom("local-host");
    private static final Atom localPort = new Atom("local-port");
    private static final Atom protocol = new Atom("protocol");
    private static final Atom method = new Atom("method");
    private static final Atom query = new Atom("query");
    private static final Atom requestHeadersA = new Atom("request-headers");
    private static final Atom pathParametersA = new Atom("path-parameters");
    private static final Atom queryParametersA = new Atom("query-parameters");
    private static final Atom charset = new Atom("charset");
    private static final Atom cookies = new Atom("cookies");
    private static final Atom setStatusCode = new Atom("set-status-code");
    private static final Atom outputStream = new Atom("output-stream");
    private static final Atom endExchange = new Atom("end-exchange");
    private static final Atom getCookies = new Atom("get-cookies");
    private static final Atom addCookie = new Atom("add-cookie");
    private static final Atom removeCookie = new Atom("remove-cookie");

    private Atom cookiesToAtom(Map<String, Cookie> in) {
        HashMap<Atom, Atom> cookies = new HashMap<>();
        for(var cookie : in.entrySet()) {
            HashMap<Atom, Atom> cookieData = new HashMap<>();
            cookieData.put(name, new Atom(cookie.getKey()));
            cookieData.put(value, new Atom(cookie.getValue().getValue()));
            cookieData.put(domain, new Atom(cookie.getValue().getDomain()));
            cookieData.put(path, new Atom(cookie.getValue().getPath()));
            cookieData.put(maxAge, new Atom(BigInteger.valueOf(cookie.getValue().getMaxAge())));
            cookieData.put(version, new Atom(BigInteger.valueOf(cookie.getValue().getVersion())));
            cookieData.put(secure, new Atom(cookie.getValue().isSecure()));
            cookieData.put(httpOnly, new Atom(cookie.getValue().isHttpOnly()));
            cookies.put(new Atom(cookie.getKey()), new Atom(new HashMapUserData(HashTreePMap.from(cookieData))));
        }
        return new Atom(new HashMapUserData(HashTreePMap.from(cookies)));
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        Callable callback = args.get(0).getCallable();
        return new Atom(new LiteralHandlerUserdata(httpServerExchange -> {
            HashMap<Atom, Atom> args1 = new HashMap<>();
            args1.put(inputStream, new Atom(new StreamWrapper.InputStreamUserdata(httpServerExchange.getInputStream()) {
                @Override
                public String toDisplayString() {
                    return "net:http-literal-handler.input-stream";
                }

                @Override
                public Atom specialField(Object key) {
                    throw new UnsupportedOperationException();
                }
            }));
            args1.put(remoteHost, new Atom(httpServerExchange.getSourceAddress().getHostName()));
            args1.put(remotePort, new Atom(BigInteger.valueOf(httpServerExchange.getSourceAddress().getPort())));
            args1.put(localHost, new Atom(httpServerExchange.getDestinationAddress().getHostName()));
            args1.put(localPort, new Atom(BigInteger.valueOf(httpServerExchange.getDestinationAddress().getPort())));
            args1.put(protocol, new Atom(httpServerExchange.getProtocol().toString()));
            args1.put(method, new Atom(httpServerExchange.getRequestMethod().toString()));
            args1.put(path, new Atom(httpServerExchange.getRequestPath()));
            args1.put(query, new Atom(httpServerExchange.getQueryString()));
            HashMap<Atom, Atom> requestHeaders = new HashMap<>();
            httpServerExchange.getRequestHeaders().getHeaderNames().forEach(name -> {
                requestHeaders.put(new Atom(name.toString()), new Atom(httpServerExchange.getRequestHeaders().get(name).stream().map(Atom::new).toList()));
            });
            args1.put(requestHeadersA, new Atom(new HashMapUserData(HashTreePMap.from(requestHeaders))));
            HashMap<Atom, Atom> pathParameters = new HashMap<>();
            httpServerExchange.getPathParameters().forEach((name, values) -> {
                pathParameters.put(new Atom(name), new Atom(values.stream().map(Atom::new).toList()));
            });
            args1.put(pathParametersA, new Atom(new HashMapUserData(HashTreePMap.from(pathParameters))));
            HashMap<Atom, Atom> queryParameters = new HashMap<>();
            httpServerExchange.getQueryParameters().forEach((name, values) -> {
                queryParameters.put(new Atom(name), new Atom(values.stream().map(Atom::new).toList()));
            });
            args1.put(queryParametersA, new Atom(new HashMapUserData(HashTreePMap.from(queryParameters))));
            args1.put(charset, new Atom(httpServerExchange.getRequestCharset()));
            args1.put(cookies, cookiesToAtom(httpServerExchange.getRequestCookies()));
            HashMap<Atom, Atom> resp = new HashMap<>();
            resp.put(setStatusCode, new Atom(new LiteralCallback() {
                @Override
                protected String name() {
                    return "net:http-literal-handler.set-status-code";
                }

                @Override
                public Atom apply(Environment env1, List<Atom> args1) {
                    assertArity(args1, 1);
                    httpServerExchange.setStatusCode(args1.get(0).getInteger().intValueExact());
                    return Atom.NULL;
                }
            }));
            resp.put(outputStream, new Atom(new StreamWrapper.OutputStreamUserdata(httpServerExchange.getOutputStream()) {
                @Override
                public String toDisplayString() {
                    return "net:http-literal-handler.output-stream";
                }

                @Override
                public Atom specialField(Object key) {
                    throw new UnsupportedOperationException();
                }
            }));
            resp.put(endExchange, new Atom(new LiteralCallback() {
                @Override
                protected String name() {
                    return "net:http-literal-handler.end-exchange";
                }

                @Override
                public Atom apply(Environment env1, List<Atom> args1) {
                    httpServerExchange.endExchange();
                    return Atom.NULL;
                }
            }));
            resp.put(getCookies, new Atom(new LiteralCallback() {
                @Override
                protected String name() {
                    return "net:http-literal-handler.get-cookies";
                }

                @Override
                public Atom apply(Environment env, List<Atom> args) {
                    return cookiesToAtom(httpServerExchange.getResponseCookies());
                }
            }));
            resp.put(addCookie, new Atom(new LiteralCallback() {
                @Override
                protected String name() {
                    return "net:http-literal-handler.add-cookie";
                }

                @Override
                public Atom apply(Environment env, List<Atom> args) {
                    HashPMap<Atom, Atom> newCookieData = args.get(0).getUserdata(HashMapUserData.class).value();
                    Cookie c = new CookieImpl(newCookieData.get(name).getString(), newCookieData.get(value).getString());
                    if (newCookieData.containsKey(domain))
                        c.setDomain(newCookieData.get(domain).getString());
                    if (newCookieData.containsKey(path))
                        c.setPath(newCookieData.get(path).getString());
                    if (newCookieData.containsKey(maxAge))
                        c.setMaxAge(newCookieData.get(maxAge).getInteger().intValueExact());
                    if (newCookieData.containsKey(version))
                        c.setVersion(newCookieData.get(version).getInteger().intValueExact());
                    if (newCookieData.containsKey(secure))
                        c.setSecure(newCookieData.get(secure).coerceBool());
                    if (newCookieData.containsKey(httpOnly))
                        c.setHttpOnly(newCookieData.get(httpOnly).coerceBool());
                    httpServerExchange.getResponseCookies().put(c.getName(), c);
                    return Atom.NULL;
                }
            }));
            resp.put(removeCookie, new Atom(new LiteralCallback() {
                @Override
                protected String name() {
                    return "net:http-literal-handler.remove-cookie";
                }

                @Override
                public Atom apply(Environment env, List<Atom> args) {
                    assertArity(args, 1);
                    String name = args.get(0).getString();
                    httpServerExchange.getResponseCookies().remove(name);
                    return Atom.NULL;
                }
            }));
            Evaluation.evaluate(env, callback, List.of(new Atom(new HashMapUserData(HashTreePMap.from(args1))), new Atom(new HashMapUserData(HashTreePMap.from(resp)))));
        }));
    }

    @Override
    protected String name() {
        return "net:http-literal-handler";
    }

    public static class LiteralHandlerUserdata extends UndertowHttpHandlerWrapper {
        private HttpHandler h;

        public LiteralHandlerUserdata(HttpHandler h) {
            this.h = h;
        }

        @Override
        public HttpHandler getHandler() {
            return h;
        }
    }
}
