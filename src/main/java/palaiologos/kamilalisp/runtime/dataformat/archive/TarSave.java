package palaiologos.kamilalisp.runtime.dataformat.archive;

import org.apache.commons.compress.archivers.ArchiveEntry;
import org.apache.commons.compress.archivers.tar.TarArchiveEntry;
import org.apache.commons.compress.archivers.tar.TarArchiveOutputStream;
import org.pcollections.HashPMap;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.runtime.datetime.DateTime;
import palaiologos.kamilalisp.runtime.hashmap.HashMapUserData;

import java.io.*;
import java.nio.file.attribute.FileTime;
import java.time.ZoneOffset;
import java.util.List;

public class TarSave extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        String fileName = args.get(0).getString();
        TarArchiveOutputStream archive;
        FileOutputStream fos;
        try {
            fos = new FileOutputStream(fileName);
            archive = new TarArchiveOutputStream(fos);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return new Atom(new TarArchiveWriterUserdata(archive, fos));
    }

    @Override
    protected String name() {
        return "archive:tar:save";
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
            try {
                synchronized (zaos) {
                    ArchiveEntry e = zaos.createArchiveEntry(new File(filename), entryName);
                    zaos.putArchiveEntry(e);
                    FileInputStream fis = new FileInputStream(filename);
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
            return "archive:tar:file-writer.add-from-file";
        }
    }

    private static class TarAddFromBuffer extends PrimitiveFunction implements Lambda {
        private final TarArchiveOutputStream zaos;

        public TarAddFromBuffer(TarArchiveOutputStream zaos) {
            this.zaos = zaos;
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if(args.size() < 2)
                throw new RuntimeException("archive:tar:file-writer.add-from-buffer - expected at least 2 arguments, got " + args.size());
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
                    if(args.size() == 3) {
                        HashPMap<Atom, Atom> data = args.get(2).getUserdata(HashMapUserData.class).value();
                        if(data.containsKey(new Atom("creation-time")))
                            e.setCreationTime(FileTime.from(data.get(new Atom("creation-time")).getUserdata(DateTime.class).getValue().toInstant(ZoneOffset.UTC)));
                        if(data.containsKey(new Atom("last-modified-time")))
                            e.setLastModifiedTime(FileTime.from(data.get(new Atom("last-modified-time")).getUserdata(DateTime.class).getValue().toInstant(ZoneOffset.UTC)));
                        if(data.containsKey(new Atom("last-access-time")))
                            e.setLastAccessTime(FileTime.from(data.get(new Atom("last-access-time")).getUserdata(DateTime.class).getValue().toInstant(ZoneOffset.UTC)));
                        if(data.containsKey(new Atom("mode")))
                            e.setMode(data.get(new Atom("mode")).getInteger().intValueExact());
                        if(data.containsKey(new Atom("user-name")))
                            e.setUserName(data.get(new Atom("user-name")).getString());
                        if(data.containsKey(new Atom("group-name")))
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
            return "archive:tar:file-writer.add-from-buffer";
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
            return "archive:tar:file-writer.copy-entry";
        }
    }

    private static class TarFlush extends PrimitiveFunction implements SpecialForm, ReactiveFunction {
        private final TarArchiveOutputStream zaos;
        private final FileOutputStream fos;

        public TarFlush(TarArchiveOutputStream zaos, FileOutputStream fos) {
            this.zaos = zaos;
            this.fos = fos;
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            try {
                synchronized (zaos) {
                    zaos.flush();
                    fos.flush();
                }
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
            return Atom.NULL;
        }

        @Override
        protected String name() {
            return "archive:tar:file-writer.flush";
        }
    }

    private static class TarClose extends PrimitiveFunction implements SpecialForm, ReactiveFunction {
        private final TarArchiveOutputStream zaos;
        private final FileOutputStream fos;

        public TarClose(TarArchiveOutputStream zaos, FileOutputStream fos) {
            this.zaos = zaos;
            this.fos = fos;
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            try {
                synchronized (zaos) {
                    zaos.close();
                    fos.close();
                }
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
            return Atom.NULL;
        }

        @Override
        protected String name() {
            return "archive:tar:file-writer.close";
        }
    }

    private record TarArchiveWriterUserdata(TarArchiveOutputStream archive, FileOutputStream fos) implements Userdata {
        @Override
        public Atom field(Object key) {
            if (key instanceof String) {
                switch ((String) key) {
                    case "flush" -> {
                        return new Atom(new TarFlush(archive, fos));
                    }
                    case "close" -> {
                        return new Atom(new TarClose(archive, fos));
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
                throw new RuntimeException("archive:tar:file-writer - key must be a string");
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
            return "archive:tar:file-writer";
        }

        @Override
        public String typeName() {
            return "archive:tar:file-writer";
        }

        @Override
        public boolean coerceBoolean() {
            return true;
        }
    }
}
