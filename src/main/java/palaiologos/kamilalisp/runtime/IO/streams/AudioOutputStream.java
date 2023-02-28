package palaiologos.kamilalisp.runtime.IO.streams;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import javax.sound.sampled.AudioFormat;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.DataLine;
import javax.sound.sampled.SourceDataLine;
import java.io.OutputStream;
import java.util.List;

public class AudioOutputStream extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        boolean isSigned = switch(args.get(0).getIdentifier()) {
            case "signed" -> true;
            case "unsigned" -> false;
            default -> throw new RuntimeException("Unknown audio format " + args.get(0).getIdentifier());
        };
        int sampleRate = args.get(1).getInteger().intValueExact();
        int sampleSize = args.get(2).getInteger().intValueExact();
        int channels = args.get(3).getInteger().intValueExact();

        try {
            AudioFormat af = new AudioFormat((float) sampleRate, sampleSize, channels, isSigned, false);
            DataLine.Info info = new DataLine.Info(SourceDataLine.class, af);
            SourceDataLine line = (SourceDataLine) AudioSystem.getLine(info);
            line.open(af, 4096);
            line.start();
            return new Atom(new StreamWrapper.OutputStreamUserdata(new OutputStream() {
                @Override
                public void write(int b) {
                    line.write(new byte[]{(byte) b}, 0, 1);
                }

                @Override
                public void write(byte[] b) {
                    line.write(b, 0, b.length);
                }

                public void write(byte[] b, int off, int len) {
                    line.write(b, off, len);
                }

                @Override
                public void close() {
                    line.drain();
                    line.stop();
                    line.close();
                }
            }) {
                @Override
                public String toDisplayString() {
                    return "io:audio-ostream";
                }

                @Override
                public Atom specialField(Object key) {
                    throw new RuntimeException("io:audio-ostream does not have a special field " + key);
                }
            });
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected String name() {
        return "io:audio-ostream";
    }
}
