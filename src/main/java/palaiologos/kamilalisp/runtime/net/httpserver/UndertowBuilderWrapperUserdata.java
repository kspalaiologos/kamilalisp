package palaiologos.kamilalisp.runtime.net.httpserver;

import io.undertow.Undertow;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import javax.net.ssl.KeyManagerFactory;
import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManagerFactory;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.security.*;
import java.security.cert.CertificateException;
import java.util.List;

public class UndertowBuilderWrapperUserdata implements Userdata {
    private final Undertow.Builder builder;

    public UndertowBuilderWrapperUserdata(Undertow.Builder builder) {
        this.builder = builder;
    }

    @Override
    public int hashCode() {
        return builder.hashCode();
    }

    @Override
    public Atom field(Object key) {
        if(!(key instanceof String keyString)) {
            throw new IllegalArgumentException("key must be a string");
        }
        switch(keyString) {
            case "add-http-listener":
                return new Atom(new AddHTTPListenerUserdata());
            case "add-https-listener":
                return new Atom(new AddHTTPSListenerUserdata());
            case "set-handler":
                return new Atom(new SetHandler());
            case "server":
                return new Atom(new UndertowServerWrapperUserdata(builder.build()));
            default:
                throw new IllegalArgumentException("unknown key: " + keyString);
        }
    }

    @Override
    public String toDisplayString() {
        return "net:http-server:builder";
    }

    @Override
    public String typeName() {
        return "net:http-server:builder";
    }

    public class SetHandler extends PrimitiveFunction implements Lambda {
        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 1);
            UndertowHttpHandlerWrapper handler = args.get(0).getUserdata(UndertowHttpHandlerWrapper.class);
            builder.setHandler(handler.getHandler());
            return Atom.NULL;
        }

        @Override
        protected String name() {
            return "net:http-server:builder.set-handler";
        }
    }

    public class AddHTTPListenerUserdata extends PrimitiveFunction implements Lambda {
        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if(args.size() == 2) {
                String host = args.get(0).getString();
                int port = args.get(1).getInteger().intValueExact();
                builder.addHttpListener(port, host);
                return Atom.NULL;
            } else if(args.size() == 3) {
                String host = args.get(0).getString();
                int port = args.get(1).getInteger().intValueExact();
                UndertowHttpHandlerWrapper handler = args.get(2).getUserdata(UndertowHttpHandlerWrapper.class);
                builder.addHttpListener(port, host, handler.getHandler());
                return Atom.NULL;
            } else {
                throw new TypeError("Expected 2 or 3 arguments, got " + args.size());
            }
        }

        @Override
        protected String name() {
            return "net:http-server:builder.add-http-listener";
        }
    }

    public class AddHTTPSListenerUserdata extends PrimitiveFunction implements Lambda {
        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if(args.size() < 6) {
                throw new TypeError("Expected at least 6 arguments, got " + args.size());
            }
            int port = args.get(0).getInteger().intValueExact();
            String bindingAddress = args.get(1).getString();
            String trustStorePath = args.get(2).getString();
            String trustStorePassword = args.get(3).getString();
            String keyStorePath = args.get(4).getString();
            String keyStorePassword = args.get(5).getString();

            // Kilometer long magic incantations.
            // Advisable to not touch and ignore.
            SSLContext ctx;

            try {
                // TODO: manual, generate keys as follows:
                // keytool -genkeypair -alias server -keyalg EC \
                // -sigalg SHA384withECDSA -keysize 256 -keystore servercert.p12 \
                // -storetype pkcs12 -v -storepass abc123 -validity 10000 -ext san=ip:127.0.0.1
                KeyStore trustStore = KeyStore.getInstance(KeyStore.getDefaultType());
                InputStream trustStoreStream = new FileInputStream(trustStorePath);
                trustStore.load(trustStoreStream, trustStorePassword.toCharArray());
                trustStoreStream.close();
                TrustManagerFactory tmf = TrustManagerFactory.getInstance(TrustManagerFactory.getDefaultAlgorithm());
                tmf.init(trustStore);

                KeyStore keyStore = KeyStore.getInstance(KeyStore.getDefaultType());
                InputStream keyStoreStream = new FileInputStream(keyStorePath);
                keyStore.load(keyStoreStream, keyStorePassword.toCharArray());
                keyStoreStream.close();
                KeyManagerFactory kmf = KeyManagerFactory.getInstance(KeyManagerFactory.getDefaultAlgorithm());
                kmf.init(keyStore, keyStorePassword.toCharArray());

                ctx = SSLContext.getInstance("TLS");
                ctx.init(kmf.getKeyManagers(), tmf.getTrustManagers(), SecureRandom.getInstanceStrong());
            } catch (UnrecoverableKeyException | CertificateException | KeyStoreException | IOException |
                     NoSuchAlgorithmException | KeyManagementException e) {
                throw new RuntimeException(e);
            }

            if(args.size() == 6) {
                builder.addHttpsListener(port, bindingAddress, ctx);
                return Atom.NULL;
            } else if(args.size() == 7) {
                UndertowHttpHandlerWrapper handler = args.get(6).getUserdata(UndertowHttpHandlerWrapper.class);
                builder.addHttpsListener(port, bindingAddress, ctx, handler.getHandler());
                return Atom.NULL;
            } else {
                throw new TypeError("Expected 6 or 7 arguments, got " + args.size());
            }
        }

        @Override
        protected String name() {
            return "net:http-server:builder.add-https-listener";
        }
    }
}
