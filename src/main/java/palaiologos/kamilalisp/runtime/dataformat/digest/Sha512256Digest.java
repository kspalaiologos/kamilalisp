package palaiologos.kamilalisp.runtime.dataformat.digest;

import org.apache.commons.codec.digest.DigestUtils;

public class Sha512256Digest extends DigestFunction {
    @Override
    protected String name() {
        return "digest:sha512256";
    }

    @Override
    String digest(String s) {
        return DigestUtils.sha512_256Hex(s);
    }

    @Override
    String digest(byte[] data) {
        return DigestUtils.sha512_256Hex(data);
    }
}
