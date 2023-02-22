package palaiologos.kamilalisp.runtime.IO.streams;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.runtime.hashmap.HashMapUserData;

import java.io.IOException;
import java.io.InputStream;
import java.math.BigInteger;
import java.util.List;
import java.util.Map;

public class InputStreamOf extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        Map<Atom, Atom> data = args.get(0).getUserdata(HashMapUserData.class).value();
        Atom available = data.getOrDefault(new Atom("available"), Atom.NULL);
        Atom read = data.getOrDefault(new Atom("read"), Atom.NULL);
        Atom skip = data.getOrDefault(new Atom("skip"), Atom.NULL);
        Atom readN = data.getOrDefault(new Atom("read-n"), Atom.NULL);
        Atom skipN = data.getOrDefault(new Atom("skip-n"), Atom.NULL);
        Atom readAll = data.getOrDefault(new Atom("read-all"), Atom.NULL);
        Atom readByte = data.getOrDefault(new Atom("read-byte"), Atom.NULL);
        Atom skipByte = data.getOrDefault(new Atom("skip-byte"), Atom.NULL);
        Atom close = data.getOrDefault(new Atom("close"), Atom.NULL);
        Atom toString = data.getOrDefault(new Atom("to-string"), Atom.NULL);

        if (readByte.equals(Atom.NULL))
            throw new RuntimeException("io:input-stream-of - read-byte must be defined.");
        InputStream is = new InputStream() {
            @Override
            public int read() {
                return Evaluation.evaluate(env, readByte.getCallable(), List.of()).getInteger().intValue();
            }

            @Override
            public int available() throws IOException {
                if (available.equals(Atom.NULL))
                    return super.available();
                return Evaluation.evaluate(env, available.getCallable(), List.of()).getInteger().intValue();
            }

            @Override
            public int read(byte[] bytes) throws IOException {
                return read(bytes, 0, bytes.length);
            }

            @Override
            public int read(byte[] bytes, int off, int len) throws IOException {
                if (read.equals(Atom.NULL))
                    return super.read(bytes, off, len);
                List<Atom> result = Evaluation.evaluate(env, read.getCallable(), List.of(new Atom(BigInteger.valueOf(len)))).getList();
                int first = result.get(0).getInteger().intValue();
                List<Atom> second = result.get(1).getList();
                for (int i = 0; i < second.size(); i++) {
                    bytes[off + i] = second.get(i).getInteger().byteValue();
                }
                return first;
            }

            @Override
            public long skip(long l) throws IOException {
                if (skip.equals(Atom.NULL))
                    return super.skip(l);
                if (l == 1) {
                    return Evaluation.evaluate(env, skipByte.getCallable(), List.of()).getInteger().longValue();
                } else {
                    return Evaluation.evaluate(env, skip.getCallable(), List.of(new Atom(BigInteger.valueOf(l)))).getInteger().longValue();
                }
            }

            @Override
            public void skipNBytes(long n) throws IOException {
                if (skipN.equals(Atom.NULL))
                    super.skipNBytes(n);
                Evaluation.evaluate(env, skipN.getCallable(), List.of(new Atom(BigInteger.valueOf(n))));
            }

            @Override
            public byte[] readAllBytes() throws IOException {
                if (readAll.equals(Atom.NULL))
                    return super.readAllBytes();
                List<Atom> result = Evaluation.evaluate(env, readAll.getCallable(), List.of()).getList();
                byte[] bytes = new byte[result.size()];
                for (int i = 0; i < bytes.length; i++) {
                    bytes[i] = result.get(i).getInteger().byteValue();
                }
                return bytes;
            }

            @Override
            public byte[] readNBytes(int len) throws IOException {
                byte[] bytes = new byte[len];
                int read = readNBytes(bytes, 0, len);
                return bytes;
            }

            @Override
            public int readNBytes(byte[] b, int off, int len) throws IOException {
                if (readN.equals(Atom.NULL))
                    return super.readNBytes(b, off, len);
                List<Atom> result = Evaluation.evaluate(env, readN.getCallable(), List.of(new Atom(BigInteger.valueOf(len)))).getList();
                byte[] bytes = new byte[result.size()];
                for (int i = 0; i < bytes.length; i++) {
                    bytes[i] = result.get(i).getInteger().byteValue();
                }
                System.arraycopy(bytes, 0, b, off, bytes.length);
                return bytes.length;
            }

            @Override
            public void close() throws IOException {
                if (close.equals(Atom.NULL)) {
                    super.close();
                } else {
                    Evaluation.evaluate(env, close.getCallable(), List.of());
                }
            }
        };
        return new Atom(new StreamWrapper.InputStreamUserdata(is) {
            @Override
            public String toDisplayString() {
                return Evaluation.evaluate(env, toString.getCallable(), List.of()).getString();
            }

            @Override
            public Atom specialField(Object key) {
                throw new RuntimeException("io:input-stream-of - special field not supported.");
            }
        });
    }

    @Override
    protected String name() {
        return "io:input-stream-of";
    }
}
