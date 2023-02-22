package palaiologos.kamilalisp.runtime.dataformat.archive;

import org.apache.commons.compress.archivers.zip.ZipArchiveEntry;
import org.apache.commons.compress.archivers.zip.ZipFile;
import palaiologos.kamilalisp.atom.*;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class ZipLoad extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        if (args.get(0).getType() == Type.STRING) {
            String filename = args.get(0).getString();
            try {
                ZipFile archive = new ZipFile(new File(filename).getAbsoluteFile());
                return new Atom(new ZipArchiveUserdata(archive));
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        } else {
            List<Atom> data = args.get(0).getList();
            try {
                ZipFile archive = new ZipFile(new SeekableKamilaLispByteChannel(data));
                return new Atom(new ZipArchiveUserdata(archive));
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }
    }

    @Override
    protected String name() {
        return "archive:zip:load";
    }

    private record ZipArchiveUserdata(ZipFile archive) implements Userdata {
        @Override
        public Atom field(Object key) {
            if (key instanceof String) {
                switch ((String) key) {
                    case "entries" -> {
                        List<Atom> entries = new ArrayList<>();
                        for (Iterator<ZipArchiveEntry> it = archive.getEntries().asIterator(); it.hasNext(); ) {
                            ZipArchiveEntry entry = it.next();
                            entries.add(new Atom(new ZipEntry(entry, archive)));
                        }
                        return new Atom(entries);
                    }
                    case "entry" -> {
                        return new Atom(new EntryForName(archive));
                    }
                    default -> throw new RuntimeException("archive:zip - unknown key: " + key);
                }
            } else {
                throw new RuntimeException("archive:zip - key must be a string");
            }
        }

        @Override
        public int compareTo(Userdata other) {
            return other.hashCode() - hashCode();
        }

        @Override
        public boolean equals(Userdata other) {
            if (other instanceof ZipArchiveUserdata otherZip) {
                return otherZip.archive.equals(archive);
            } else {
                return false;
            }
        }

        @Override
        public String toDisplayString() {
            return "archive:zip";
        }

        @Override
        public String typeName() {
            return "archive:zip";
        }

        @Override
        public boolean coerceBoolean() {
            return true;
        }

        private static class EntryForName extends PrimitiveFunction implements Lambda {
            private final ZipFile archive;

            public EntryForName(ZipFile archive) {
                this.archive = archive;
            }

            @Override
            public Atom apply(Environment env, List<Atom> args) {
                assertArity(args, 1);
                String name = args.get(0).getString();
                ZipArchiveEntry entry = archive.getEntry(name);
                if (entry == null)
                    throw new RuntimeException("archive:zip.entry - no such entry: " + name);
                return new Atom(new ZipEntry(entry, archive));
            }

            @Override
            protected String name() {
                return "archive:zip.entry";
            }
        }
    }
}
