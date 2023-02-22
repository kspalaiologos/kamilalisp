package palaiologos.kamilalisp.runtime.sh;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.runtime.IO.streams.StreamWrapper;

import java.math.BigInteger;
import java.util.List;

public class Process extends PrimitiveFunction implements Lambda {
    private static class ProcessUserdata implements Userdata {
        private final java.lang.Process process;
        private final String processName;

        private ProcessUserdata(String name, java.lang.Process process) {
            this.process = process;
            this.processName = name;
        }

        @Override
        public Atom field(Object key) {
            if(!(key instanceof String))
                throw new IllegalArgumentException("sh:process field name must be a string");
            return switch ((String) key) {
                case "pid" -> new Atom(BigInteger.valueOf(process.pid()));
                case "is-alive?" -> process.isAlive() ? Atom.TRUE : Atom.FALSE;
                case "exit-value" -> new Atom(BigInteger.valueOf(process.exitValue()));
                case "kill" -> {
                    process.destroy();
                    yield Atom.NULL;
                }
                case "force-kill" -> {
                    process.destroyForcibly();
                    yield Atom.NULL;
                }
                case "stdout" ->
                    new Atom(new StreamWrapper.InputStreamUserdata(process.getInputStream()) {
                        @Override
                        public String toDisplayString() {
                            return ProcessUserdata.this.toDisplayString() + ".stdin";
                        }

                        @Override
                        public Atom specialField(Object key) {
                            throw new UnsupportedOperationException("sh:process.stdin does not support special fields");
                        }
                    });
                case "stdin" ->
                    new Atom(new StreamWrapper.OutputStreamUserdata(process.getOutputStream()) {
                        @Override
                        public String toDisplayString() {
                            return ProcessUserdata.this.toDisplayString() + ".stdout";
                        }

                        @Override
                        public Atom specialField(Object key) {
                            throw new UnsupportedOperationException("sh:process.stdout does not support special fields");
                        }
                    });
                case "stderr" ->
                    new Atom(new StreamWrapper.InputStreamUserdata(process.getErrorStream()) {
                        @Override
                        public String toDisplayString() {
                            return ProcessUserdata.this.toDisplayString() + ".stderr";
                        }

                        @Override
                        public Atom specialField(Object key) {
                            throw new UnsupportedOperationException("sh:process.stderr does not support special fields");
                        }
                    });
                default -> throw new IllegalArgumentException("sh:process does not have a field named " + key);
            };
        }

        @Override
        public int hashCode() {
            return process.hashCode();
        }

        @Override
        public int compareTo(Userdata other) {
            return hashCode() - other.hashCode();
        }

        @Override
        public boolean equals(Userdata other) {
            return other instanceof ProcessUserdata && process.equals(((ProcessUserdata) other).process);
        }

        @Override
        public String toString() {
            return "sh:process(" + processName + ")";
        }

        @Override
        public String toDisplayString() {
            return "sh:process(" + processName + ")";
        }

        @Override
        public String typeName() {
            return "sh:process";
        }

        @Override
        public boolean coerceBoolean() {
            return process.isAlive();
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.isEmpty())
            throw new IllegalArgumentException("sh:process requires at least one argument");
        ProcessBuilder builder = new ProcessBuilder(args.stream().map(Atom::getString).toList());
        try {
            var process = builder.start();
            return new Atom(new ProcessUserdata(args.get(0).getString(), process));
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected String name() {
        return "sh:process";
    }
}
