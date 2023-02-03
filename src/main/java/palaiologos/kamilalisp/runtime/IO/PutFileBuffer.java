package palaiologos.kamilalisp.runtime.IO;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.io.IOException;
import java.math.BigInteger;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;

public class PutFileBuffer extends PrimitiveFunction implements Lambda {
    @Override
    protected String name() {
        return "io:put-file-buffer";
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        String fileName = args.get(0).getString();
        List<BigInteger> content = args.get(1).getList().stream().map(Atom::getInteger).toList();
        byte[] data = new byte[content.size()];
        for (int i = 0; i < content.size(); i++)
            data[i] = content.get(i).byteValueExact();
        try {
            Files.write(Path.of(fileName), data);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return args.get(1);
    }
}
