package palaiologos.kamilalisp.runtime.dataformat.digest;

import java.util.zip.Adler32;

public class Adler32Digest extends DigestFunction {
    @Override
    protected String name() {
        return "digest:adler32";
    }

    @Override
    String digest(String s) {
        Adler32 hash = new Adler32();
        hash.update(s.getBytes());
        return Long.toHexString(hash.getValue());
    }

    @Override
    String digest(byte[] data) {
        Adler32 hash = new Adler32();
        hash.update(data);
        return Long.toHexString(hash.getValue());
    }
}
