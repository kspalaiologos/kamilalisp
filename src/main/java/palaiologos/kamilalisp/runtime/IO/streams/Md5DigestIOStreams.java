package palaiologos.kamilalisp.runtime.IO.streams;

import org.apache.commons.codec.digest.DigestUtils;

import java.security.MessageDigest;

public class Md5DigestIOStreams {
    private final static String CODEC = "md5";
    private final static MessageDigest DIGEST = DigestUtils.getMd5Digest();

    public static class Output extends AbstractDigestOutputStream {
        @Override
        protected String name() {
            return "io:" + CODEC + "-ostream";
        }

        @Override
        MessageDigest getDigest() {
            return DIGEST;
        }
    }

    public static class Input extends AbstractDigestInputStream {
        @Override
        protected String name() {
            return "io:" + CODEC + "-istream";
        }

        @Override
        MessageDigest getDigest() {
            return DIGEST;
        }
    }
}
