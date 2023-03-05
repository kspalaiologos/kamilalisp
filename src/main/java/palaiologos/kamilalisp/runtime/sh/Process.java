package palaiologos.kamilalisp.runtime.sh;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.runtime.IO.streams.StreamWrapper;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.math.BigInteger;
import java.util.List;

public class Process extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.isEmpty())
            throw new IllegalArgumentException("sh:process requires at least one argument");
        try {
            var process = Runtime.getRuntime().exec(args.stream().map(Atom::getString).toArray(String[]::new));
            return new Atom(new ProcessUserdata(args.get(0).getString(), process));
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected String name() {
        return "sh:process";
    }

    private static class ProcessUserdata implements Userdata {
        private final java.lang.Process process;
        private final String processName;
        private final Atom stdout;
        private final Atom stdin;
        private final Atom stderr;

        private ProcessUserdata(String name, java.lang.Process process) {
            this.process = process;
            this.processName = name;
            this.stdout = new Atom(new StreamWrapper.InputStreamUserdata(new BufferedInputStream(process.getInputStream())) {
                @Override
                public String toDisplayString() {
                    return ProcessUserdata.this.toDisplayString() + ".stdin";
                }

                @Override
                public Atom specialField(Object key) {
                    throw new UnsupportedOperationException("sh:process.stdin does not support special fields");
                }
            });
            this.stdin = new Atom(new StreamWrapper.OutputStreamUserdata(new BufferedOutputStream(process.getOutputStream())) {
                @Override
                public String toDisplayString() {
                    return ProcessUserdata.this.toDisplayString() + ".stdout";
                }

                @Override
                public Atom specialField(Object key) {
                    throw new UnsupportedOperationException("sh:process.stdout does not support special fields");
                }
            });
            this.stderr = new Atom(new StreamWrapper.InputStreamUserdata(new BufferedInputStream(process.getErrorStream())) {
                @Override
                public String toDisplayString() {
                    return ProcessUserdata.this.toDisplayString() + ".stderr";
                }

                @Override
                public Atom specialField(Object key) {
                    throw new UnsupportedOperationException("sh:process.stderr does not support special fields");
                }
            });
        }

        @Override
        public Atom field(Object key) {
            if (!(key instanceof String))
                throw new IllegalArgumentException("sh:process field name must be a string");
            return switch ((String) key) {
                case "pid" -> new Atom(BigInteger.valueOf(process.pid()));
                case "is-alive?" -> process.isAlive() ? Atom.TRUE : Atom.FALSE;
                case "exit-value" -> new Atom(BigInteger.valueOf(process.exitValue()));
                case "kill" -> new Atom(new Kill());
                case "force-kill" -> new Atom(new ForceKill());
                case "stdout" -> stdout;
                case "stdin" -> stdin;
                case "stderr" -> stderr;
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

        private class ForceKill extends PrimitiveFunction implements SpecialForm, ReactiveFunction {
            @Override
            public Atom apply(Environment env, List<Atom> args) {
                process.destroyForcibly();
                return Atom.NULL;
            }

            @Override
            protected String name() {
                return "sh:process.force-kill";
            }
        }

        private class Kill extends PrimitiveFunction implements SpecialForm, ReactiveFunction {
            @Override
            public Atom apply(Environment env, List<Atom> args) {
                process.destroy();
                return Atom.NULL;
            }

            @Override
            protected String name() {
                return "sh:process.kill";
            }
        }
    }
}
