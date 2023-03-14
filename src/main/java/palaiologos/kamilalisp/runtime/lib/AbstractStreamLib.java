package palaiologos.kamilalisp.runtime.lib;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.runtime.IO.*;
import palaiologos.kamilalisp.runtime.IO.streams.*;

public class AbstractStreamLib {
    public static void register(Environment env) {
        env.setPrimitive("io:histogram-istream", new Atom(new HistogramInputStream()));
        env.setPrimitive("io:histogram-ostream", new Atom(new HistogramOutputStream()));
        env.setPrimitive("io:byte-buffer-istream", new Atom(new ByteBufferInputStream()));
        env.setPrimitive("io:byte-buffer-ostream", new Atom(new ByteBufferOutputStream()));
        env.setPrimitive("io:gzip-istream", new Atom(new GzipInputStream()));
        env.setPrimitive("io:gzip-ostream", new Atom(new GzipOutputStream()));
        env.setPrimitive("io:bzip2-istream", new Atom(new Bzip2InputStream()));
        env.setPrimitive("io:bzip2-ostream", new Atom(new Bzip2OutputStream()));
        env.setPrimitive("io:lz4-istream", new Atom(new Lz4InputStream()));
        env.setPrimitive("io:lz4-ostream", new Atom(new Lz4OutputStream()));
        env.setPrimitive("io:xz-istream", new Atom(new XzInputStream()));
        env.setPrimitive("io:xz-ostream", new Atom(new XzOutputStream()));
        env.setPrimitive("io:input-stream-of", new Atom(new InputStreamOf()));
        env.setPrimitive("io:output-stream-of", new Atom(new OutputStreamOf()));
        env.setPrimitive("io:tee-ostream", new Atom(new TeeOutputStream()));
        env.setPrimitive("io:null-istream", new Atom(new NullInputStream()));
        env.setPrimitive("io:null-ostream", new Atom(new NullOutputStream()));
        env.setPrimitive("io:md5-istream", new Atom(new Md5DigestIOStreams.Input()));
        env.setPrimitive("io:md5-ostream", new Atom(new Md5DigestIOStreams.Output()));
        env.setPrimitive("io:md2-istream", new Atom(new Md2DigestIOStreams.Input()));
        env.setPrimitive("io:md2-ostream", new Atom(new Md2DigestIOStreams.Output()));
        env.setPrimitive("io:adler32-istream", new Atom(new Adler32DigestIOStreams.Input()));
        env.setPrimitive("io:adler32-ostream", new Atom(new Adler32DigestIOStreams.Output()));
        env.setPrimitive("io:crc32-ostream", new Atom(new CRC32DigestIOStreams.Output()));
        env.setPrimitive("io:crc32-istream", new Atom(new CRC32DigestIOStreams.Input()));
        env.setPrimitive("io:crc32c-ostream", new Atom(new CRC32CDigestIOStreams.Output()));
        env.setPrimitive("io:crc32c-istream", new Atom(new CRC32CDigestIOStreams.Input()));
        env.setPrimitive("io:sha1-istream", new Atom(new Sha1DigestIOStreams.Input()));
        env.setPrimitive("io:sha1-ostream", new Atom(new Sha1DigestIOStreams.Output()));
        env.setPrimitive("io:xxh32-istream", new Atom(new Xxh32DigestIOStreams.Input()));
        env.setPrimitive("io:xxh32-ostream", new Atom(new Xxh32DigestIOStreams.Output()));
        env.setPrimitive("io:encode-le-u16", new Atom(new EncodeLE16()));
        env.setPrimitive("io:encode-be-u16", new Atom(new EncodeBE16()));
        env.setPrimitive("io:encode-le-u32", new Atom(new EncodeLE32()));
        env.setPrimitive("io:encode-be-u32", new Atom(new EncodeBE32()));
        env.setPrimitive("io:encode-le-u64", new Atom(new EncodeLE64()));
        env.setPrimitive("io:encode-be-u64", new Atom(new EncodeBE64()));
        env.setPrimitive("io:encode-le-s16", new Atom(new EncodeLES16()));
        env.setPrimitive("io:encode-be-s16", new Atom(new EncodeBES16()));
        env.setPrimitive("io:encode-le-s32", new Atom(new EncodeLES32()));
        env.setPrimitive("io:encode-be-s32", new Atom(new EncodeBES32()));
        env.setPrimitive("io:encode-le-s64", new Atom(new EncodeLES64()));
        env.setPrimitive("io:encode-be-s64", new Atom(new EncodeBES64()));
        env.setPrimitive("io:decode-le", new Atom(new DecodeLE()));
        env.setPrimitive("io:decode-be", new Atom(new DecodeBE()));
    }
}
