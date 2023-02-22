package palaiologos.kamilalisp.runtime.dataformat.digest;

import org.apache.commons.codec.digest.DigestUtils;

public class Md2Digest extends DigestFunction {
    @Override
    protected String name() {
        return "digest:md2";
    }

    @Override
    String digest(String s) {
        return DigestUtils.md2Hex(s);
    }

    @Override
    String digest(byte[] data) {
        return DigestUtils.md2Hex(data);
    }
}
