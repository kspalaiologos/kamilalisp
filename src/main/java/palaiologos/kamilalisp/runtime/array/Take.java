package palaiologos.kamilalisp.runtime.array;

import com.google.common.collect.Lists;
import com.google.common.collect.Streams;
import palaiologos.kamilalisp.atom.*;

import java.util.List;
import java.util.stream.IntStream;

public class Take extends PrimitiveFunction implements Lambda {
    private static Atom take(Atom a, Atom b) {
        if(a.getType() == Type.INTEGER && b.getType() == Type.LIST) {
            int len = a.getInteger().intValueExact();
            List<Atom> list = b.getList();

            if(len < 0) {
                len = -len;
                list = Lists.reverse(list);
            }

            if(len > list.size()) {
                Atom prototype = Prototype.getPrototype(list);
                return new Atom(Streams.concat(list.stream(),
                        IntStream.generate(() -> 0)
                                .limit(len - list.size())
                                .mapToObj(x -> prototype)
                ).toList());
            } else {
                return new Atom(list.subList(0, len));
            }
        } else if(a.getType() == Type.INTEGER && b.getType() == Type.STRING) {
            int len = a.getInteger().intValueExact();
            String str = b.getString();

            if (len < 0) {
                len = -len;
                str = new StringBuilder(str).reverse().toString();
            }

            if (len > str.length()) {
                return new Atom(str + new String(new char[len - str.length()]).replace("\0", " "));
            } else {
                return new Atom(str.substring(0, len));
            }
        } else if(a.getType() == Type.LIST && b.getType() == Type.LIST) {
            return new Atom(Streams.zip(a.getList().stream(), b.getList().stream(), Take::take).toList());
        } else {
            throw new UnsupportedOperationException("take not defined for: " + a.getType() + " and " + b.getType());
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        return take(args.get(0), args.get(1));
    }

    @Override
    protected String name() {
        return "take";
    }
}
