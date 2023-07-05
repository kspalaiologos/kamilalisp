package palaiologos.kamilalisp.runtime.IO;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.runtime.sh.Wd;

import java.io.File;
import java.io.IOException;
import java.math.BigInteger;
import java.nio.file.Files;
import java.nio.file.StandardOpenOption;
import java.util.List;

public class AppendFile extends PrimitiveFunction implements Lambda {
    @Override
    protected String name() {
        return "io:file-append";
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        String fileName = args.get(0).getString();
        if (args.get(1).getType() == Type.STRING) {
            String content = args.get(1).getString();
            try {
                Files.writeString(Wd.relativeTo(fileName).toPath(), content, StandardOpenOption.APPEND);
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        } else {
            List<BigInteger> content = args.get(1).getList().stream().map(Atom::getInteger).toList();
            byte[] data = new byte[content.size()];
            for (int i = 0; i < content.size(); i++)
                data[i] = content.get(i).byteValueExact();
            try {
                Files.write(Wd.relativeTo(fileName).toPath(), data, StandardOpenOption.APPEND);
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }
        return args.get(1);
    }
}
