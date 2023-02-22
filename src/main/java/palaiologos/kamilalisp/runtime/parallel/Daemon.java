package palaiologos.kamilalisp.runtime.parallel;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.InterruptionError;

import java.util.List;
import java.util.concurrent.atomic.AtomicBoolean;

public class Daemon extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        Callable code = args.get(0).getCallable();
        Environment childEnv = new Environment(env);
        AtomicBoolean stopped = new AtomicBoolean(false);
        DaemonThread task = new DaemonThread(code, env, stopped);
        Thread t = new Thread(task);
        t.setDaemon(true);
        childEnv.set("parallel:this-daemon:yield", new Atom(new DaemonAPIYield()));
        childEnv.set("parallel:this-daemon:stop", new Atom(new DaemonAPIStop(stopped)));
        t.start();
        return new Atom(new DaemonUserdata(t, task));
    }

    @Override
    protected String name() {
        return "parallel:daemon";
    }

    private static class DaemonAPIYield extends PrimitiveFunction implements Lambda {
        @Override
        public Atom apply(Environment env, List<Atom> args) {
            try {
                Thread.sleep(1);
            } catch (InterruptedException e) {
            }
            return Atom.NULL;
        }

        @Override
        protected String name() {
            return "parallel:this-daemon:yield";
        }
    }

    private static class DaemonAPIStop extends PrimitiveFunction implements Lambda {
        private final AtomicBoolean stopped;

        public DaemonAPIStop(AtomicBoolean stopped) {
            this.stopped = stopped;
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            stopped.set(true);
            return Atom.NULL;
        }

        @Override
        protected String name() {
            return "parallel:this-daemon:stop";
        }
    }

    private record DaemonThread(Callable code, Environment env, AtomicBoolean stopped) implements Runnable {
        @Override
        public void run() {
            while (!stopped().get()) {
                Evaluation.safeEvaluate(env, code, List.of(), s -> {
                    System.err.println(s);
                    throw new InterruptionError();
                });
            }
        }
    }

    private record DaemonUserdata(Thread t, DaemonThread task) implements Userdata {
        @Override
        public Atom field(Object key) {
            if (!(key instanceof String))
                throw new IllegalArgumentException("Key must be a string");
            switch ((String) key) {
                case "alive" -> {
                    return new Atom(t.isAlive());
                }
                case "stop" -> {
                    task.stopped().set(true);
                    return Atom.NULL;
                }
                default -> {
                    throw new IllegalArgumentException("Unknown key: " + key);
                }
            }
        }

        @Override
        public int compareTo(Userdata other) {
            return hashCode() - other.hashCode();
        }

        @Override
        public boolean equals(Userdata other) {
            if (other instanceof DaemonUserdata)
                return t.equals(((DaemonUserdata) other).t);
            return false;
        }

        @Override
        public String toString() {
            return "parallel:daemon";
        }

        @Override
        public String toDisplayString() {
            return "parallel:daemon";
        }

        @Override
        public String typeName() {
            return "parallel:daemon";
        }

        @Override
        public boolean coerceBoolean() {
            return t.isAlive();
        }
    }
}
