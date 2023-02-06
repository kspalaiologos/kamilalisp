package palaiologos.kamilalisp.runtime.array;

import com.google.common.primitives.Chars;
import org.apache.commons.lang3.StringUtils;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

public class Shuffle extends PrimitiveFunction implements Lambda {
    private static Atom shuffle(Atom a) {
        a.assertTypes(Type.LIST, Type.STRING);
        if (a.getType() == Type.LIST) {
            List<Atom> copy = new ArrayList<>(a.getList());
            Collections.shuffle(copy);
            return new Atom(copy);
        } else {
            List<Character> chars = Chars.asList(a.getString().toCharArray());
            Collections.shuffle(chars);
            return new Atom(StringUtils.join(chars.toArray()));
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.isEmpty())
            throw new TypeError("Expected 1 or more arguments to `shuffle'.");
        if (args.size() == 1)
            return shuffle(args.get(0));
        return new Atom(args.stream().map(Shuffle::shuffle).collect(Collectors.toList()));
    }

    @Override
    protected String name() {
        return "shuffle";
    }
}
