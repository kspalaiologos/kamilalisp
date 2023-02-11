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
    public static FriCAS getInstance() {
        if (instance == null) {
            instance = new FriCAS();
        }
        return instance;
    }

    // Normal API.
    public LinkedBlockingQueue<Integer> cin = new LinkedBlockingQueue<>();
    public LinkedBlockingQueue<Integer> cout = new LinkedBlockingQueue<>();
    public static InputStream nis = InputStream.nullInputStream();
    private Thread thread;

    private FriCAS() {
        URL resUrl = this.getClass().getResource("/lisp/fricas.lisp");
        String urlString = resUrl.toString();
        String str = urlString.substring(0, urlString.length() - "/fricas.lisp".length());
        thread = new Thread(() -> {
            Interpreter interpreter = Interpreter.createInstance(nis, System.out, str);
            interpreter.eval("(load \"fricas.lisp\")");
        });
        thread.setDaemon(true);
        thread.start();
    }

    private String eval(String msg) {
        msg.codePoints().forEach(cin::add);
        return "";
    }

    public static void main(String[] args) {
        FriCAS cas = FriCAS.getInstance();
        System.out.println(cas.eval("integrate(exp(1/x^2)/x^3,x)::InputForm\n"));
        System.out.println(cas.eval("limit(exp(-1/x^2),x=0)::InputForm\n"));
        while(true) {
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}
