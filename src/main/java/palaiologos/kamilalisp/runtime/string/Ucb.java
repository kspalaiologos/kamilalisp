package palaiologos.kamilalisp.runtime.string;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

public class Ucb extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() == 1) {
            Atom arg = args.get(0);
            switch (arg.getType()) {
                case LIST -> {
                    byte[] data = new byte[arg.getList().size()];
                    for (int i = 0; i < arg.getList().size(); i++)
                        data[i] = arg.getList().get(i).getInteger().byteValueExact();
                    return new Atom(new String(data, StandardCharsets.UTF_8));
                }
                case STRING -> {
                    byte[] data2 = arg.getString().getBytes(StandardCharsets.UTF_8);
                    List<Atom> list = new ArrayList<>(data2.length);
                    for (byte b : data2)
                        list.add(new Atom(BigInteger.valueOf(b)));
                    return new Atom(list);
                }
                default -> throw new UnsupportedOperationException("ucb not defined for: " + arg.getType());
            }
        } else {
            Atom arg = args.get(0);
            String charset = args.get(1).getString();
            try {
                switch (arg.getType()) {
                    case LIST -> {
                        byte[] data = new byte[arg.getList().size()];
                        for (int i = 0; i < arg.getList().size(); i++)
                            data[i] = arg.getList().get(i).getInteger().byteValueExact();
                        return new Atom(new String(data, charset));
                    }
                    case STRING -> {
                        byte[] data2 = arg.getString().getBytes(charset);
                        List<Atom> list = new ArrayList<>(data2.length);
                        for (byte b : data2)
                            list.add(new Atom(BigInteger.valueOf(b)));
                        return new Atom(list);
                    }
                    default -> throw new UnsupportedOperationException("ucb not defined for: " + arg.getType());
                }
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }
    }

    @Override
    protected String name() {
        return "ucb";
    }
}
