package palaiologos.kamilalisp.runtime.net;

import jakarta.servlet.ServletException;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.eclipse.jetty.server.Request;
import org.eclipse.jetty.server.Server;
import org.eclipse.jetty.server.handler.AbstractHandler;
import org.eclipse.jetty.server.handler.ContextHandler;
import org.eclipse.jetty.server.handler.ContextHandlerCollection;
import org.eclipse.jetty.server.session.SessionHandler;
import org.pcollections.HashTreePMap;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.runtime.IO.streams.StreamWrapper;
import palaiologos.kamilalisp.runtime.hashmap.HashMapUserData;

import java.io.IOException;
import java.math.BigInteger;
import java.net.InetSocketAddress;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;

public class HTTPServer extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        int port = args.get(0).getInteger().intValueExact();
        Server s = new Server(InetSocketAddress.createUnresolved("127.0.0.1", port));
        return new Atom(new HTTPServerUserdata(s, env));
    }

    @Override
    protected String name() {
        return "net:http-server";
    }

    private static class HTTPServerUserdata implements Userdata {
        private final Server s;
        private final ContextHandlerCollection contextCollection;
        private final Environment e;

        public HTTPServerUserdata(Server s, Environment e) {
            this.s = s;
            this.e = e;
            contextCollection = new ContextHandlerCollection();
            SessionHandler sh = new SessionHandler();
            sh.setHandler(contextCollection);
            s.setHandler(sh);
        }

        @Override
        public Atom field(Object key) {
            if(!(key instanceof String)) {
                throw new RuntimeException("HTTPServerUserdata: key must be a string");
            }

            String k = (String) key;
            switch(k) {
                case "start":
                    return new Atom(new ServerStart());
                case "stop":
                    return new Atom(new ServerStop());
                case "add-handler":
                    return new Atom(new ServerAddHandler());
                default:
                    throw new RuntimeException("HTTPServerUserdata: unknown key " + k);
            }
        }

        @Override
        public int hashCode() {
            return s.hashCode();
        }

        @Override
        public int compareTo(Userdata other) {
            return hashCode() - other.hashCode();
        }

        @Override
        public boolean equals(Userdata other) {
            return compareTo(other) == 0;
        }

        @Override
        public String toDisplayString() {
            return "HTTPServer - " + s.getURI();
        }

        @Override
        public String typeName() {
            return "net:http-server";
        }

        @Override
        public boolean coerceBoolean() {
            return s.isRunning();
        }

        private class ServerStart extends PrimitiveFunction implements Lambda {
            @Override
            public Atom apply(Environment env, List<Atom> args) {
                try {
                    s.start();
                } catch (Exception e) {
                    throw new RuntimeException(e);
                }
                return Atom.NULL;
            }

            @Override
            protected String name() {
                return "net:http-server:start";
            }
        }

        private class ServerStop extends PrimitiveFunction implements Lambda {
            @Override
            public Atom apply(Environment env, List<Atom> args) {
                try {
                    s.stop();
                } catch (Exception e) {
                    throw new RuntimeException(e);
                }
                return Atom.NULL;
            }

            @Override
            protected String name() {
                return "net:http-server:stop";
            }
        }

        private class ServerAddHandler extends PrimitiveFunction implements Lambda {
            @Override
            public Atom apply(Environment env, List<Atom> args) {
                assertArity(args, 2);
                String path = args.get(0).getString();
                Callable callback = args.get(1).getCallable();
                ContextHandler context = new ContextHandler("/" + path);
                context.setServer(s);
                context.setHandler(new AbstractHandler() {
                    @Override
                    public void handle(String s, Request request, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws IOException, ServletException {
                        HashMap<Atom, Atom> env = new HashMap<>();
                        env.put(new Atom("path"), new Atom(request.getPathInfo()));
                        env.put(new Atom("method"), new Atom(request.getMethod()));
                        env.put(new Atom("query"), new Atom(request.getQueryString()));
                        env.put(new Atom("body"), new Atom(request.getReader().readLine()));
                        env.put(new Atom("character-encoding"), new Atom(request.getCharacterEncoding()));
                        env.put(new Atom("content-length"), new Atom(BigInteger.valueOf(request.getContentLength())));
                        env.put(new Atom("content-type"), new Atom(request.getContentType()));
                        env.put(new Atom("protocol"), new Atom(request.getProtocol()));
                        env.put(new Atom("scheme"), new Atom(request.getScheme()));
                        env.put(new Atom("server-name"), new Atom(request.getServerName()));
                        env.put(new Atom("server-port"), new Atom(BigInteger.valueOf(request.getServerPort())));
                        env.put(new Atom("remote-addr"), new Atom(request.getRemoteAddr()));
                        env.put(new Atom("remote-host"), new Atom(request.getRemoteHost()));
                        env.put(new Atom("remote-port"), new Atom(BigInteger.valueOf(request.getRemotePort())));
                        env.put(new Atom("local-addr"), new Atom(request.getLocalAddr()));
                        env.put(new Atom("local-name"), new Atom(request.getLocalName()));
                        env.put(new Atom("local-port"), new Atom(BigInteger.valueOf(request.getLocalPort())));
                        env.put(new Atom("auth-type"), new Atom(request.getAuthType()));
                        env.put(new Atom("context-path"), new Atom(request.getContextPath()));
                        env.put(new Atom("path-info"), new Atom(request.getPathInfo()));
                        env.put(new Atom("path-translated"), new Atom(request.getPathTranslated()));
                        env.put(new Atom("remote-user"), new Atom(request.getRemoteUser()));
                        env.put(new Atom("requested-session-id"), new Atom(request.getRequestedSessionId()));
                        env.put(new Atom("request-uri"), new Atom(request.getRequestURI()));
                        env.put(new Atom("request-url"), new Atom(request.getRequestURL().toString()));
                        env.put(new Atom("servlet-path"), new Atom(request.getServletPath()));
                        // Headers:
                        HashMap<Atom, Atom> headers = new HashMap<>();
                        Enumeration<String> headerNames = request.getHeaderNames();
                        while(headerNames.hasMoreElements()) {
                            String headerName = headerNames.nextElement();
                            headers.put(new Atom(headerName), new Atom(request.getHeader(headerName)));
                        }
                        env.put(new Atom("headers"), new Atom(new HashMapUserData(HashTreePMap.from(headers))));
                        // Parameters:
                        HashMap<Atom, Atom> parameters = new HashMap<>();
                        Enumeration<String> parameterNames = request.getParameterNames();
                        while(parameterNames.hasMoreElements()) {
                            String parameterName = parameterNames.nextElement();
                            parameters.put(new Atom(parameterName), new Atom(request.getParameter(parameterName)));
                        }
                        env.put(new Atom("parameters"), new Atom(new HashMapUserData(HashTreePMap.from(parameters))));
                        // Cookies:
                        HashMap<Atom, Atom> cookies = new HashMap<>();
                        Cookie[] requestCookies = request.getCookies();
                        if(requestCookies != null) {
                            for(Cookie cookie : requestCookies) {
                                HashMap<Atom, Atom> cookieData = new HashMap<>();
                                cookieData.put(new Atom("comment"), new Atom(cookie.getComment()));
                                cookieData.put(new Atom("domain"), new Atom(cookie.getDomain()));
                                cookieData.put(new Atom("max-age"), new Atom(BigInteger.valueOf(cookie.getMaxAge())));
                                cookieData.put(new Atom("name"), new Atom(cookie.getName()));
                                cookieData.put(new Atom("path"), new Atom(cookie.getPath()));
                                cookieData.put(new Atom("secure"), new Atom(cookie.getSecure()));
                                cookieData.put(new Atom("value"), new Atom(cookie.getValue()));
                                cookieData.put(new Atom("version"), new Atom(BigInteger.valueOf(cookie.getVersion())));
                                cookies.put(new Atom(cookie.getName()), new Atom(new HashMapUserData(HashTreePMap.from(cookieData))));
                            }
                        }
                        env.put(new Atom("cookies"), new Atom(new HashMapUserData(HashTreePMap.from(cookies))));
                        // Session:
                        HashMap<Atom, Atom> sessionData = new HashMap<>();
                        HttpSession session = request.getSession();
                        Enumeration<String> sessionAttributeNames = session.getAttributeNames();
                        while(sessionAttributeNames.hasMoreElements()) {
                            String sessionAttributeName = sessionAttributeNames.nextElement();
                            sessionData.put(new Atom(sessionAttributeName), (Atom) (session.getAttribute(sessionAttributeName)));
                        }
                        HashMap<Atom, Atom> hSession = new HashMap<>();
                        hSession.put(new Atom("id"), new Atom(session.getId()));
                        hSession.put(new Atom("creation-time"), new Atom(BigInteger.valueOf(session.getCreationTime())));
                        hSession.put(new Atom("last-accessed-time"), new Atom(BigInteger.valueOf(session.getLastAccessedTime())));
                        hSession.put(new Atom("max-inactive-interval"), new Atom(BigInteger.valueOf(session.getMaxInactiveInterval())));
                        hSession.put(new Atom("new"), new Atom(session.isNew()));
                        hSession.put(new Atom("attributes"), new Atom(new HashMapUserData(HashTreePMap.from(sessionData))));
                        env.put(new Atom("session"), new Atom(new HashMapUserData(HashTreePMap.from(hSession))));
                        // TODO: Adding entries to session
                        Evaluation.evaluate(e, callback, List.of(
                                new Atom(new HashMapUserData(HashTreePMap.from(env))),
                                new Atom(new ResponseUserdata(httpServletResponse))));
                        request.setHandled(true);
                    }

                    static class ResponseUserdata implements Userdata {
                        HttpServletResponse response;

                        public ResponseUserdata(HttpServletResponse response) {
                            this.response = response;
                        }

                        @Override
                        public Atom field(Object key) {
                            if(!(key instanceof String)) {
                                throw new IllegalArgumentException("Key must be a string.");
                            }

                            switch ((String) key) {
                                case "set-status" -> {
                                    return new Atom(new ResponseSetStatus());
                                }
                                case "set-header" -> {
                                    return new Atom(new ResponseSetHeader());
                                }
                                case "set-cookie" -> {
                                    return new Atom(new ResponseSetCookie());
                                }
                                case "set-content-type" -> {
                                    return new Atom(new ResponseSetContentType());
                                }
                                case "stream" -> {
                                    try {
                                        ServletOutputStream os = response.getOutputStream();
                                        return new Atom(new StreamWrapper.OutputStreamUserdata(os) {
                                            @Override
                                            public String toDisplayString() {
                                                return "net:http-server:response:stream";
                                            }

                                            @Override
                                            public Atom specialField(Object key) {
                                                if(!(key instanceof String)) {
                                                    throw new IllegalArgumentException("Key must be a string.");
                                                }

                                                return switch((String) key) {
                                                    case "print" -> new Atom(new StreamPrint());
                                                    case "println" -> new Atom(new StreamPrintln());
                                                    default -> {
                                                        throw new IllegalArgumentException("Unknown field: " + key);
                                                    }
                                                };
                                            }

                                            class StreamPrint extends PrimitiveFunction implements Lambda {
                                                @Override
                                                public Atom apply(Environment env, List<Atom> args) {
                                                    for(Atom arg : args) {
                                                        if(arg.getType() == Type.STRING) {
                                                            try {
                                                                os.print(arg.getString());
                                                            } catch (IOException e) {
                                                                throw new RuntimeException(e);
                                                            }
                                                        } else {
                                                            try {
                                                                os.print(arg.toString());
                                                            } catch (IOException e) {
                                                                throw new RuntimeException(e);
                                                            }
                                                        }
                                                    }
                                                    return Atom.NULL;
                                                }

                                                @Override
                                                protected String name() {
                                                    return "net:http-server:response:stream:print";
                                                }
                                            }

                                            class StreamPrintln extends PrimitiveFunction implements Lambda {
                                                @Override
                                                public Atom apply(Environment env, List<Atom> args) {
                                                    for(Atom arg : args) {
                                                        if(arg.getType() == Type.STRING) {
                                                            try {
                                                                os.println(arg.getString());
                                                            } catch (IOException e) {
                                                                throw new RuntimeException(e);
                                                            }
                                                        } else {
                                                            try {
                                                                os.println(arg.toString());
                                                            } catch (IOException e) {
                                                                throw new RuntimeException(e);
                                                            }
                                                        }
                                                    }
                                                    return Atom.NULL;
                                                }

                                                @Override
                                                protected String name() {
                                                    return "net:http-server:response:stream:println";
                                                }
                                            }
                                        });
                                    } catch (IOException e) {
                                        throw new RuntimeException(e);
                                    }
                                }
                                default -> {
                                    throw new IllegalArgumentException("Unknown field: " + key);
                                }
                            }
                        }

                        @Override
                        public int hashCode() {
                            return response.hashCode();
                        }

                        @Override
                        public int compareTo(Userdata other) {
                            return hashCode() - other.hashCode();
                        }

                        @Override
                        public boolean equals(Userdata other) {
                            return compareTo(other) == 0;
                        }

                        @Override
                        public String toDisplayString() {
                            return "net:http-server:session";
                        }

                        @Override
                        public String typeName() {
                            return "net:http-server:session";
                        }

                        @Override
                        public boolean coerceBoolean() {
                            return true;
                        }

                        class ResponseSetStatus extends PrimitiveFunction implements Lambda {
                            @Override
                            public Atom apply(Environment env, List<Atom> args) {
                                if(args.size() != 1) {
                                    throw new IllegalArgumentException("set-status takes exactly one argument.");
                                }
                                Atom arg = args.get(0);
                                if(arg.getType() != Type.INTEGER) {
                                    throw new IllegalArgumentException("set-status takes an integer argument.");
                                }
                                response.setStatus(arg.getInteger().intValueExact());
                                return Atom.NULL;
                            }

                            @Override
                            protected String name() {
                                return "net:http-server:response:set-status";
                            }
                        }

                        class ResponseSetHeader extends PrimitiveFunction implements Lambda {
                            @Override
                            public Atom apply(Environment env, List<Atom> args) {
                                if(args.size() != 2) {
                                    throw new IllegalArgumentException("set-header takes exactly two arguments.");
                                }
                                Atom arg1 = args.get(0);
                                Atom arg2 = args.get(1);
                                if(arg1.getType() != Type.STRING) {
                                    throw new IllegalArgumentException("set-header takes a string as first argument.");
                                }
                                if(arg2.getType() != Type.STRING) {
                                    throw new IllegalArgumentException("set-header takes a string as second argument.");
                                }
                                response.setHeader(arg1.getString(), arg2.getString());
                                return Atom.NULL;
                            }

                            @Override
                            protected String name() {
                                return "net:http-server:response:set-header";
                            }
                        }

                        class ResponseSetCookie extends PrimitiveFunction implements Lambda {
                            @Override
                            public Atom apply(Environment env, List<Atom> args) {
                                if(args.size() != 1) {
                                    throw new IllegalArgumentException("set-cookie takes exactly one argument.");
                                }
                                Atom arg = args.get(0);
                                if(arg.getType() != Type.USERDATA) {
                                    throw new IllegalArgumentException("set-cookie takes a cookie as argument.");
                                }
                                Userdata ud = arg.getUserdata();
                                if(!ud.typeName().equals("net:http-server:cookie")) {
                                    throw new IllegalArgumentException("set-cookie takes a cookie as argument.");
                                }
                                Cookie cookie = (Cookie) ud;
                                response.addCookie(cookie);
                                return Atom.NULL;
                            }

                            @Override
                            protected String name() {
                                return "net:http-server:response:set-cookie";
                            }
                        }

                        class ResponseSetContentType extends PrimitiveFunction implements Lambda {
                            @Override
                            public Atom apply(Environment env, List<Atom> args) {
                                if(args.size() != 1) {
                                    throw new IllegalArgumentException("set-content-type takes exactly one argument.");
                                }
                                Atom arg = args.get(0);
                                if(arg.getType() != Type.STRING) {
                                    throw new IllegalArgumentException("set-content-type takes a string as argument.");
                                }
                                response.setContentType(arg.getString());
                                return Atom.NULL;
                            }

                            @Override
                            protected String name() {
                                return "net:http-server:response:set-content-type";
                            }
                        }
                    }
                });
                contextCollection.addHandler(context);
                return Atom.NULL;
            }

            @Override
            protected String name() {
                return "net:http-server:add-handler";
            }
        }
    }
}
