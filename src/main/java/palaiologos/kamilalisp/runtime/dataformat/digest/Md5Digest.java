package palaiologos.kamilalisp.runtime.dataformat.digest;

import org.apache.commons.codec.digest.DigestUtils;

public class Md5Digest extends DigestFunction {
    @Override
    protected String name() {
        return "digest:md5";
    }

    @Override
    String digest(String s) {
        return DigestUtils.md5Hex(s);
    }

    @Override
    String digest(byte[] data) {
        return DigestUtils.md5Hex(data);
    }
}
