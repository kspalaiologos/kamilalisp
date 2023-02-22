package palaiologos.kamilalisp.runtime.dataformat.digest;

import org.apache.commons.codec.digest.DigestUtils;

public class Sha1Digest extends DigestFunction {
    @Override
    protected String name() {
        return "digest:sha1";
    }

    @Override
    String digest(String s) {
        return DigestUtils.sha1Hex(s);
    }

    @Override
    String digest(byte[] data) {
        return DigestUtils.sha1Hex(data);
    }
}
