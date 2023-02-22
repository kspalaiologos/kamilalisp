package palaiologos.kamilalisp.runtime.IO.streams;

import com.google.common.primitives.Longs;

import java.security.MessageDigest;
import java.util.zip.Adler32;

public class Adler32DigestIOStreams {
    private final static String CODEC = "adler32";

    public static class Output extends AbstractDigestOutputStream {
        @Override
        protected String name() {
            return "io:" + CODEC + "-ostream";
        }

        @Override
        MessageDigest getDigest() {
            Adler32 adler32 = new Adler32();
            return new MessageDigest("adler32") {
                @Override
                protected void engineUpdate(byte input) {
                    adler32.update(input);
                }

                @Override
                protected void engineUpdate(byte[] input, int offset, int len) {
                    adler32.update(input, offset, len);
                }

                @Override
                protected byte[] engineDigest() {
                    return Longs.toByteArray(adler32.getValue());
                }

                @Override
                protected void engineReset() {
                    adler32.reset();
                }
            };
        }
    }

    public static class Input extends AbstractDigestInputStream {
        @Override
        protected String name() {
            return "io:" + CODEC + "-istream";
        }

        @Override
        MessageDigest getDigest() {
            Adler32 adler32 = new Adler32();
            return new MessageDigest("adler32") {
                @Override
                protected void engineUpdate(byte input) {
                    adler32.update(input);
                }

                @Override
                protected void engineUpdate(byte[] input, int offset, int len) {
                    adler32.update(input, offset, len);
                }

                @Override
                protected byte[] engineDigest() {
                    return Longs.toByteArray(adler32.getValue());
                }

                @Override
                protected void engineReset() {
                    adler32.reset();
                }
            };
        }
    }
}
