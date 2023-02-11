package palaiologos.kamilalisp.runtime.cas;

import org.armedbear.lisp.Interpreter;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.util.Iterator;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.atomic.AtomicBoolean;

public class FriCAS {
    // Singleton API
    private static FriCAS instance = null;
    public FriCAS getInstance() {
        if (instance == null) {
            instance = new FriCAS();
        }
        return instance;
    }

    // Normal API.
    private Interpreter interpreter;
    private LinkedBlockingQueue<Integer> cin = new LinkedBlockingQueue<>();
    private LinkedBlockingQueue<Integer> cout = new LinkedBlockingQueue<>();
    private Thread thread;

    private FriCAS() {
        InputStream is = new InputStream() {
            @Override
            public int read() {
                int value;
                try {
                    value = cin.take();
                } catch (InterruptedException e) {
                    value = -1;
                }
                return value;
            }

            @Override
            public int available() {
                return cin.size();
            }
        };

        OutputStream os = new OutputStream() {
            @Override
            public void write(int b) {
                cout.add(b);
                System.out.write(b);
            }
        };

        URL resUrl = this.getClass().getResource("/lisp/fricas.lisp");
        String urlString = resUrl.toString();
        String str = urlString.substring(0, urlString.length() - "/fricas.lisp".length());
        this.interpreter = Interpreter.createInstance(is, os, str);
        thread = new Thread(() -> interpreter.eval("(load \"fricas.lisp\")"));
        thread.setDaemon(true);
        thread.start();
        StringBuilder sb = new StringBuilder();
        while(!sb.toString().endsWith(") -> ")) {
            try {
                sb.append((char) cout.take().intValue());
            } catch (InterruptedException e) { }
        }
    }

    private String eval(String s) {
        cout.clear();
        byte[] data = s.getBytes();
        for (byte b : data) {
            cin.add((int) b);
        }
        StringBuilder sb = new StringBuilder();
        while(!sb.toString().endsWith(") -> ")) {
            try {
                sb.append((char) cout.take().intValue());
            } catch (InterruptedException e) { }
        }
        return sb.toString();
    }

    public static void main(String[] args) {
        FriCAS cas = new FriCAS();
        System.out.println(cas.eval("integrate(exp(1/x^2)/x^3,x)::InputForm\n"));
        System.out.println(cas.eval("limit(exp(-1/x^2),x=0)::InputForm\n"));
    }
}
