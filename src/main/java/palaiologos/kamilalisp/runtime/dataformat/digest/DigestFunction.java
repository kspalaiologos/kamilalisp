package palaiologos.kamilalisp.runtime.dataformat.digest;

import palaiologos.kamilalisp.atom.*;

import java.util.List;

public abstract class DigestFunction extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        return new Atom(args.stream().map(this::digest).toList());
    }

    private Atom digest(Atom a) {
        if(a.getType() == Type.STRING)
            return new Atom(digest(a.getString()));
        else if(a.getType() == Type.LIST) {
            byte[] data = new byte[a.getList().size()];
            for(int i = 0; i < data.length; i++)
                data[i] = a.getList().get(i).getInteger().byteValue();
            return new Atom(digest(data));
        }
        else
            throw new RuntimeException(name() + ": unsupported type: " + a.getType());
    }

    // Digest-specific code:
    abstract String digest(String s);
    abstract String digest(byte[] data);
}
