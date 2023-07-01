package palaiologos.kamilalisp.runtime.sh;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Type;
import palaiologos.kamilalisp.error.TypeError;
import palaiologos.kamilalisp.runtime.datetime.DateTime;

import java.io.File;
import java.io.IOException;
import java.math.BigInteger;
import java.nio.file.Files;
import java.nio.file.attribute.BasicFileAttributes;
import java.time.ZoneOffset;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Ls extends ShellFunction {
    @Override
    protected String command() {
        return "ls";
    }

    @Override
    protected Atom execute(String flags, List<Atom> args) {
        boolean h = flags.contains("h"); // With -l and/or -s, print human readable sizes (e.g., 1K 234M 2G)
        boolean l = flags.contains("l"); // Use a long listing format
        boolean t = flags.contains("t"); // Print extra times (creation, access).

        List<File> files = new ArrayList<>();
        if (args.size() == 0) {
            listFiles(files, ".");
        } else if (args.size() == 1) {
            Atom arg = args.get(0);
            if (arg.getType() == Type.STRING) {
                listFiles(files, arg.getString());
            } else if (arg.getType() == Type.LIST) {
                for (Atom atom : arg.getList()) {
                    if (atom.getType() != Type.STRING)
                        throw new TypeError("Invalid argument in sh:ls, unexpected " + atom.getType());
                    listFiles(files, atom.getString());
                }
            } else {
                throw new TypeError("Invalid argument in sh:ls, unexpected " + arg.getType());
            }
        }

        List<Atom> output = new ArrayList<>();
        if (l) {
            for (File file : files) {
                String name = file.getName();
                long size = file.length();
                boolean readable = file.canRead();
                boolean writable = file.canWrite();
                boolean executable = file.canExecute();
                String permissions = (readable ? "r" : "-") + (writable ? "w" : "-") + (executable ? "x" : "-");
                DateTime creationTime, modificationTime, accessTime;
                try {
                    BasicFileAttributes attr =
                            Files.readAttributes(file.getAbsoluteFile().toPath(), BasicFileAttributes.class);
                    creationTime = new DateTime(attr.creationTime().toInstant().atZone(ZoneOffset.UTC).toLocalDateTime());
                    modificationTime = new DateTime(attr.lastModifiedTime().toInstant().atZone(ZoneOffset.UTC).toLocalDateTime());
                    accessTime = new DateTime(attr.lastAccessTime().toInstant().atZone(ZoneOffset.UTC).toLocalDateTime());
                } catch (IOException e) {
                    throw new RuntimeException(e);
                }
                if (file.isDirectory())
                    name += "/";
                if (h) {
                    String sizeStr;
                    if (size < 1024)
                        sizeStr = size + "B";
                    else if (size < 1024 * 1024)
                        sizeStr = size / 1024 + "K";
                    else if (size < 1024 * 1024 * 1024)
                        sizeStr = size / (1024 * 1024) + "M";
                    else
                        sizeStr = size / (1024 * 1024 * 1024) + "G";
                    List<Atom> properties;
                    if (t) {
                        properties = List.of(
                                new Atom(name),
                                new Atom(sizeStr),
                                new Atom(permissions),
                                new Atom(creationTime),
                                new Atom(modificationTime),
                                new Atom(accessTime)
                        );
                    } else {
                        properties = List.of(
                                new Atom(name),
                                new Atom(sizeStr),
                                new Atom(permissions),
                                new Atom(modificationTime)
                        );
                    }
                    output.add(new Atom(properties));
                } else {
                    List<Atom> properties;
                    if (t) {
                        properties = List.of(
                                new Atom(name),
                                new Atom(BigInteger.valueOf(size)),
                                new Atom(permissions),
                                new Atom(creationTime),
                                new Atom(modificationTime),
                                new Atom(accessTime)
                        );
                    } else {
                        properties = List.of(
                                new Atom(name),
                                new Atom(BigInteger.valueOf(size)),
                                new Atom(permissions),
                                new Atom(modificationTime)
                        );
                    }
                    output.add(new Atom(properties));
                }
            }
        } else {
            for (File file : files) {
                output.add(new Atom(file.getName()));
            }
        }

        return new Atom(output);
    }

    private void listFiles(List<File> files, String s) {
        File file = Wd.relativeTo(s);
        if (!file.exists())
            throw new RuntimeException("File " + s + " does not exist");
        if (file.isDirectory()) {
            File[] files1 = file.listFiles();
            if (files1 == null)
                throw new RuntimeException("Cannot list files in " + s);
            files.addAll(Arrays.asList(files1));
        } else {
            files.add(file);
        }
    }
}
