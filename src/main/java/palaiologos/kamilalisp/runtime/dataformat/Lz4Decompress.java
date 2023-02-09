package palaiologos.kamilalisp.runtime.dataformat;

import org.apache.commons.compress.compressors.lz4.BlockLZ4CompressorInputStream;
import palaiologos.kamilalisp.atom.*;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.util.List;

public class Lz4Decompress extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        byte[] data;
        if (args.get(0).getType() == Type.LIST) {
            data = new byte[args.get(0).getList().size()];
            for (int i = 0; i < args.get(0).getList().size(); i++)
                data[i] = args.get(0).getList().get(i).getInteger().byteValueExact();
        } else if (args.get(0).getType() == Type.STRING) {
            data = args.get(0).getString().getBytes();
        } else {
            throw new RuntimeException("codec:lz4-decompress not defined for: " + args.get(0).getType());
        }

        try {
            ByteArrayInputStream bais = new ByteArrayInputStream(data);
            BlockLZ4CompressorInputStream gcos = new BlockLZ4CompressorInputStream(bais);
            byte[] src = gcos.readAllBytes();
            gcos.close();
            bais.close();
            return new Atom(BufferAtomList.from(src));
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected String name() {
        return "codec:lz4-decompress";
    }
}
