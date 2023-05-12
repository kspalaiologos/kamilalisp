package palaiologos.kamilalisp.runtime.math;

import com.google.common.collect.Streams;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class Or extends PrimitiveFunction implements Lambda {
    private static Atom or2(Atom a, Atom b) {
        if (a.getType() == Type.LIST && b.getType() == Type.LIST) {
            int len = Math.min(a.getList().size(), b.getList().size());
            ArrayList<Atom> list = new ArrayList<>(len);
            for (int i = 0; i < len; i++) {
                Atom atom = or2(a.getList().get(i), b.getList().get(i));
                list.add(atom);
            }
            return new Atom(list);
        } else {
            return new Atom(a.coerceBool() || b.coerceBool());
        }
    }

    @Override
    protected String name() {
        return "or";
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() == 2) {
            return or2(args.get(0), args.get(1));
        } else if (args.size() <= 1) {
            throw new TypeError("Expected 2 or more arguments to `or'.");
        } else {
            boolean seen = false;
            Atom acc = null;
            for (Atom arg : args) {
                if (!seen) {
                    seen = true;
                    acc = arg;
                } else {
                    acc = or2(acc, arg);
                }
            }
            return acc;
        }
    }
}
