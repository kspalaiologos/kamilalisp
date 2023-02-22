package palaiologos.kamilalisp.runtime.IO.streams;

import org.apache.commons.codec.binary.Hex;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.security.DigestInputStream;
import java.security.MessageDigest;
import java.util.List;

public abstract class AbstractDigestInputStream extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        StreamWrapper.InputStreamUserdata owner = args.get(0).getUserdata(StreamWrapper.InputStreamUserdata.class);
        return new Atom(new StreamWrapper.InputStreamUserdata(new DigestInputStream(owner.stream, getDigest())) {
            @Override
            public String toDisplayString() {
                return name() + "#" + owner.toDisplayString();
            }

            @Override
            public Atom specialField(Object key) {
                if(key.equals("digest")) {
                    byte[] digest = ((DigestInputStream) stream).getMessageDigest().digest();
                    return new Atom(Hex.encodeHexString(digest));
                } else {
                    throw new RuntimeException(name() + ": unknown special field: " + key);
                }
            }
        });
    }

    abstract MessageDigest getDigest();
}
