package palaiologos.kamilalisp.runtime.dataformat.digest;

import org.apache.commons.codec.digest.DigestUtils;

public class Sha3256Digest extends DigestFunction {
    @Override
    protected String name() {
        return "digest:sha3256";
    }

    @Override
    String digest(String s) {
        return DigestUtils.sha3_256Hex(s);
    }

    @Override
    String digest(byte[] data) {
        return DigestUtils.sha3_256Hex(data);
    }
}
