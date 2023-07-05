package palaiologos.kamilalisp.runtime.sh;

import palaiologos.kamilalisp.atom.Atom;

import java.io.File;
import java.io.IOException;
import java.nio.file.*;
import java.nio.file.attribute.BasicFileAttributes;
import java.util.ArrayList;
import java.util.List;

public class Glob extends ShellFunction {
    @Override
    protected String command() {
        return "glob";
    }

    @Override
    protected Atom execute(String flags, List<Atom> args) {
        // strip all ./'s at the beginning. for each ../ at the beginning of the path increment p.
        String pat = args.get(0).getString();
        int p = 0;
        while (pat.startsWith(".")) {
            if (pat.startsWith("../")) {
                p++;
                pat = pat.substring(3);
            } else if (pat.startsWith("./")) {
                p++;
                pat = pat.substring(2);
            } else {
                break;
            }
        }

        final PathMatcher pathMatcher = FileSystems.getDefault().getPathMatcher("glob:" + args.get(0).getString());
        List<Atom> files = new ArrayList<>();

        try {
            File fCwd = Wd.get();
            for (int i = 0; i < p; i++) {
                fCwd = fCwd.getParentFile();
            }
            Path cwd = fCwd.toPath();
            Files.walkFileTree(cwd, new SimpleFileVisitor<>() {
                @Override
                public FileVisitResult visitFile(Path path, BasicFileAttributes attrs) {
                    Path p = cwd.relativize(path);
                    if (pathMatcher.matches(p)) {
                        files.add(new Atom(p.toString()));
                    }

                    return FileVisitResult.CONTINUE;
                }

                @Override
                public FileVisitResult visitFileFailed(Path file, IOException exc) {
                    return FileVisitResult.CONTINUE;
                }
            });
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return new Atom(files);
    }
}
