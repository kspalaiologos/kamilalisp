package palaiologos.kamilalisp.runtime.dataformat.digest;

import org.apache.commons.codec.digest.PureJavaCrc32;

public class CRC32Digest extends DigestFunction {
    @Override
    protected String name() {
        return "digest:crc32";
    }

    @Override
    String digest(String s) {
        PureJavaCrc32 hash = new PureJavaCrc32();
        hash.update(s.getBytes());
        return Long.toHexString(hash.getValue());
    }

    @Override
    String digest(byte[] data) {
        PureJavaCrc32 hash = new PureJavaCrc32();
        hash.update(data);
        return Long.toHexString(hash.getValue());
    }
}
