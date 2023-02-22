package palaiologos.kamilalisp.runtime.IO.streams;

import com.google.common.primitives.Longs;
import org.apache.commons.codec.digest.PureJavaCrc32;
import org.apache.commons.codec.digest.XXHash32;

import java.security.MessageDigest;

public class Xxh32DigestIOStreams {
    private final static String CODEC = "xxh32";

    public static class Output extends AbstractDigestOutputStream {
        @Override
        protected String name() {
            return "io:" + CODEC + "-output-stream";
        }

        @Override
        MessageDigest getDigest() {
            XXHash32 cksum = new XXHash32();
            return new MessageDigest("xxh32") {
                @Override
                protected void engineUpdate(byte input) {
                    cksum.update(input);
                }

                @Override
                protected void engineUpdate(byte[] input, int offset, int len) {
                    cksum.update(input, offset, len);
                }

                @Override
                protected byte[] engineDigest() {
                    return Longs.toByteArray(cksum.getValue());
                }

                @Override
                protected void engineReset() {
                    cksum.reset();
                }
            };
        }
    }

    public static class Input extends AbstractDigestInputStream {
        @Override
        protected String name() {
            return "io:" + CODEC + "-input-stream";
        }

        @Override
        MessageDigest getDigest() {
            XXHash32 cksum = new XXHash32();
            return new MessageDigest("xxh32") {
                @Override
                protected void engineUpdate(byte input) {
                    cksum.update(input);
                }

                @Override
                protected void engineUpdate(byte[] input, int offset, int len) {
                    cksum.update(input, offset, len);
                }

                @Override
                protected byte[] engineDigest() {
                    return Longs.toByteArray(cksum.getValue());
                }

                @Override
                protected void engineReset() {
                    cksum.reset();
                }
            };
        }
    }
}
