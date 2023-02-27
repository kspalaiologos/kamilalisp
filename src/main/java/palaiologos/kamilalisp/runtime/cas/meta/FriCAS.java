package palaiologos.kamilalisp.runtime.cas.meta;

import org.armedbear.lisp.Interpreter;
import palaiologos.kamilalisp.atom.Pair;

import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.atomic.AtomicReference;
import java.util.concurrent.locks.ReentrantLock;
import java.util.function.Function;

public class FriCAS {
    public static InputStream nis = InputStream.nullInputStream();
    // Singleton API
    private static volatile AtomicReference<FriCAS> instance = null;
    private static final ReentrantLock lock = new ReentrantLock();
    // Normal API.
    public LinkedBlockingQueue<Integer> cin = new LinkedBlockingQueue<>();
    public LinkedBlockingQueue<String> cout = new LinkedBlockingQueue<>();
    private Thread thread;

    public static FriCAS getInstance() {
        if (instance == null) {
            throw new RuntimeException("FriCAS not initialized.");
        }
        return instance.get();
    }

    public static Object withFriCas(Function<Function<String, EvaluationResult>, Object> callback) {
        lock.lock();
        if (instance == null) {
            instance = new AtomicReference<>(new FriCAS());
            URL resUrl = FriCAS.class.getResource("/lisp/fricas.lisp");
            String urlString = resUrl.toString();
            String str = urlString.substring(0, urlString.length() - "/fricas.lisp".length());
            instance.get().thread = new Thread(Thread.currentThread().getThreadGroup(), () -> {
                List<Byte> cout = new ArrayList<>();
                Interpreter interpreter = Interpreter.createInstance(nis, new OutputStream() {
                    @Override
                    public void write(int b) {
                        cout.add((byte) b);
                        if (b == '\n') {
                            byte[] data = new byte[cout.size()];
                            for (int i = 0; i < cout.size(); i++)
                                data[i] = cout.get(i);
                            instance.get().cout.add(new String(data));
                            cout.clear();
                        }
                    }
                }, str);
                interpreter.eval("(load \"fricas.lisp\")");
            }, "FriCAS", 16777216);
            instance.get().thread.setDaemon(true);
            instance.get().thread.start();
            instance.get().untilPrompt();
        }
        Object result;
        try {
            result = callback.apply(x -> instance.get().eval(x));
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            lock.unlock();
        }
        return result;
    }

    private Pair<String, String> untilPrompt() {
        List<String> result = new ArrayList<>();
        while (true) {
            try {
                String line = cout.take();
                if (line.matches("\\([0-9]+\\)\\ ->\\ \n")) {
                    break;
                }
                result.add(line);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        if (result.isEmpty()) {
            return new Pair<>("", "");
        } else if (result.size() == 1) {
            return new Pair<>(result.get(0).trim(), "");
        } else {
            return new Pair<>(
                    String.join("\n", result.subList(0, result.size() - 1)).trim(),
                    result.get(result.size() - 1).trim());
        }
    }

    private EvaluationResult eval(String msg) {
        msg.codePoints().forEach(cin::add);
        Pair<String, String> s = untilPrompt();
        boolean successful = s.snd().matches("^Type: .*$");
        String text, type;
        if (successful) {
            text = s.fst().replaceFirst("[ \t]+\\([0-9]+\\)[ \t]+", "").trim();
            type = s.snd().replaceFirst("Type: ", "");
        } else {
            if (!s.snd().isEmpty())
                text = s.fst() + "\n" + s.snd();
            else
                text = s.fst();
            type = "";
        }
        return new EvaluationResult(successful, text, type);
    }
}
