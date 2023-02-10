package palaiologos.kamilalisp.runtime.dataformat.archive;

import org.apache.commons.compress.archivers.ArchiveEntry;
import org.apache.commons.compress.archivers.zip.ZipArchiveEntry;
import org.apache.commons.compress.archivers.zip.ZipArchiveOutputStream;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.runtime.dataformat.BufferAtomList;
import palaiologos.kamilalisp.runtime.datetime.DateTime;

import java.io.*;
import java.util.List;

public class ZipCreate extends PrimitiveFunction implements ReactiveFunction, SpecialForm {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ZipArchiveOutputStream archive = new ZipArchiveOutputStream(baos);
        return new Atom(new ZipArchiveWriterUserdata(archive, baos));
    }

    @Override
    protected String name() {
        return "archive:zip:create";
    }

    private static class SetLevel extends PrimitiveFunction implements Lambda {
        private final ZipArchiveOutputStream zaos;

        public SetLevel(ZipArchiveOutputStream zaos) {
            this.zaos = zaos;
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 1);
            int level = args.get(0).getInteger().intValueExact();
            synchronized (zaos) {
                zaos.setLevel(level);
            }
            return args.get(0);
        }

        @Override
        protected String name() {
            return "archive:zip:memory-writer.set-level";
        }
    }

    private static class SetComment extends PrimitiveFunction implements Lambda {
        private final ZipArchiveOutputStream zaos;

        public SetComment(ZipArchiveOutputStream zaos) {
            this.zaos = zaos;
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 1);
            String comment = args.get(0).getString();
            synchronized (zaos) {
                zaos.setComment(comment);
            }
            return args.get(0);
        }

        @Override
        protected String name() {
            return "archive:zip:memory-writer.set-comment";
        }
    }

    private static class ZipAddFromFile extends PrimitiveFunction implements Lambda {
        private final ZipArchiveOutputStream zaos;

        public ZipAddFromFile(ZipArchiveOutputStream zaos) {
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
            return "archive:zip:memory-writer.add-from-file";
        }
    }

    private static class ZipAddFromBuffer extends PrimitiveFunction implements Lambda {
        private final ZipArchiveOutputStream zaos;

        public ZipAddFromBuffer(ZipArchiveOutputStream zaos) {
            this.zaos = zaos;
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() < 2)
                throw new RuntimeException("archive:zip:memory-writer.add-from-buffer - expected at least 2 arguments, got " + args.size());
            List<Atom> buffer = args.get(0).getList();
            String entryName = args.get(1).getString();
            byte[] buf = new byte[buffer.size()];
            for (int i = 0; i < buffer.size(); i++) {
                buf[i] = buffer.get(i).getInteger().byteValueExact();
            }
            try {
                synchronized (zaos) {
                    ByteArrayInputStream bais = new ByteArrayInputStream(buf);
                    ZipArchiveEntry e = new ZipArchiveEntry(entryName);
                    if (args.size() == 3)
                        e.setTimeLocal(args.get(2).getUserdata(DateTime.class).value());
                    zaos.addRawArchiveEntry(e, bais);
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
            return "archive:zip:memory-writer.add-from-buffer";
        }
    }

    private static class CopyEntry extends PrimitiveFunction implements Lambda {
        private final ZipArchiveOutputStream zaos;

        public CopyEntry(ZipArchiveOutputStream zaos) {
            this.zaos = zaos;
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 1);
            ZipEntry e = args.get(0).getUserdata(ZipEntry.class);
            try {
                synchronized (zaos) {
                    zaos.addRawArchiveEntry(e.entry(), e.file().getRawInputStream(e.entry()));
                    zaos.flush();
                }
            } catch (IOException ioException) {
                throw new RuntimeException(ioException);
            }
            return args.get(0);
        }

        @Override
        protected String name() {
            return "archive:zip:memory-writer.copy-entry";
        }
    }

    private record ZipArchiveWriterUserdata(ZipArchiveOutputStream archive,
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
                    case "set-level" -> {
                        return new Atom(new SetLevel(archive));
                    }
                    case "set-comment" -> {
                        return new Atom(new SetComment(archive));
                    }
                    case "add-from-file" -> {
                        return new Atom(new ZipAddFromFile(archive));
                    }
                    case "add-from-buffer" -> {
                        return new Atom(new ZipAddFromBuffer(archive));
                    }
                    case "copy-entry" -> {
                        return new Atom(new CopyEntry(archive));
                    }
                    default -> throw new RuntimeException("archive:zip - unknown key: " + key);
                }
            } else {
                throw new RuntimeException("archive:zip:memory-writer - key must be a string");
            }
        }

        @Override
        public int compareTo(Userdata other) {
            return other.hashCode() - hashCode();
        }

        @Override
        public boolean equals(Userdata other) {
            if (other instanceof ZipArchiveWriterUserdata) {
                return ((ZipArchiveWriterUserdata) other).archive.equals(archive);
            } else {
                return false;
            }
        }

        @Override
        public String toDisplayString() {
            return "archive:zip:memory-writer";
        }

        @Override
        public String typeName() {
            return "archive:zip:memory-writer";
        }

        @Override
        public boolean coerceBoolean() {
            return true;
        }
    }
}
