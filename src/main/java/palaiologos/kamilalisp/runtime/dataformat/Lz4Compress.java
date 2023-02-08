package palaiologos.kamilalisp.runtime.dataformat;

import org.apache.commons.compress.compressors.bzip2.BZip2CompressorOutputStream;
import org.apache.commons.compress.compressors.lz4.BlockLZ4CompressorOutputStream;
import palaiologos.kamilalisp.atom.*;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.List;

public class Lz4Compress extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        byte[] data;
        if(args.get(0).getType() == Type.LIST) {
            data = new byte[args.get(0).getList().size()];
            for(int i = 0; i < args.get(0).getList().size(); i++)
                data[i] = args.get(0).getList().get(i).getInteger().byteValueExact();
        } else if(args.get(0).getType() == Type.STRING) {
            data = args.get(0).getString().getBytes();
        } else {
            throw new RuntimeException("codec:lz4-compress not defined for: " + args.get(0).getType());
        }

        try {
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            BlockLZ4CompressorOutputStream gcos = new BlockLZ4CompressorOutputStream(baos);
            gcos.write(data);
            gcos.flush();
            gcos.close();
            byte[] compressed = baos.toByteArray();
            baos.close();
            return new Atom(BufferAtomList.from(compressed));
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected String name() {
        return "codec:lz4-compress";
    }
}
