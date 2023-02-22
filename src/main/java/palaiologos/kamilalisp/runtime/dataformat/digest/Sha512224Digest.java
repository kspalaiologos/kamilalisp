package palaiologos.kamilalisp.runtime.dataformat.digest;

import org.apache.commons.codec.digest.DigestUtils;

public class Sha512224Digest extends DigestFunction {
    @Override
    protected String name() {
        return "digest:sha512224";
    }

    @Override
    String digest(String s) {
        return DigestUtils.sha512_224Hex(s);
    }

    @Override
    String digest(byte[] data) {
        return DigestUtils.sha512_224Hex(data);
    }
}
