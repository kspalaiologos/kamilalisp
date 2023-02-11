package palaiologos.kamilalisp.runtime.cas;

import org.armedbear.lisp.Interpreter;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
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
    private AtomicBoolean waitingForInput = new AtomicBoolean(false);

    private FriCAS() {
        InputStream is = new InputStream() {
            @Override
            public int read() {
                waitingForInput.set(true);
                int value;
                try {
                    value = cin.take();
                } catch (InterruptedException e) {
                    value = -1;
                }
                waitingForInput.set(false);
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
            }
        };

        URL resUrl = this.getClass().getResource("lisp/fricas.lisp");
        String urlString = resUrl.toString();
        String str = urlString.substring(0, urlString.length() - "lisp/fricas.lisp".length());
        this.interpreter = Interpreter.createJLispInstance(is, os, str, "");
        interpreter.eval("(load \"lisp/fricas.lisp\")");
    }

    private String eval(String s) {
        byte[] data = s.getBytes();
        for (byte b : data) {
            cin.add((int) b);
        }
        while(!waitingForInput.get() || cout.isEmpty() || !cin.isEmpty()) {
            try {
                Thread.sleep(1);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        StringBuilder sb = new StringBuilder();
        while(!cout.isEmpty()) {
            sb.append((char) cout.poll().intValue());
        }
        return sb.toString();
    }

    public static void main(String[] args) {
        FriCAS cas = new FriCAS();
        System.out.println(cas.eval("integrate(exp(1/x^2)/x^3,x)::InputForm"));
    }
}
