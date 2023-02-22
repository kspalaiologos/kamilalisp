package palaiologos.kamilalisp.runtime.dataformat.digest;

import org.apache.commons.codec.digest.DigestUtils;

public class Sha256Digest extends DigestFunction {
    @Override
    protected String name() {
        return "digest:sha256";
    }

    @Override
    String digest(String s) {
        return DigestUtils.sha256Hex(s);
    }

    @Override
    String digest(byte[] data) {
        return DigestUtils.sha256Hex(data);
    }
}
