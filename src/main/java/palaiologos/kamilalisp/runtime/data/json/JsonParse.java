package palaiologos.kamilalisp.runtime.data.json;

import org.pcollections.HashTreePMap;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.runtime.hashmap.HashMapUserData;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class JsonParse extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        Atom arg = args.get(0);
        String jsondata = null;

        if(arg.getType() == Type.LIST) {
            // Assume a buffer.
            byte[] data = new byte[arg.getList().size()];
            for (int i = 0; i < arg.getList().size(); i++)
                data[i] = arg.getList().get(i).getInteger().byteValueExact();
            jsondata = new String(data, StandardCharsets.UTF_8);
        } else if(arg.getType() == Type.STRING) {
            // Assume a string.
            jsondata = arg.getString();
        } else {
            throw new RuntimeException("json:parse not defined for: " + arg.getType());
        }

        return Atom.NULL;
    }

    @Override
    protected String name() {
        return "json:parse";
    }
}
