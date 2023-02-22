package palaiologos.kamilalisp.runtime.IO.streams;

import org.apache.commons.codec.digest.DigestUtils;

import java.security.MessageDigest;

public class Md5DigestIOStreams {
    private final static String CODEC = "md5";
    private final static MessageDigest DIGEST = DigestUtils.getMd5Digest();

    public class Output extends AbstractDigestOutputStream {
        @Override
        protected String name() {
            return "io:" + CODEC +"-output-stream";
        }

        @Override
        MessageDigest getDigest() {
            return DIGEST;
        }
    }

    public class Input extends AbstractDigestInputStream {
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
