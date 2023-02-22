package palaiologos.kamilalisp.runtime.IO.streams;

import org.apache.commons.codec.digest.DigestUtils;

import java.security.MessageDigest;

public class Sha1DigestIOStreams {
    private final static String CODEC = "sha1";
    private final static MessageDigest DIGEST = DigestUtils.getSha1Digest();

    public static class Output extends AbstractDigestOutputStream {
        @Override
        protected String name() {
            return "io:" + CODEC + "-output-stream";
        }

        @Override
        MessageDigest getDigest() {
            return DIGEST;
        }
    }

    public static class Input extends AbstractDigestInputStream {
        @Override
        protected String name() {
            return "io:" + CODEC + "-input-stream";
        }

        @Override
        MessageDigest getDigest() {
            return DIGEST;
        }
    }
}
