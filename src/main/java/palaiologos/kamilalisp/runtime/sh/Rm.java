package palaiologos.kamilalisp.runtime.sh;

import palaiologos.kamilalisp.atom.Atom;

import java.io.File;
import java.util.List;

public class Rm extends ShellFunction {
    @Override
    protected String command() {
        return "rm";
    }

    @Override
    protected Atom execute(String flags, List<Atom> args) {
        assertArity(args, 1);
        boolean recursive = flags.contains("r");
        boolean force = flags.contains("f");
        String path = args.get(0).getString();
        if(!recursive) {
            File file = new File(path).getAbsoluteFile();
            if(!file.exists() && !force)
                throw new RuntimeException("File " + path + " does not exist");
            if(!file.delete() && !force)
                throw new RuntimeException("Could not delete file " + path);
        } else {
            recursiveDelete(force, new File(path).getAbsoluteFile());
        }
        return Atom.NULL;
    }

    private void recursiveDelete(boolean force, File absoluteFile) {
        if(absoluteFile.isDirectory()) {
            File[] files = absoluteFile.listFiles();
            if(files == null)
                throw new RuntimeException("Could not list files in " + absoluteFile.getAbsolutePath());
            for (File file : files) {
                recursiveDelete(force, file);
            }
        }
        if(!absoluteFile.delete() && !force)
            throw new RuntimeException("Could not delete file " + absoluteFile.getAbsolutePath());
    }
}
