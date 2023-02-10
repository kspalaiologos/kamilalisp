package palaiologos.kamilalisp.runtime.dataformat;

import palaiologos.kamilalisp.atom.*;

import java.util.Base64;
import java.util.List;

public class Base64Encode extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        byte[] data;
        if (args.get(0).getType() == Type.LIST) {
            data = new byte[args.get(0).getList().size()];
            for (int i = 0; i < args.get(0).getList().size(); i++)
                data[i] = args.get(0).getList().get(i).getInteger().byteValueExact();
        } else if (args.get(0).getType() == Type.STRING) {
            data = args.get(0).getString().getBytes();
        } else {
            throw new RuntimeException("codec:base64-encode not defined for: " + args.get(0).getType());
        }

        byte[] result = Base64.getEncoder().encode(data);
        return new Atom(new String(result));
    }

    @Override
    protected String name() {
        return "codec:base64-encode";
    }
}
