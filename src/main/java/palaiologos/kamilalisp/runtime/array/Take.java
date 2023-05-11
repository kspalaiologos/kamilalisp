package palaiologos.kamilalisp.runtime.array;

import com.google.common.collect.Lists;
import com.google.common.collect.Streams;
import palaiologos.kamilalisp.atom.*;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.IntStream;

public class Take extends PrimitiveFunction implements Lambda {
    private static Atom take(Atom a, Atom b) {
        if (a.getType() == Type.INTEGER && b.getType() == Type.LIST) {
            int len = a.getInteger().intValueExact();
            List<Atom> list = b.getList();
            boolean doReverse = false;

            if (len < 0) {
                len = -len;
                list = Lists.reverse(list);
                doReverse = true;
            }

            if (len > list.size()) {
                Atom prototype = Prototype.getPrototype(list);
                List<Atom> result = new ArrayList<>(list);
                for(int i = 0; i < len - list.size(); i++)
                    result.add(prototype);
                return new Atom(doReverse ? Lists.reverse(result) : result);
            } else {
                List<Atom> l = list.subList(0, len);
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

            if (len > str.length()) {
                if (doReverse)
                    return new Atom(new StringBuilder(str)
                            .append(new String(new char[len - str.length()])
                                    .replace("\0", " "))
                            .reverse().toString());
                else
                    return new Atom(str + new String(new char[len - str.length()]).replace("\0", " "));
            } else {
                if (doReverse)
                    return new Atom(new StringBuilder(str.substring(0, len)).reverse().toString());
                else
                    return new Atom(str.substring(0, len));
            }
        } else if (a.getType() == Type.LIST && b.getType() == Type.LIST) {
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
