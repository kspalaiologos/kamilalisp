package palaiologos.kamilalisp.runtime.dataformat.digest;

import org.apache.commons.codec.digest.PureJavaCrc32C;

public class CRC32CDigest extends DigestFunction {
    @Override
    protected String name() {
        return "digest:crc32c";
    }

    @Override
    String digest(String s) {
        PureJavaCrc32C hash = new PureJavaCrc32C();
        hash.update(s.getBytes());
        return Long.toHexString(hash.getValue());
    }

    @Override
    String digest(byte[] data) {
        PureJavaCrc32C hash = new PureJavaCrc32C();
        hash.update(data);
        return Long.toHexString(hash.getValue());
    }
}
