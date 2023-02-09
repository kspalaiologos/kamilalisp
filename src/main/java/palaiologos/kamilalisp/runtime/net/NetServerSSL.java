package palaiologos.kamilalisp.runtime.net;

import palaiologos.kamilalisp.atom.*;

import javax.net.ssl.*;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.ServerSocket;
import java.security.*;
import java.security.cert.CertificateException;
import java.util.List;

public class NetServerSSL extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 6);
        int port = args.get(0).getInteger().intValueExact();
        String trustStorePath = args.get(1).getString();
        String trustStorePassword = args.get(2).getString();
        String keyStorePath = args.get(3).getString();
        String keyStorePassword = args.get(4).getString();
        Callable callable = args.get(5).getCallable();
        try {
            // Kilometer long magic incantations.
            // Advisable to not touch and ignore.

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

            SSLContext ctx = SSLContext.getInstance("TLS");
            ctx.init(kmf.getKeyManagers(), tmf.getTrustManagers(), SecureRandom.getInstanceStrong());

            SSLServerSocketFactory factory = ctx.getServerSocketFactory();
            ServerSocket listener = factory.createServerSocket(port);
            SSLServerSocket sslListener = (SSLServerSocket) listener;
            sslListener.setNeedClientAuth(true);
            sslListener.setEnabledProtocols(new String[]{"TLSv1.2"});

            return new Atom(new ServerSocketUserdata(env, callable, listener));
        } catch (KeyStoreException | CertificateException | IOException | NoSuchAlgorithmException |
                 UnrecoverableKeyException | KeyManagementException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected String name() {
        return "net:server-ssl";
    }
}
