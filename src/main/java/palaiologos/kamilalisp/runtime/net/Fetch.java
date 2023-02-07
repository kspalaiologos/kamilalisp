package palaiologos.kamilalisp.runtime.net;

import org.pcollections.HashPMap;
import org.pcollections.HashTreePMap;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;
import palaiologos.kamilalisp.runtime.hashmap.HashMapUserData;

import java.io.InputStream;
import java.io.OutputStream;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

public class Fetch extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        try {
            if (args.size() == 1) {
                URL url = new URL(args.get(0).getString());
                HttpURLConnection con = (HttpURLConnection) url.openConnection();
                con.setRequestMethod("GET");
                con.setRequestProperty("User-Agent", "KamilaLisp");
                int responseCode = con.getResponseCode();
                InputStream response = con.getInputStream();
                byte[] data = response.readAllBytes();
                response.close();
                List<Atom> buffer = new ArrayList<>();
                for (byte b : data) buffer.add(new Atom(BigInteger.valueOf(b)));
                return new Atom(List.of(new Atom(BigInteger.valueOf(responseCode)), new Atom(buffer)));
            } else if(args.size() == 2) {
                URL url = new URL(args.get(0).getString());
                HashPMap<Atom, Atom> headers = args.get(1).getUserdata(HashMapUserData.class).value;
                HttpURLConnection con = (HttpURLConnection) url.openConnection();
                con.setRequestMethod(headers.getOrDefault(new Atom("method"), new Atom("GET")).getString());
                HashPMap<Atom, Atom> properties = headers.getOrDefault(new Atom("properties"), new Atom(new HashMapUserData(HashTreePMap.empty()))).getUserdata(HashMapUserData.class).value;
                for (Atom key : properties.keySet()) {
                    con.setRequestProperty(key.getString(), properties.get(key).getString());
                }
                List<Atom> body = headers.getOrDefault(new Atom("body"), new Atom(new ArrayList<>())).getList();
                if(!body.isEmpty()) {
                    con.setDoOutput(true);
                    byte[] requestData = new byte[body.size()];
                    for (int i = 0; i < body.size(); i++) {
                        requestData[i] = body.get(i).getInteger().byteValueExact();
                    }
                    OutputStream os = con.getOutputStream();
                    os.write(requestData);
                    os.flush();
                    os.close();
                }
                int responseCode = con.getResponseCode();
                InputStream response = con.getInputStream();
                byte[] data = response.readAllBytes();
                response.close();
                List<Atom> buffer = new ArrayList<>();
                for (byte b : data) buffer.add(new Atom(BigInteger.valueOf(b)));
                return new Atom(List.of(new Atom(BigInteger.valueOf(responseCode)), new Atom(buffer)));
            } else {
                throw new RuntimeException("net:fetch takes 1 or 2 arguments");
            }
        } catch(Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected String name() {
        return "net:fetch";
    }
}
