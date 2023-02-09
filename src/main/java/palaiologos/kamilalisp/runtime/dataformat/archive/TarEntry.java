package palaiologos.kamilalisp.runtime.dataformat.archive;

import org.apache.commons.compress.archivers.tar.TarArchiveEntry;
import org.apache.commons.compress.archivers.tar.TarFile;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Userdata;
import palaiologos.kamilalisp.runtime.dataformat.BufferAtomList;
import palaiologos.kamilalisp.runtime.datetime.DateTime;

import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.time.ZoneOffset;

public record TarEntry(TarArchiveEntry entry, TarFile file) implements Userdata {
    @Override
    public Atom field(Object key) {
        if (!(key instanceof String))
            throw new IllegalArgumentException("Key must be a string");
        return switch ((String) key) {
            case "name" -> new Atom(entry.getName());
            case "size" -> new Atom(BigDecimal.valueOf(entry.getSize()));
            case "is-directory" -> new Atom(entry.isDirectory());
            case "creation-time" ->
                    new Atom(new DateTime(entry.getCreationTime().toInstant().atZone(ZoneOffset.UTC).toLocalDateTime()));
            case "last-mod-time" ->
                    new Atom(new DateTime(entry.getLastModifiedTime().toInstant().atZone(ZoneOffset.UTC).toLocalDateTime()));
            case "last-access-time" ->
                    new Atom(new DateTime(entry.getLastAccessTime().toInstant().atZone(ZoneOffset.UTC).toLocalDateTime()));
            case "group-name" -> new Atom(entry.getGroupName());
            case "user-name" -> new Atom(entry.getUserName());
            case "mode" -> new Atom(BigInteger.valueOf(entry.getMode()));
            case "is-blkdev" -> new Atom(entry.isBlockDevice());
            case "is-chardev" -> new Atom(entry.isCharacterDevice());
            case "is-fifo" -> new Atom(entry.isFIFO());
            case "is-regular-file" -> new Atom(entry.isFile());
            case "is-symlink" -> new Atom(entry.isSymbolicLink());
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
        if (!(other instanceof TarEntry otherEntry))
            return false;
        return otherEntry.entry.equals(entry);
    }

    @Override
    public String toDisplayString() {
        return "archive:tar:entry " + entry.getName();
    }

    @Override
    public String typeName() {
        return "archive:tar:entry";
    }

    @Override
    public boolean coerceBoolean() {
        return true;
    }
}
