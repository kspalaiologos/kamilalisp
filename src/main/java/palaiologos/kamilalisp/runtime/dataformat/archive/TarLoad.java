package palaiologos.kamilalisp.runtime.dataformat.archive;

import org.apache.commons.compress.archivers.tar.TarArchiveEntry;
import org.apache.commons.compress.archivers.tar.TarFile;
import palaiologos.kamilalisp.atom.*;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class TarLoad extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        if (args.get(0).getType() == Type.STRING) {
            String filename = args.get(0).getString();
            try {
                TarFile archive = new TarFile(new File(filename).getAbsoluteFile());
                return new Atom(new TarArchiveUserdata(archive));
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        } else {
            List<Atom> data = args.get(0).getList();
            try {
                TarFile archive = new TarFile(new SeekableKamilaLispByteChannel(data));
                return new Atom(new TarArchiveUserdata(archive));
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }
    }

    @Override
    protected String name() {
        return "archive:tar:load";
    }

    private record TarArchiveUserdata(TarFile archive) implements Userdata {
        @Override
        public Atom field(Object key) {
            if (key instanceof String) {
                switch ((String) key) {
                    case "entries" -> {
                        List<Atom> entries = new ArrayList<>();
                        for (TarArchiveEntry entry : archive.getEntries()) {
                            entries.add(new Atom(new TarEntry(entry, archive)));
                        }
                        return new Atom(entries);
                    }
                    case "entry" -> {
                        return new Atom(new EntryForName(archive));
                    }
                    default -> throw new RuntimeException("archive:tar - unknown key: " + key);
                }
            } else {
                throw new RuntimeException("archive:tar - key must be a string");
            }
        }

        @Override
        public int compareTo(Userdata other) {
            return other.hashCode() - hashCode();
        }

        @Override
        public boolean equals(Userdata other) {
            if (other instanceof TarArchiveUserdata) {
                TarArchiveUserdata otherTar = (TarArchiveUserdata) other;
                return otherTar.archive.equals(archive);
            } else {
                return false;
            }
        }

        @Override
        public String toDisplayString() {
            return "archive:tar";
        }

        @Override
        public String typeName() {
            return "archive:tar";
        }

        @Override
        public boolean coerceBoolean() {
            return true;
        }

        private static class EntryForName extends PrimitiveFunction implements Lambda {
            private final TarFile archive;

            public EntryForName(TarFile archive) {
                this.archive = archive;
            }

            @Override
            public Atom apply(Environment env, List<Atom> args) {
                assertArity(args, 1);
                String name = args.get(0).getString();
                TarArchiveEntry entry = archive.getEntries().stream().filter(e -> e.getName().equals(name)).findFirst().orElse(null);
                if (entry == null)
                    throw new RuntimeException("archive:tar.entry - no such entry: " + name);
                return new Atom(new TarEntry(entry, archive));
            }

            @Override
            protected String name() {
                return "archive:tar.entry";
            }
        }
    }
}
