package palaiologos.kamilalisp.runtime.IO.streams;

import org.apache.commons.codec.binary.Hex;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.security.DigestInputStream;
import java.security.DigestOutputStream;
import java.security.MessageDigest;
import java.util.List;

public abstract class AbstractDigestOutputStream extends PrimitiveFunction implements Lambda {
    private class DigestEnabled extends PrimitiveFunction implements Lambda {
        private final DigestOutputStream stream;

        public DigestEnabled(DigestOutputStream stream) {
            this.stream = stream;
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 1);
            boolean enabled = args.get(0).coerceBool();
            stream.on(enabled);
            return Atom.NULL;
        }

        @Override
        protected String name() {
            return AbstractDigestOutputStream.this.name() + ".enabled";
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        StreamWrapper.OutputStreamUserdata owner = args.get(0).getUserdata(StreamWrapper.OutputStreamUserdata.class);
        return new Atom(new StreamWrapper.OutputStreamUserdata(new DigestOutputStream(owner.stream, getDigest())) {
            @Override
            public String toDisplayString() {
                return name() + "#" + owner.toDisplayString();
            }

            @Override
            public Atom specialField(Object key) {
                if(key.equals("digest")) {
                    byte[] digest = ((DigestOutputStream) stream).getMessageDigest().digest();
                    return new Atom(Hex.encodeHexString(digest));
                } else if(key.equals("enabled")) {
                    return new Atom(new DigestEnabled((DigestOutputStream) stream));
                } else {
                    throw new RuntimeException(name() + ": unknown special field: " + key);
                }
            }
        });
    }

    abstract MessageDigest getDigest();
}
