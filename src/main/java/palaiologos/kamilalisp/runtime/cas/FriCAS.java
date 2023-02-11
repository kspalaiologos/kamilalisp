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
    private LinkedBlockingQueue<Integer> cin = new LinkedBlockingQueue<>();
    private LinkedBlockingQueue<Integer> cout = new LinkedBlockingQueue<>();
    private Thread thread;
    private AtomicBoolean pending = new AtomicBoolean(false);

    private FriCAS() {
        InputStream is = new InputStream() {
            @Override
            public int read() {
                int value;
                pending.set(true);
                try {
                    value = cin.take();
                } catch (InterruptedException e) {
                    throw new RuntimeException(e);
                }
                pending.set(false);
                System.out.println("Sending " + value);
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
        thread = new Thread(() -> {
            Interpreter interpreter = Interpreter.createInstance(is, os, str);
            interpreter.eval("(load \"fricas.lisp\")");
        });
        thread.setDaemon(true);
        thread.start();

        // Wait until input is desired.
        while(!pending.get()) {
            try {
                Thread.sleep(10);
            } catch (InterruptedException e) {
                throw new RuntimeException(e);
            }
        }
        cout.clear();

        System.out.println("FriCAS started.");
    }

    private String eval(String s) {
        // Send input.
        byte[] bytes = s.getBytes();
        for (byte b : bytes) {
            cin.add((int) b);
        }

        // Wait until input is desired again.
        while(pending.get()) {
            try {
                Thread.sleep(10);
            } catch (InterruptedException e) {
                throw new RuntimeException(e);
            }
        }

        // Read output.
        byte[] bytesOut = new byte[cout.size()];
        Iterator<Integer> it = cout.iterator();
        for (int i = 0; i < bytesOut.length; i++) {
            bytesOut[i] = it.next().byteValue();
        }
        cout.clear();
        return new String(bytesOut);
    }

    public static void main(String[] args) {
        FriCAS cas = new FriCAS();
        System.out.println(cas.eval("integrate(exp(1/x^2)/x^3,x)::InputForm\n"));
        System.out.println(cas.eval("limit(exp(-1/x^2),x=0)::InputForm\n"));
    }
}
