package palaiologos.kamilalisp.runtime.parallel.actor;

import palaiologos.kamilalisp.atom.*;

import java.util.List;
import java.util.concurrent.LinkedBlockingQueue;

public class ActorUserData implements Userdata {
    private final LinkedBlockingQueue<Atom> mailbox = new LinkedBlockingQueue<>();

    @Override
    public Atom field(Object key) {
        if (!(key instanceof String name)) {
            throw new IllegalArgumentException("Actor field name must be a string");
        }

        return switch (name) {
            case "broadcast" -> new Atom(new Send());
            case "receive" -> new Atom(new Receive());
            case "receive!" -> new Atom(new ReceiveBang());
            case "empty?" -> mailbox.isEmpty() ? Atom.TRUE : Atom.FALSE;
            default -> throw new IllegalArgumentException("Unknown actor field: " + name);
        };
    }

    @Override
    public int hashCode() {
        return mailbox.hashCode();
    }

    @Override
    public int compareTo(Userdata other) {
        return hashCode() - other.hashCode();
    }

    @Override
    public boolean equals(Userdata other) {
        if (other instanceof ActorUserData) {
            return mailbox.equals(((ActorUserData) other).mailbox);
        }
        return false;
    }

    @Override
    public String toString() {
        return "parallel:actor";
    }

    @Override
    public String toDisplayString() {
        return "parallel:actor";
    }

    @Override
    public String typeName() {
        return "parallel:actor";
    }

    @Override
    public boolean coerceBoolean() {
        return mailbox.isEmpty();
    }

    private class Send extends PrimitiveFunction implements Lambda {
        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() != 1) {
                throw new IllegalArgumentException("actor.send takes exactly 1 argument");
            }

            Atom message = args.get(0);
            mailbox.add(message);

            return Atom.NULL;
        }

        @Override
        protected String name() {
            return "parallel:actor.send";
        }
    }

    private class Receive extends PrimitiveFunction implements SpecialForm, ReactiveFunction {
        @Override
        public Atom apply(Environment env, List<Atom> args) {
            Atom message = mailbox.poll();
            if (message == null) {
                return Atom.NULL;
            }

            return message;
        }

        @Override
        protected String name() {
            return "parallel:actor.receive";
        }
    }

    private class ReceiveBang extends PrimitiveFunction implements SpecialForm, ReactiveFunction {
        @Override
        public Atom apply(Environment env, List<Atom> args) {
            try {
                return mailbox.take();
            } catch (InterruptedException e) {
                return Atom.NULL;
            }
        }

        @Override
        protected String name() {
            return "parallel:actor.receive!";
        }
    }
}
