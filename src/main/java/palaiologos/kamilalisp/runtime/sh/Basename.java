package palaiologos.kamilalisp.runtime.sh;

import org.apache.commons.compress.utils.FileNameUtils;
import palaiologos.kamilalisp.atom.Atom;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

public class Basename extends ShellFunction {
    @Override
    protected String command() {
        return "basename";
    }

    @Override
    protected Atom execute(String flags, List<Atom> args) {
        assertArity(args, 1);
        String path = args.get(0).toString();
        if(path.isEmpty() || path.endsWith(File.pathSeparator))
            return new Atom(args);
        String[] components = path.split(File.pathSeparator);
        String file = components[components.length - 1];
        // Extract name and extension
        String name = FileNameUtils.getBaseName(file);
        String ext = FileNameUtils.getExtension(file);
        List<Atom> result = new ArrayList<>();
        for(int i = 0; i < components.length - 1; i++)
            result.add(new Atom(components[i]));
        result.add(new Atom(name));
        result.add(new Atom(ext));
        return new Atom(result);
    }
}
