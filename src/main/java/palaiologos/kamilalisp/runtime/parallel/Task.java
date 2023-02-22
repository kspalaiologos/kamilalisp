package palaiologos.kamilalisp.runtime.parallel;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.InterruptionError;

import java.util.List;

public class Task extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        Callable code = args.get(0).getCallable();
        TaskThread task = new TaskThread(code, env);
        Thread t = new Thread(task);
        t.setDaemon(false);
        t.start();
        return new Atom(new TaskUserdata(t, task));
    }

    @Override
    protected String name() {
        return "parallel:task";
    }

    private static class TaskThread implements Runnable {
        private final Callable code;
        private final Environment env;
        private Atom result;

        public TaskThread(Callable code, Environment env) {
            this.code = code;
            this.env = env;
            this.result = Atom.NULL;
        }

        @Override
        public void run() {
            result = Evaluation.safeEvaluate(env, code, List.of(), s -> {
                System.err.println(s);
                throw new InterruptionError();
            });
        }

        public Atom getResult() {
            return result;
        }
    }

    private static class ParallelTaskJoin extends PrimitiveFunction implements Lambda {
        private final Thread t;
        private final TaskThread task;

        public ParallelTaskJoin(Thread t, TaskThread task) {
            this.t = t;
            this.task = task;
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 0);
            try {
                t.join();
            } catch (InterruptedException e) {
                throw new InterruptionError();
            }
            return task.getResult();
        }

        @Override
        protected String name() {
            return "parallel:task.join";
        }
    }

    private record TaskUserdata(Thread t, TaskThread task) implements Userdata {
        @Override
        public Atom field(Object key) {
            if (!(key instanceof String))
                throw new IllegalArgumentException("Key must be a string");
            switch ((String) key) {
                case "alive" -> {
                    return new Atom(t.isAlive());
                }
                case "join" -> {
                    return new Atom(new ParallelTaskJoin(t, task));
                }
                case "result" -> {
                    return task.getResult();
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
            if (other instanceof TaskUserdata)
                return t.equals(((TaskUserdata) other).t);
            return false;
        }

        @Override
        public String toString() {
            return "parallel:task";
        }

        @Override
        public String toDisplayString() {
            return "parallel:task";
        }

        @Override
        public String typeName() {
            return "parallel:task";
        }

        @Override
        public boolean coerceBoolean() {
            return t.isAlive();
        }
    }
}
