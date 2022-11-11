package palaiologos.kamilalisp.runtime.array;

import com.google.common.collect.Lists;
import com.google.common.collect.Streams;
import palaiologos.kamilalisp.atom.*;

import java.util.List;

public class Drop extends PrimitiveFunction implements Lambda {
    private static Atom drop(Atom a, Atom b) {
        if (a.getType() == Type.INTEGER && b.getType() == Type.LIST) {
            int len = a.getInteger().intValueExact();
            List<Atom> list = b.getList();
            boolean doReverse = false;

            if (len < 0) {
                len = -len;
                list = Lists.reverse(list);
                doReverse = true;
            }

            if (len >= list.size()) {
                return Atom.NULL;
            } else {
                List<Atom> l = list.subList(len, list.size());
                return new Atom(doReverse ? Lists.reverse(l) : l);
            }
        } else if (a.getType() == Type.INTEGER && b.getType() == Type.STRING) {
            int len = a.getInteger().intValueExact();
            String str = b.getString();
            boolean doReverse = false;

            if (len < 0) {
                len = -len;
                str = new StringBuilder(str).reverse().toString();
                doReverse = true;
            }

            if (len >= str.length()) {
                return Atom.NULL;
            } else {
                if (doReverse)
                    return new Atom(new StringBuilder(str.substring(len)).reverse().toString());
                else
                    return new Atom(str.substring(len));
            }
        } else if (a.getType() == Type.LIST && b.getType() == Type.LIST) {
            return new Atom(Streams.zip(a.getList().stream(), b.getList().stream(), Drop::drop).toList());
        } else {
            throw new UnsupportedOperationException("drop not defined for: " + a.getType() + " and " + b.getType());
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        return drop(args.get(0), args.get(1));
    }

    @Override
    protected String name() {
        return "drop";
    }
}
