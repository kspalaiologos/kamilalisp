package palaiologos.kamilalisp.runtime.net;

import org.pcollections.HashTreePMap;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.runtime.hashmap.HashMapUserData;

import javax.net.SocketFactory;
import javax.net.ssl.*;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.security.*;
import java.security.cert.CertificateException;
import java.util.List;

public class NetClientSSL extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 6);
        String host = args.get(0).getString();
        int port = args.get(1).getInteger().intValueExact();
        String trustStorePath = args.get(2).getString();
        String trustStorePassword = args.get(3).getString();
        String keyStorePath = args.get(4).getString();
        String keyStorePassword = args.get(5).getString();
        try {
            // Kilometer long magic incantations.
            // Advisable to not touch and ignore.
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

            SocketFactory factory = ctx.getSocketFactory();
            Socket connection = factory.createSocket(host, port);
            ((SSLSocket) connection).setEnabledProtocols(new String[] {"TLSv1.2"});
            // Difference from the server code, no idea what this accomplishes but
            // without this, the code ceases to work.
            SSLParameters sslParams = new SSLParameters();
            sslParams.setEndpointIdentificationAlgorithm("HTTPS");
            ((SSLSocket) connection).setSSLParameters(sslParams);

            return new Atom(new HashMapUserData(HashTreePMap.from(SocketObject.from(connection))));
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
