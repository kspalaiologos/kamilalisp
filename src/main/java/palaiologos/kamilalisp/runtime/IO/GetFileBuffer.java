package palaiologos.kamilalisp.runtime.IO;

import palaiologos.kamilalisp.atom.*;

import java.io.IOException;
import java.math.BigInteger;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class GetFileBuffer extends PrimitiveFunction implements Lambda {
    @Override
    protected String name() {
        return "io:get-file-buffer";
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        Atom arg = args.get(0);
        arg.assertTypes(Type.STRING);
        String fileName = arg.getString();
        try {
            byte[] data = Files.readAllBytes(Path.of(fileName));
            List<Atom> a = new ArrayList<>(data.length);
            for (byte b : data)
                a.add(new Atom(BigInteger.valueOf(b)));
            return new Atom(a);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
