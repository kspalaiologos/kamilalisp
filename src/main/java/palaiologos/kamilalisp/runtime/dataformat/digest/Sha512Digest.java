package palaiologos.kamilalisp.runtime.dataformat.digest;

import org.apache.commons.codec.digest.DigestUtils;

public class Sha512Digest extends DigestFunction {
    @Override
    protected String name() {
        return "digest:sha512";
    }

    @Override
    String digest(String s) {
        return DigestUtils.sha512Hex(s);
    }

    @Override
    String digest(byte[] data) {
        return DigestUtils.sha512Hex(data);
    }
}
