package palaiologos.kamilalisp.runtime.dataformat.archive;

import org.apache.commons.compress.archivers.ArchiveEntry;
import org.apache.commons.compress.archivers.zip.ZipArchiveEntry;
import org.apache.commons.compress.archivers.zip.ZipArchiveOutputStream;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.runtime.datetime.DateTime;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.List;

public class ZipSave extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        String fileName = args.get(0).getString();
        ZipArchiveOutputStream archive;
        try {
            archive = new ZipArchiveOutputStream(new File(fileName).getAbsoluteFile());
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return new Atom(new ZipArchiveWriterUserdata(archive));
    }

    @Override
    protected String name() {
        return "archive:zip:save";
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
            return "archive:zip:file-writer.set-level";
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
            return "archive:zip:file-writer.set-comment";
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
                    ZipArchiveEntry e = zaos.createArchiveEntry(f, entryName);
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
            return "archive:zip:file-writer.add-from-file";
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
                throw new RuntimeException("archive:zip:file-writer.add-from-buffer - expected at least 2 arguments, got " + args.size());
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
                        e.setTimeLocal(args.get(0).getUserdata(DateTime.class).value());
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
            return "archive:zip:file-writer.add-from-buffer";
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
            return "archive:zip:file-writer.copy-entry";
        }
    }

    private static class ZipFlush extends PrimitiveFunction implements SpecialForm, ReactiveFunction {
        private final ZipArchiveOutputStream zaos;

        public ZipFlush(ZipArchiveOutputStream zaos) {
            this.zaos = zaos;
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            try {
                synchronized (zaos) {
                    zaos.flush();
                }
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
            return Atom.NULL;
        }

        @Override
        protected String name() {
            return "archive:zip:file-writer.flush";
        }
    }

    private static class ZipClose extends PrimitiveFunction implements SpecialForm, ReactiveFunction {
        private final ZipArchiveOutputStream zaos;

        public ZipClose(ZipArchiveOutputStream zaos) {
            this.zaos = zaos;
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            try {
                synchronized (zaos) {
                    zaos.close();
                }
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
            return Atom.NULL;
        }

        @Override
        protected String name() {
            return "archive:zip:file-writer.close";
        }
    }

    private record ZipArchiveWriterUserdata(ZipArchiveOutputStream archive) implements Userdata {
        @Override
        public Atom field(Object key) {
            if (key instanceof String) {
                switch ((String) key) {
                    case "flush" -> {
                        return new Atom(new ZipFlush(archive));
                    }
                    case "close" -> {
                        return new Atom(new ZipClose(archive));
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
                throw new RuntimeException("archive:zip:file-writer - key must be a string");
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
            return "archive:zip:file-writer";
        }

        @Override
        public String typeName() {
            return "archive:zip:file-writer";
        }

        @Override
        public boolean coerceBoolean() {
            return true;
        }
    }
}
