package palaiologos.kamilalisp.runtime.dataformat.digest;

import org.apache.commons.codec.digest.XXHash32;

public class XXHash32Digest extends DigestFunction {
    @Override
    protected String name() {
        return "digest:xxh32";
    }

    @Override
    String digest(String s) {
        XXHash32 xxHash32 = new XXHash32();
        xxHash32.update(s.getBytes());
        return Long.toHexString(xxHash32.getValue());
    }

    @Override
    String digest(byte[] data) {
        XXHash32 xxHash32 = new XXHash32();
        xxHash32.update(data);
        return Long.toHexString(xxHash32.getValue());
    }
}
