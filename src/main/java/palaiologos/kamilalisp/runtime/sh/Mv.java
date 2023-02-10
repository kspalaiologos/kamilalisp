package palaiologos.kamilalisp.runtime.sh;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Type;
import palaiologos.kamilalisp.error.TypeError;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.List;

public class Mv extends ShellFunction {
    @Override
    protected String command() {
        return "mv";
    }

    @Override
    protected Atom execute(String flags, List<Atom> args) {
        assertArity(args, 2);
        boolean recursive = flags.contains("r");
        boolean force = flags.contains("f");

        if(args.get(0).getType() == Type.STRING && args.get(1).getType() == Type.STRING) {
            copy(args.get(0).getString(), args.get(1).getString(), recursive, force);
        } else if(args.get(0).getType() == Type.LIST && args.get(1).getType() == Type.LIST) {
            List<Atom> src = args.get(0).getList();
            List<Atom> dest = args.get(1).getList();
            if(src.size() != dest.size())
                throw new RuntimeException("Cannot move " + src.size() + " files to " + dest.size() + " destinations");
            for (int i = 0; i < src.size(); i++) {
                copy(src.get(i).getString(), dest.get(i).getString(), recursive, force);
            }
        } else if(args.get(0).getType() == Type.STRING && args.get(1).getType() == Type.LIST) {
            String src = args.get(0).getString();
            List<Atom> dest = args.get(1).getList();
            for (Atom atom : dest) {
                copy(src, atom.getString(), recursive, force);
            }
        } else if(args.get(0).getType() == Type.LIST && args.get(1).getType() == Type.STRING) {
            List<Atom> src = args.get(0).getList();
            String dest = args.get(1).getString();
            for (Atom atom : src) {
                copy(atom.getString(), dest, recursive, force);
            }
        } else {
            throw new TypeError("Cannot move " + args.get(0).getType() + " to " + args.get(1).getType());
        }

        return Atom.NULL;
    }

    private void copy(String src, String dest, boolean recursive, boolean force) {
        File srcFile = new File(src).getAbsoluteFile();
        File destFile = new File(dest).getAbsoluteFile();

        if(!srcFile.exists() && !force)
            throw new RuntimeException("File " + src + " does not exist");
        if(srcFile.isDirectory()) {
            if(!recursive)
                throw new RuntimeException("Cannot move directory " + src + " without -r flag");
            if(!destFile.exists() && !destFile.mkdirs())
                throw new RuntimeException("Could not create directory " + dest);
            File[] files = srcFile.listFiles();
            if(files == null)
                throw new RuntimeException("Could not list files in " + src);
            for (File file : files) {
                copy(file.getAbsolutePath(), destFile.getAbsolutePath() + File.pathSeparator + file.getName(), true, force);
            }
        } else {
            if(destFile.exists() && !force)
                throw new RuntimeException("File " + dest + " already exists");
            if(!destFile.getParentFile().exists() && !destFile.getParentFile().mkdirs())
                throw new RuntimeException("Could not create directory " + destFile.getParentFile().getAbsolutePath());
            try {
                Files.move(srcFile.toPath(), destFile.toPath());
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }
    }
}
