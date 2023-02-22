package palaiologos.kamilalisp.runtime.dataformat.digest;

import org.apache.commons.codec.digest.DigestUtils;

public class Sha384Digest extends DigestFunction {
    @Override
    protected String name() {
        return "digest:sha384";
    }

    @Override
    String digest(String s) {
        return DigestUtils.sha384Hex(s);
    }

    @Override
    String digest(byte[] data) {
        return DigestUtils.sha384Hex(data);
    }
}
