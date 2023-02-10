package palaiologos.kamilalisp.runtime.dataformat.archive;

import org.apache.commons.compress.archivers.ArchiveEntry;
import org.apache.commons.compress.archivers.tar.TarArchiveEntry;
import org.apache.commons.compress.archivers.tar.TarArchiveOutputStream;
import org.pcollections.HashPMap;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.runtime.dataformat.BufferAtomList;
import palaiologos.kamilalisp.runtime.datetime.DateTime;
import palaiologos.kamilalisp.runtime.hashmap.HashMapUserData;

import java.io.*;
import java.nio.file.attribute.FileTime;
import java.time.ZoneOffset;
import java.util.List;

public class TarCreate extends PrimitiveFunction implements ReactiveFunction, SpecialForm {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        TarArchiveOutputStream archive = new TarArchiveOutputStream(baos);
        return new Atom(new TarArchiveWriterUserdata(archive, baos));
    }

    @Override
    protected String name() {
        return "archive:tar:create";
    }

    private static class TarAddFromFile extends PrimitiveFunction implements Lambda {
        private final TarArchiveOutputStream zaos;

        public TarAddFromFile(TarArchiveOutputStream zaos) {
            this.zaos = zaos;
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 2);
            String filename = args.get(0).getString();
            String entryName = args.get(1).getString();
            File f = new File(filename).getAbsoluteFile();
            try {
                synchronized (zaos) {
                    ArchiveEntry e = zaos.createArchiveEntry(f, entryName);
                    zaos.putArchiveEntry(e);
                    FileInputStream fis = new FileInputStream(f);
                    fis.transferTo(zaos);
                    zaos.closeArchiveEntry();
                    zaos.flush();
                    fis.close();
                }
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
            return args.get(0);
        }

        @Override
        protected String name() {
            return "archive:tar:memory-writer.add-from-file";
        }
    }

    private static class TarAddFromBuffer extends PrimitiveFunction implements Lambda {
        private final TarArchiveOutputStream zaos;

        public TarAddFromBuffer(TarArchiveOutputStream zaos) {
            this.zaos = zaos;
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() < 2)
                throw new RuntimeException("archive:tar:memory-writer.add-from-buffer - expected at least 2 arguments, got " + args.size());
            List<Atom> buffer = args.get(0).getList();
            String entryName = args.get(1).getString();
            byte[] buf = new byte[buffer.size()];
            for (int i = 0; i < buffer.size(); i++) {
                buf[i] = buffer.get(i).getInteger().byteValueExact();
            }
            try {
                synchronized (zaos) {
                    ByteArrayInputStream bais = new ByteArrayInputStream(buf);
                    TarArchiveEntry e = new TarArchiveEntry(entryName);
                    if (args.size() == 3) {
                        HashPMap<Atom, Atom> data = args.get(2).getUserdata(HashMapUserData.class).value();
                        if (data.containsKey(new Atom("creation-time")))
                            e.setCreationTime(FileTime.from(data.get(new Atom("creation-time")).getUserdata(DateTime.class).value().toInstant(ZoneOffset.UTC)));
                        if (data.containsKey(new Atom("last-modified-time")))
                            e.setLastModifiedTime(FileTime.from(data.get(new Atom("last-modified-time")).getUserdata(DateTime.class).value().toInstant(ZoneOffset.UTC)));
                        if (data.containsKey(new Atom("last-access-time")))
                            e.setLastAccessTime(FileTime.from(data.get(new Atom("last-access-time")).getUserdata(DateTime.class).value().toInstant(ZoneOffset.UTC)));
                        if (data.containsKey(new Atom("mode")))
                            e.setMode(data.get(new Atom("mode")).getInteger().intValueExact());
                        if (data.containsKey(new Atom("user-name")))
                            e.setUserName(data.get(new Atom("user-name")).getString());
                        if (data.containsKey(new Atom("group-name")))
                            e.setGroupName(data.get(new Atom("group-name")).getString());
                    }
                    zaos.putArchiveEntry(e);
                    bais.transferTo(zaos);
                    zaos.closeArchiveEntry();
                    zaos.flush();
                    bais.close();
                }
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
            return args.get(0);
        }

        @Override
        protected String name() {
            return "archive:tar:memory-writer.add-from-buffer";
        }
    }

    private static class CopyEntry extends PrimitiveFunction implements Lambda {
        private final TarArchiveOutputStream zaos;

        public CopyEntry(TarArchiveOutputStream zaos) {
            this.zaos = zaos;
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 1);
            TarEntry e = args.get(0).getUserdata(TarEntry.class);
            try {
                synchronized (zaos) {
                    zaos.putArchiveEntry(e.entry());
                    e.file().getInputStream(e.entry()).transferTo(zaos);
                    zaos.closeArchiveEntry();
                    zaos.flush();
                }
            } catch (IOException ioException) {
                throw new RuntimeException(ioException);
            }
            return args.get(0);
        }

        @Override
        protected String name() {
            return "archive:tar:memory-writer.copy-entry";
        }
    }

    private record TarArchiveWriterUserdata(TarArchiveOutputStream archive,
                                            ByteArrayOutputStream baos) implements Userdata {
        @Override
        public Atom field(Object key) {
            if (key instanceof String) {
                switch ((String) key) {
                    case "buffer" -> {
                        try {
                            synchronized (archive) {
                                archive.flush();
                            }
                        } catch (IOException e) {
                            throw new RuntimeException(e);
                        }

                        synchronized (archive) {
                            byte[] data = baos.toByteArray();
                            return new Atom(BufferAtomList.from(data));
                        }
                    }
                    case "add-from-file" -> {
                        return new Atom(new TarAddFromFile(archive));
                    }
                    case "add-from-buffer" -> {
                        return new Atom(new TarAddFromBuffer(archive));
                    }
                    case "copy-entry" -> {
                        return new Atom(new CopyEntry(archive));
                    }
                    default -> throw new RuntimeException("archive:tar - unknown key: " + key);
                }
            } else {
                throw new RuntimeException("archive:tar:memory-writer - key must be a string");
            }
        }

        @Override
        public int compareTo(Userdata other) {
            return other.hashCode() - hashCode();
        }

        @Override
        public boolean equals(Userdata other) {
            if (other instanceof TarArchiveWriterUserdata) {
                return ((TarArchiveWriterUserdata) other).archive.equals(archive);
            } else {
                return false;
            }
        }

        @Override
        public String toDisplayString() {
            return "archive:tar:memory-writer";
        }

        @Override
        public String typeName() {
            return "archive:tar:memory-writer";
        }

        @Override
        public boolean coerceBoolean() {
            return true;
        }
    }
}
