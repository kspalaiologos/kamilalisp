package palaiologos.kamilalisp.runtime.IO.streams;

import com.google.common.primitives.Longs;
import org.apache.commons.codec.digest.PureJavaCrc32;
import org.apache.commons.codec.digest.PureJavaCrc32C;

import java.security.MessageDigest;

public class CRC32CDigestIOStreams {
    private final static String CODEC = "crc32c";

    public static class Output extends AbstractDigestOutputStream {
        @Override
        protected String name() {
            return "io:" + CODEC +"-output-stream";
        }

        @Override
        MessageDigest getDigest() {
            PureJavaCrc32C cksum = new PureJavaCrc32C();
            return new MessageDigest("crc32c") {
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
            PureJavaCrc32C cksum = new PureJavaCrc32C();
            return new MessageDigest("crc32c") {
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
