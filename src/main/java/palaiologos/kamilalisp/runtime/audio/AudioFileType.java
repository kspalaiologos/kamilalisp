package palaiologos.kamilalisp.runtime.audio;

import javazoom.spi.mpeg.sampled.file.MpegAudioFileReader;
import org.pcollections.HashPMap;
import org.pcollections.HashTreePMap;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.runtime.hashmap.HashMapUserData;

import javax.sound.sampled.*;
import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AudioFileType extends PrimitiveFunction implements Lambda {
    private static Atom atomOf(Object o) {
        if(o instanceof String)
            return new Atom((String) o);
        else if(o instanceof Integer)
            return new Atom(BigInteger.valueOf((Integer) o));
        else if(o instanceof Long)
            return new Atom(BigInteger.valueOf((Long) o));
        else if(o instanceof Float)
            return new Atom(BigDecimal.valueOf((Float) o));
        else if(o instanceof Double)
            return new Atom(BigDecimal.valueOf((Double) o));
        else if(o instanceof Boolean)
            return new Atom((Boolean) o);
        else
            throw new IllegalArgumentException("Unsupported type: " + o.getClass());
    }

    @SuppressWarnings("unchecked")
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        try {
            File input = new File(args.get(0).getString()).getAbsoluteFile();
            AudioFileFormat format = AudioSystem.getAudioFileFormat(input);
            HashPMap<Atom, Atom> map = HashTreePMap.from(
                    Map.ofEntries(format.properties().entrySet().stream()
                            .filter(e -> e.getValue() instanceof String || e.getValue() instanceof Double || e.getValue() instanceof Float || e.getValue() instanceof Long || e.getValue() instanceof Boolean)
                            .map(e -> Map.entry(new Atom(e.getKey()), atomOf(e.getValue()))).toArray(Map.Entry[]::new)));
            map.plusAll(Map.of(
                    new Atom("samplerate"), atomOf(format.getFormat().getSampleRate()),
                    new Atom("channels"), atomOf(format.getFormat().getChannels()),
                    new Atom("endian"), new Atom(format.getFormat().isBigEndian() ? "big" : "little"),
                    new Atom("encoding"), new Atom(format.getFormat().getEncoding().toString())
            ));
            return new Atom(new HashMapUserData(map));
        } catch (UnsupportedAudioFileException | IOException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected String name() {
        return "audio:file-type";
    }
}
