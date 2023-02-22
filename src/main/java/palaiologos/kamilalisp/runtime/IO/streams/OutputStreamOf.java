package palaiologos.kamilalisp.runtime.IO.streams;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.runtime.dataformat.BufferAtomList;
import palaiologos.kamilalisp.runtime.hashmap.HashMapUserData;

import java.io.OutputStream;
import java.math.BigInteger;
import java.util.List;
import java.util.Map;

public class OutputStreamOf extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        Map<Atom, Atom> data = args.get(0).getUserdata(HashMapUserData.class).value();
        Atom write = data.getOrDefault(new Atom("write"), Atom.NULL);
        Atom close = data.getOrDefault(new Atom("close"), Atom.NULL);
        Atom flush = data.getOrDefault(new Atom("flush"), Atom.NULL);
        Atom toString = data.getOrDefault(new Atom("to-string"), Atom.NULL);
        if (write.equals(Atom.NULL))
            throw new RuntimeException("io:output-stream-of - write must be defined.");
        OutputStream os = new OutputStream() {
            @Override
            public void write(int b) {
                Evaluation.evaluate(env, write.getCallable(), List.of(new Atom(BigInteger.valueOf(b))));
            }

            @Override
            public void write(byte[] b) {
                Evaluation.evaluate(env, write.getCallable(), List.of(new Atom(BufferAtomList.from(b))));
            }

            @Override
            public void write(byte[] b, int off, int len) {
                Evaluation.evaluate(env, write.getCallable(), List.of(new Atom(BufferAtomList.from(b, off, len))));
            }

            @Override
            public void flush() {
                if (!flush.equals(Atom.NULL))
                    Evaluation.evaluate(env, flush.getCallable(), List.of());
            }

            @Override
            public void close() {
                if (!close.equals(Atom.NULL))
                    Evaluation.evaluate(env, close.getCallable(), List.of());
            }
        };
        return new Atom(new StreamWrapper.OutputStreamUserdata(os) {
            @Override
            public String toDisplayString() {
                return Evaluation.evaluate(env, toString.getCallable(), List.of()).getString();
            }

            @Override
            public Atom specialField(Object key) {
                throw new RuntimeException("io:output-stream-of - special field not supported.");
            }
        });
    }

    @Override
    protected String name() {
        return "io:output-stream-of";
    }
}
