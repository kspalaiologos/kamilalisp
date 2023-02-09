package palaiologos.kamilalisp.runtime.dataformat.archive;

import org.apache.commons.compress.archivers.zip.ZipArchiveEntry;
import org.apache.commons.compress.archivers.zip.ZipFile;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Userdata;
import palaiologos.kamilalisp.runtime.dataformat.BufferAtomList;
import palaiologos.kamilalisp.runtime.datetime.DateTime;

import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;

public record ZipEntry(ZipArchiveEntry entry, ZipFile file) implements Userdata {
    @Override
    public Atom field(Object key) {
        if (!(key instanceof String))
            throw new IllegalArgumentException("Key must be a string");
        return switch ((String) key) {
            case "name" -> new Atom(entry.getName());
            case "size" -> new Atom(BigDecimal.valueOf(entry.getSize()));
            case "compressed-size" -> new Atom(BigDecimal.valueOf(entry.getCompressedSize()));
            case "crc" -> new Atom(BigDecimal.valueOf(entry.getCrc()));
            case "is-directory" -> new Atom(entry.isDirectory());
            case "comment" -> new Atom(entry.getComment() == null ? "" : entry.getComment());
            case "last-modified" -> new Atom(new DateTime(entry.getTimeLocal()));
            case "data" -> {
                try {
                    InputStream is = file.getInputStream(entry);
                    yield new Atom(BufferAtomList.from(is.readAllBytes()));
                } catch (IOException e) {
                    throw new RuntimeException(e);
                }
            }
            default -> throw new IllegalArgumentException("Unknown key: " + key);
        };
    }

    @Override
    public int hashCode() {
        return entry.hashCode();
    }

    @Override
    public int compareTo(Userdata other) {
        return hashCode() - other.hashCode();
    }

    @Override
    public boolean equals(Userdata other) {
        if (!(other instanceof ZipEntry otherEntry))
            return false;
        return otherEntry.entry.equals(entry);
    }

    @Override
    public String toDisplayString() {
        return "archive:zip:entry " + entry.getName();
    }

    @Override
    public String typeName() {
        return "archive:zip:entry";
    }

    @Override
    public boolean coerceBoolean() {
        return true;
    }
}
